#!/usr/bin/perl
#
# Jeremy Chartier, <jeremy.chartier@free.fr>
# Date: 10/01/2011
# Revision: 2.4.3
# 

#
# Main variables
#
$domains_file = "conf/domains"; $DOMAINS = 1;		# Path to find Domain file
$rules_file = "conf/rules"; $RULES = 1;				# Path to find Rules file
$hw_file = "conf/hw"; $HW = 1;						# Path to find Hardware file
$lang_file ="conf/lang"; $LANG = 1;					# Path to find Language file
$picts_dir ="picts"; $PICTS = 1;					# Path to find pictures HTML files 
#$html_directory = "temp/";							# Default output directorys (HTML output exclusively)
$dbm_directory = "temp/";							# Default output directorys (HTML output exclusively)
$tmpout_file = "temp/.snortalog.tmp";				# Default tempory file (GUI exclusively)

#
# Modules requirement
# Detect specific logs - Comment unnecessary log detectection
#
require "modules/input/ipf_log.snortalog";
require "modules/input/pf_log.snortalog";
require "modules/input/netfilter_log.snortalog";
require "modules/input/pix_log.snortalog";
require "modules/input/brickexport_log.snortalog";
require "modules/input/fw1export_log.snortalog";
require "modules/input/fw1syslog_log.snortalog";
require "modules/input/fw1fwlog_log.snortalog";
require "modules/input/fw1fwtab_log.snortalog";
require "modules/input/snortfast_log.snortalog";
require "modules/input/snortsyslog_log.snortalog";
require "modules/input/snortfull_log.snortalog";
require "modules/input/barnyardsyslog_log.snortalog";
require "modules/input/barnyardfast_log.snortalog";
require "modules/input/netscreen_log.snortalog";
require "modules/input/tippingpoint_log.snortalog";
#
# SnortALog additionnal plugins - Do not comment
#
require "modules/other/gui.snortalog";
require "modules/other/whois.snortalog";
require "modules/other/init_graph.snortalog";
require "modules/other/init_pdf.snortalog";
require "modules/other/usage.snortalog";
require "modules/other/process_data.snortalog";
require "modules/other/x_process_data.snortalog";
require "modules/other/x_load_filter.snortalog";
require "modules/other/undef_tables.snortalog";
#
# SnortALog output plugins - Do not comment
#
require "modules/output/daily_event.snortalog";
require "modules/output/severity.snortalog";
require "modules/output/nids.snortalog";
require "modules/output/interfaces.snortalog";
require "modules/output/proto.snortalog";
require "modules/output/same_src_attack.snortalog";
require "modules/output/same_dst_attack.snortalog";
require "modules/output/same_src_dst_attack.snortalog";
require "modules/output/same_src_dst_dport.snortalog";
require "modules/output/same_src_dst_action.snortalog";
require "modules/output/same_src_dst_reason.snortalog";
require "modules/output/attack.snortalog";
require "modules/output/same_class.snortalog";
require "modules/output/attack_src.snortalog";
require "modules/output/attack_dst.snortalog";
require "modules/output/domain_src.snortalog";
require "modules/output/hour.snortalog";
require "modules/output/same_hour_attack.snortalog";
require "modules/output/dport.snortalog";
require "modules/output/dport_attack.snortalog";
require "modules/output/actions.snortalog";
require "modules/output/reasons.snortalog";
require "modules/output/rules.snortalog";
require "modules/output/forward.snortalog";
require "modules/output/fw1_defense_attack.snortalog";
require "modules/output/pix_hwlog.snortalog";
require "modules/output/pix_idslog.snortalog";
require "modules/output/netscreen_systemlog.snortalog";
require "modules/output/typelog.snortalog";
require "modules/output/same_src_dport.snortalog";
require "modules/output/same_dst_dport.snortalog";
require "modules/output/portscan.snortalog";
require "modules/output/report.snortalog";
require "modules/output/x_report.snortalog";





#
# User variables
# General Libraries - Never comment
#
use Getopt::Long;						# use Getopt for options
use Term::ANSIColor qw(:constants);		# use Term Color
use Env;								# use Env for variables
use Socket;								# use socket for resolving domain name from IP
use File::Path;
use Time::localtime;					# use for Time
eval "use Net::Whois::IP;";				# use whois.pm for Whois Database Informations
use threads;							# use Thread to improve performance

#
# Allow SnortALog to find its modules when starting in a different directory
#
use FindBin;
use lib $FindBin::Bin;

#
# Graphical Tool Kit Libraries
#
$TK = 0 ;
$TK = eval "use Tk;1;" ;
$TK = eval "use Tk::NoteBook;2;" if ($TK == 1);
$TK = eval "use Tk::Dialog;3;" if ($TK == 2);

#
# GD Libraries for charts
#
$GD = 0 ;
$GD = eval "use GD::Graph::pie;1;";
$GD = eval "use GD::Graph::bars;2;" if ($GD == 1);
$GD = eval "use GD::Graph::lines;3;" if ($GD == 2);
$GD = eval "use GD::Graph::area;4;" if ($GD == 3);

#
# Don't set the graph colors if graphing is not enabled
#
if ( $GD ) {
	use GD::Graph::colour;
	GD::Graph::colour::add_colour(jred => [255,0,0]); 
	GD::Graph::colour::add_colour('#ff0000'); 
}

#
# HTML and PDF manipulation libraries
#
$HTML = 0 ;
$HTML =  eval "use HTML::HTMLDoc; 1;"; 




#
# Style variables
#
$background = "#FFFFFF";      # Sets html background color (#CCCCCC)
                              # or background image (url('path_to_image/image.gif')
$font = "sans-serif";         # Sets html font-type (serif)
$color = "#000000";           # Sets html font color (#000000)
$border = "1";                # Sets border for data tables (1 = yes, 0 = no)
$th_bg_color = "#006666";     # Sets html table header background color (#FFCC99)
$th_color = "#FFFFFF";        # Sets html table header font color (black)
$tb_bg_color = "#FFFFFF";     # Sets html table body background color (#FFFFFF)
$tb_color = "#000000";        # Sets html table body font color (#000000)
$anchor = "#000000";          # Sets html anchor style
$graph_fgcolor = "gray";      # Sets graph foreground color (axes and grid) (blue)
$transparent = "1";           # Sets graph transparency (1 = yes, 0 = no)
$graph_bgcolor = "#EEEEEE";   # Sets graph background color (transparency must be 0)
$graph_txtcolor = "#006666";  # Sets graph labelclr, axislabelclr, legendclr, textclr
                              # label (labels for the axes or pie),
                              # axis label (values printed along the axes, or on a pie slice),
                              # legend, shown values, and
                              # text, all other text.

#
# Program variables (DON'T TOUCH ANYTHING)
#
$addr_len = 15;
$zone_len = 12;
$nb_len = 6;
$port_len = 5;
$attack_len = 70;
$class_len = 60;
$resolve_len = 50;
$whois_len = 109;
$inetnum_len = 33;
$netname_len = 30;
$descr_len = 20;
$country_len = 20;
$email_len = 20;
$hour_len = 2;
$graph_len = 50;
$prior_len = 1;
$sever_len = 7;
$domain_len = 10;
$ether_len = 10;
$version = "2.4.3";
$datever = "10/01/2011 22:13:45";
my $date = ctime();
my $maxday = 1; my $maxmonth = 1; my $maxhour = 0; my $maxmin = 0; my $maxsec = 0;
my $minday = 31; my $minmonth = 12; my $minhour = 23; my $minmin = 59; my $minsec = 59;
$total_log = 0;
$total_hw = 0;
$total_s300 = 0;
$total_s301 = 0;
$logfw = 0;
$logids = 0;
$logpix = 0;
$lognetscreen = 0;
$logportscan = 0;
$graph_date = `date +%Y%m%d%H%M`;
chomp $graph_date;


Getopt::Long;
GetOptions( \%opt,
	#
	# MAIN OPTIONS
	#
	'd',
	'r',
	'i',
	'c',
	'x',
	's',
	'a',
	'w',
	'g=s',
	'o=s',
	'n=i',
	'l=s',
	#
	# ALERT OPTIONS
	#
	'all',
	'1',
	'2',
	'3',
	'4',
	'5',
	'6',
	'7',
	'8',
	'9',
	'10',
	'11',
	'12',
	'13',
	'14',
	'15',
	'16',
	#
	# Filter Options
	#
	'fsrc=s',
	'fdst=s',
	'fdport=s',
	'fether=s',
	'fhour=s',
	'fday=s',
	'fmonth=s',
	'fhost=s',
	'fseverity=s',
	'fproto=s',
	'faction=s',
	'frule=s',
	'ftype=s',
	'fclass=s',
	'file=s',
	#
	# Reports Options
	#
	'class',
	'src',
	'dst',
	'class_attack',
	'attack',
	'dport',
	'dport_attack',
	'nids',
	'interfaces',
	'severity',
	'src_attack',
	'dst_attack',
	'hour',
	'proto',
	'forward',
	'hour_attack',
	'daily_event',
	'domain_src',
	'src_dst_attack',
	'src_dst_dport',
	'src_dst_action',
	'src_dst_reason',
	'portscan',
	'priority',
	'src_dport',
	'dst_dport',
	'rules',
	'defense_attack',
	'typelog',
	'hwlog',
	'reasons',
	'actions',
	'report',
	#
	# Input Files Options
	#
	'rulesfile=s',
	'pictsdir=s',
	'hwfile=s',
	'domainsfile=s',
	'langfile=s',
	'genref=s'
	) or usage();

#
# Disable control caracters if in ascii mode only
#
if ($opt{a}) {
	$ENV{ANSI_COLORS_DISABLED}='yes' ;
}

if ( $opt{rulesfile} ) {
	$rules_file = $opt{rulesfile}; $RULES = 1;		# Path to find Rules file
}

if ( $opt{hwfile} ) {
	$hw_file = $opt{hwfile}; $HW = 1;			# Path to find hardawre file
}

if ( $opt{domainsfile} ) {
	$domains_file = $opt{domainsfile}; $DOMAINS = 1;	# Path to find Domain file
}

if ( $opt{langfile} ) {
	$lang_file = $opt{langfile}; $LANG = 1;			# Path to find Lang file
}

if ( $opt{pictsdir} ) {
	$picts_dir = $opt{pictsdir}; $PICTS = 1;		# Path to find pictures HTML file
}

init_proto();
init_monthday();
init_daymonth();
init_pixlog();
init_lang();
init_domains() if ( $DOMAINS == 1 );
init_rules() if ( $RULES == 1 );
init_hw() if ( $HW == 1 );



if ($opt{x}) {
	#
	# If GUI mode is selected
	#
	gui();
} else { 
	#
	# If TEXT mode
	# Part 2 : Work in progress
	#
	# Initialize variables
	#
	$opt_i = 0;
	$opt_r = 0;
	$opt_w = 0;
	$opt_o = 0;
	$opt_g = 0;
	$opt_d = 0;
	$opt_c = 0;
	$opt_n = 0;
	$opt_l = 0;
	$opt_all = 0;
	$opt_1 = 0;
	$opt_2 = 0;
	$opt_3 = 0;
	$opt_4 = 0;
	$opt_5 = 0;
	$opt_6 = 0;
	$opt_7 = 0;
	$opt_8 = 0;
	$opt_9 = 0;
	$opt_10 = 0;
	$opt_11 = 0;
	$opt_12 = 0;
	$opt_13 = 0;
	$opt_14 = 0;
	$opt_15 = 0;
	$opt_16 = 0;
	$opt_fproto = 0;
	$opt_fsrc = 0;
	$opt_fdst = 0;
	$opt_fdport = 0;
	$opt_fether = 0;
	$opt_fhour = 0;
	$opt_fday = 0;
	$opt_fmonth = 0;
	$opt_fhost = 0;
	$opt_fseverity = 0;
	$opt_faction = 0;
	$opt_freason = 0;
	$opt_frule = 0;
	$opt_ftype = 0;
	$opt_fclass = 0;
	$opt_filter = 0;
	$opt_i = 1 if $opt{i}; 
	$opt_r = 1 if $opt{r}; 
	$opt_w = 1 if $opt{w}; 
	$opt_o = 1 if $opt{o}; 
	$opt_d = 1 if $opt{d}; 
	$opt_g = 1 if $opt{g}; 
	$opt_c = 1 if $opt{c}; 
	$opt_n = 1 if $opt{n}; 
	$opt_l = 1 if $opt{l}; 
	$opt_all = 1 if $opt{all}; 
	$opt_1 = 1 if $opt{1};
	$opt_2 = 1 if $opt{2};
	$opt_3 = 1 if $opt{3};
	$opt_4 = 1 if $opt{4};
	$opt_5 = 1 if $opt{5};
	$opt_6 = 1 if $opt{6};
	$opt_7 = 1 if $opt{7};
	$opt_8 = 1 if $opt{8};
	$opt_9 = 1 if $opt{9};
	$opt_10 = 1 if $opt{10};
	$opt_11 = 1 if $opt{11};
	$opt_12 = 1 if $opt{12};
	$opt_13 = 1 if $opt{13};
	$opt_14 = 1 if $opt{14};
	$opt_15 = 1 if $opt{15};
	$opt_16 = 1 if $opt{16};
	$opt_fproto = 1 if $opt{fproto}; 
	$opt_fsrc = 1 if $opt{fsrc}; 
	$opt_fdst = 1 if $opt{fdst}; 
	$opt_fdport = 1 if $opt{fdport}; 
	$opt_fether = 1 if $opt{fether}; 
	$opt_fhour = 1 if $opt{fhour}; 
	$opt_fday = 1 if $opt{fday}; 
	$opt_fmonth = 1 if $opt{fmonth}; 
	$opt_fhost = 1 if $opt{fhost}; 
	$opt_fseverity = 1 if $opt{fseverity}; 
	$opt_faction = 1 if $opt{faction}; 
	$opt_freason = 1 if $opt{freason}; 
	$opt_frule = 1 if $opt{frule}; 
	$opt_ftype = 1 if $opt{ftype}; 
	$opt_fclass = 1 if $opt{fclass}; 
	$opt_filter = 1 if ( ($opt_fproto || $opt_fsrc || $opt_fdst || $opt_fdport || $opt_fether || $opt_fhour || $opt_fday || $opt_fmonth || $opt_fhost || $opt_fseverity || $opt_faction || $opt_freason || $opt_frule || $opt_ftype || $opt_fclass) == 1 ); 
	$val_opt_n = $opt{n} if ( $opt_n == 1 ); 
	$val_opt_o = $opt{o} if ( $opt_o == 1 ); 
	$val_opt_g = $opt{g} if ( $opt_g == 1 ); 
	$val_opt_l = $opt{l} if ( $opt_l == 1 ); 
	#
	# Test if kind of logs are selected else all arent chosen by default
	#
	if ( ! ($opt{1} || $opt{2} || $opt{3} || $opt{4} || $opt{5} || $opt{6} || $opt{7} || $opt{8} || $opt{9} || $opt{10} || $opt{11} || $opt{12} || $opt{13} || $opt{14} || $opt{15} || $opt{16} ) ) {
		$opt_all = 1;
	} else {
		$opt_all = 0;
	}
	#
	# Test if language option is used else English is selected by default
	#
	if ( $opt_l == 1 ) {
		$val_opt_l = $opt{l}; 
	} else {
		$val_opt_l = "en"; 
	}
	$val_opt_fproto = $opt{fproto} if ( $opt_fproto == 1 );
	$val_opt_fsrc = $opt{fsrc} if ( $opt_fsrc == 1 );
	$val_opt_fdst = $opt{fdst} if ( $opt_fdst == 1 );
	$val_opt_fdport = $opt{fdport} if ( $opt_fdport == 1 );
	$val_opt_fether = $opt{fether} if ( $opt_fether == 1 );
	$val_opt_fhour = $opt{fhour} if ( $opt_fhour == 1 );
	$val_opt_fday = $opt{fday} if ( $opt_fday == 1 );
	$val_opt_fmonth = $opt{fmonth} if ( $opt_fmonth == 1 );
	$val_opt_fhost = $opt{fhost} if ( $opt_fhost == 1 );
	$val_opt_fseverity = $opt{fseverity} if ( $opt_fseverity == 1 );
	$val_opt_faction = $opt{faction} if ( $opt_faction == 1 );
	$val_opt_freason = $opt{freason} if ( $opt_freason == 1 );
	$val_opt_frule = $opt{frule} if ( $opt_frule == 1 );
	$val_opt_ftype = $opt{ftype} if ( $opt_ftype == 1 );
	$val_opt_fclass = $opt{fclass} if ( $opt_fclass == 1 );
	$val_opt_file = $opt{file} if ( $opt{file} );
	if ( $opt{o} ) {
		$filename = $val_opt_o;
		$filename =~ /\.(\w+)$/;
		$filetype = $1;
		if ( $filename =~ /(^\/[\/||\w||\d||\-||\_]+\/)[\w||\d||\-||\_]+\.\w+$/ ) {
			$filedir = $1;
		} elsif ( $filename =~ /^[\w||\d||\-||\_]+\.\w+$/ ) {
			$filedir = ".";
		}
		$filename =~ /([\w||\d||\-||\_]+\.\w+)$/;
		$filename = $1;
		#
		# Initialize border when PDF output is selected
		#
		$border = 1 if ( $filetype eq "pdf");
	}
	
	
	
	
	#
	# Part 2 : Work in progress
	#
	# Test if genref option is used
	# to generate a RULE file
	#
	if ( $opt{genref} ) {
		load();
		print "The Signature Rules File was generated successfully : $opt{genref}\n";
		exit;
	} else {
		#
		# Lod input file line per line
		#
		if ( $opt{file} ) {
			x_load();
		} else {
			load();
		}
		#
		# Test if filter option is selected
		#
		search_filter() if ( $opt_filter == 1 );
		print_head();
		print_summary();
		#
		# Test if a specific report is selected
		#

		#if ( $opt{dst} ) { my $Thread3 = threads->create(\&attack_src); $Thread3->detach(); };		
		#if ( $opt{dst} ) { my $Thread2 = threads->create(\&attack_dst); $Thread2->detach(); };
		if ( $opt{src} ) { attack_src() };
		if ( $opt{dst} ) { attack_dst() };
		if ( $opt{src_attack} ) { same_src_attack() };
		if ( $opt{dst_attack} ) { same_dst_attack() };
		if ( $opt{src_dst_attack} ) { same_src_dst_attack() };
		if ( $opt{src_dst_dport} ) { same_src_dst_dport() };
		if ( $opt{src_dst_action} ) { same_src_dst_action() };
		if ( $opt{src_dst_reason} ) { same_src_dst_reason() };
		if ( $opt{attack} ) { attack() };
		if ( $opt{class} ) { same_class() };
		if ( $opt{severity} ) { severity() };
		if ( $opt{daily_event} ) { daily_event() if ($minmonth ne $maxmonth) || ($minday < $maxday) };
		if ( $opt{hour} ) { hour() };
		if ( $opt{forward} ) { forward() };
		if ( $opt{hour_attack} ) { same_hour_attack() };
		if ( $opt{dport} ) { dport() };
		if ( $opt{dport_attack} ) { dport_attack() };
		if ( $opt{nids} ) { nids() if (keys(%s13) > 1) };
		if ( $opt{domain_src} ) { domain_src() };
		if ( $opt{proto} ) { proto() };
		if ( $opt{portscan} ) { portscan() if ( keys(%s25) > 0 ) };
		if ( $opt{interfaces} ) { interfaces() if ( keys(%s1) > 1 ) };
		if ( $opt{reasons} ) { reasons() if ( keys(%s12) > 1 ) };
		if ( $opt{actions} ) { actions() if ( keys(%s14) > 1 ) };
		if ( $opt{rules} ) { rules() if ( keys(%s21) > 1 ) };
		if ( $opt{defense_attack} ) { defense_attack() if ( keys(%s24) > 0 ) };
		if ( $opt{typelog} ) { typelog() };
		if ( $opt{hwlog} ) { hwlog() };
		if ( $opt{src_dport} ) { same_src_dport() };
		if ( $opt{dst_dport} ) { same_dst_dport() };
		#
		# Else full report are activated
		#
		if ( $opt{report} ) {
			report();
		}
		print_footer();
		#
		# Test if PDF option are selectionned
		#
		init_pdf() if ( $opt{o} && ($filetype eq 'pdf') );
	}
}





sub get_opt {
	#
	# Initialize variables
	# GUI exclusively
	#
	$opt_x = 1;
	$opt_n = 0;
	$opt_i = $opti;
	$opt_r = $optr;
	$opt_w = $optw;
	$opt_o = 0;
	$opt_n = 1 if ( $scale_n->get() != 0 );
	$opt_d = $optd;
	$opt_c = $optc;
	$val_opt_n = $scale_n->get() if ( $opt_n == 1 );
	$opt_o = 1 if ($entry_option_o->get() ne "");
	$val_opt_o = $entry_option_o->get() if ($opt_o == 1);
	$val_opt_langfile = $entry_langfile_directory->get();
	$val_opt_fsrc = $entry_fsrc->get();
	$val_opt_fdst = $entry_fdst->get();
	$val_opt_fdport = $entry_fdport->get();
	$val_opt_fether = $entry_fether->get();
	$val_opt_fhour = $entry_fhour->get();
	$val_opt_fday = $entry_fday->get();
	$val_opt_fmonth = $entry_fmonth->get();
	$val_opt_fhost = $entry_fhost->get();
	$val_opt_fseverity = $entry_fseverity->get();
	$val_opt_faction = $entry_faction->get();
	$val_opt_freason = $entry_freason->get();
	$val_opt_frule = $entry_frule->get();
	$val_opt_ftype = $entry_ftype->get();
	$val_opt_fclass = $entry_fclass->get();
	$val_opt_fproto = $entry_fproto->get();
	$opt_fproto = 0;
	$opt_fsrc = 0;
	$opt_fdst = 0;
	$opt_fdport = 0;
	$opt_fether = 0;
	$opt_fhour = 0;
	$opt_fday = 0;
	$opt_fmonth = 0;
	$opt_fhost = 0;
	$opt_fseverity = 0;
	$opt_faction = 0;
	$opt_freason = 0;
	$opt_frule = 0;
	$opt_ftype = 0;
	$opt_fclass = 0;
	$opt_filter = $optfilter; 
	$opt_fproto = 1 if ( $val_opt_fproto ne "" ); 
	$opt_fsrc = 1 if ( $val_opt_fsrc ne "" );
	$opt_fdst = 1 if ( $val_opt_fdst ne "" ); 
	$opt_fdport = 1 if ( $val_opt_fdport ne "" );
	$opt_fether = 1 if ( $val_opt_fether ne "" );
	$opt_fhour = 1 if ( $val_opt_fhour ne "" );
	$opt_fday = 1 if ( $val_opt_fday ne "" );
	$opt_fmonth = 1 if ( $val_opt_fmonth ne "" );
	$opt_fhost = 1 if ( $val_opt_fhost ne "" );
	$opt_fseverity = 1 if ( $val_opt_fseverity ne "" );
	$opt_faction = 1 if ( $val_opt_faction ne "" );
	$opt_freason = 1 if ( $val_opt_freason ne "" );
	$opt_frule = 1 if ( $val_opt_frule ne "" );
	$opt_ftype = 1 if ( $val_opt_ftype ne "" );
	$opt_fclass = 1 if ( $val_opt_fclass ne "" );
	$opt_fproto = 1 if ( $val_opt_fproto ne "" );
	$val_opt_fsrc = $entry_fsrc->get() if ( $opt_fsrc == 1 );
	$val_opt_fdst = $entry_fdst->get() if ( $opt_fdst == 1 );
	$val_opt_fdport = $entry_fdport->get() if ( $opt_fdport == 1 );
	$val_opt_fether = $val_opt_fether if ( $opt_fether == 1 );
	$val_opt_fhour = $val_opt_fhour if ( $opt_fhour == 1 );
	$val_opt_fday = $val_opt_fday if ( $opt_fday == 1 );
	$val_opt_fmonth = $val_opt_fmonth if ( $opt_fmonth == 1 );
	$val_opt_fhost = $entry_fhost->get() if ( $opt_fhost == 1 );
	$val_opt_fseverity = $entry_fseverity->get() if ( $opt_fseverity == 1 );
	$val_opt_faction = $entry_faction->get() if ( $opt_faction == 1 );
	$val_opt_freason = $entry_freason->get() if ( $opt_freason == 1 );
	$val_opt_frule = $entry_frule->get() if ( $opt_frule == 1 );
	$val_opt_ftype = $entry_ftype->get() if ( $opt_ftype == 1 );
	$val_opt_fclass = $entry_fclass->get() if ( $opt_fclass == 1 );
	$scrolled_debug->delete('1.0','end');
	$opt_all = $optall;
	$opt_1 = $opt1;
	$opt_2 = $opt2;
	$opt_3 = $opt3;
	$opt_4 = $opt4;
	$opt_5 = $opt5;
	$opt_6 = $opt6;
	$opt_7 = $opt7;
	$opt_8 = $opt8;
	$opt_9 = $opt9;
	$opt_10 = $opt10;
	$opt_11 = $opt11;
	$opt_12 = $opt12;
	$opt_13 = $opt13;
	$opt_14 = $opt14;
	$opt_15 = $opt15;
	$opt_16 = $opt16;	#
	# Test if kind of logs are selected else all arent chosen by default
	#
	if ( ($opt1 || $opt2 || $opt3 || $opt4 || $opt5 || $opt6 || $opt7 || $opt8 || $opt_9 ||  $opt_10 ||  $opt_11 ||  $opt_12 ||  $opt_13 ||  $opt_14 ||  $opt_15 || $opt_16 ) != 1 ) {
		$opt_all = 1;
	} else {
		$opt_all = 0;
	}

	$domains_file = $entry_domains_file->get();
	$rules_file = $entry_rules_file->get();
	$hw_file = $entry_hw_file->get();
	#
	# Extract the name of output file for graph file name
	#
	$graph_name = $val_opt_o;
	$graph_name =~ /^([\w||\d]+)/;
	$graph_name = $1;
	# for intialize border in PDF
	$border = 1 if ( $filetype eq 'pdf' );
	#
	# For initialize configuration files
	#
	if ( $rules_file ne "" ) {
		$RULES = 1;		# Path to find Rules file
	}
	if ( $hw_file ne "" ) {
		$HW = 1;		# Path to find hardawre file
	}
	if ( $domains_file ne "" ) {
		$DOMAINS = 1;		# Path to find Domain file
	}
	init_domains() if ( $DOMAINS == 1 );
	init_rules() if ( $RULES == 1 );
	init_hw() if ( $HW == 1 );
}




sub x_load {
	$logtotal = 0;
	$logdrop = 0;
	$logfw = 0;
	$logids = 0;
	if ( ! $opt{file} ) {
		get_opt();
		$val_opt_file = $top-> getOpenFile ( -title => 'Load Log File');
	}
	open (FILE, $val_opt_file) or die;
	while (<FILE>) {
		search_log($_);
	}
	close (FILE);

	if ( ! $opt{file} ) {
		#
		# Special Part for adding data in filter
		#
		for $i ( 0 .. $#result ) {
			x_process_data();
		}
		x_load_filter();
		x_readystatusbar();
		++$nb_files; $listbox_load->insert('end', $nb_files ." - ". $val_opt_file ."\n") if $opt{x};
		x_unloadstatusbar();
		$statusbar->insert('0','Log File Loaded');
	}
}








sub search_log {
	my $alert = {};
	chomp;
	$PIX = 0;
	#
	# If the line is blank, go to the next one
	#
	next if $_ eq "";
	++$logtotal;

	$snortfast = 0;	
	$snortfull = 0;	
	$snortsyslog = 0;	
	$barnyardsyslog = 0;	
	$barnyardfast = 0;	
	$fw1syslog = 0;	
	$fw1fwlog = 0;	
	$fw1fwtab = 0;	
	$fw1export = 0;	
	$brickexport = 0;	
	$pix = 0;	
	$netscreen = 0;	
	$tippingpoint = 0;	
	$ipfilter = 0;	
	$pfilter = 0;	
	$netfilter = 0;	
	$idslog = 0;
	$systemlog = 0;
	$fwlog = 0;

	#
	# Erase this string if facility is used in :
	# 1- SNORT CONFIGURATION FILE
	# 2- FW-1 SYSLOG LOG
	#
	s/\[ID\s+\d+\s+\S+]\s+//ox;

	#
	# This is all available log detection
	#
	ipf_log() if ( ($opt_7 == 1) || ($opt_all == 1) );
	pf_log() if ( ($opt_10 == 1) || ($opt_all == 1) );
	netfilter_log() if ( ($opt_8  == 1) || ($opt_all == 1) );
	pix_log() if ( ($opt_6 == 1) || ($opt_all == 1) );
	brickexport_log() if ( ($opt_11 == 1) || ($opt_all == 1) );
	fw1export_log() if ( ($opt_4 == 1) || ($opt_all == 1) );
	fw1syslog_log() if ( ($opt_5 == 1) || ($opt_all == 1) );
	snortfast_log() if ( ($opt_1 == 1) || ($opt_all == 1) );
	snortsyslog_log() if ( ($opt_2 == 1) || ($opt_all == 1) );
	snortfull_log() if ( ($opt_3 == 1) || ($opt_all == 1) );
	barnyardsyslog_log() if ( ($opt_9 == 1) || ($opt_all == 1) );
	barnyardfast_log() if ( ($opt_12 == 1) || ($opt_all == 1) );
	netscreen_log() if ( ($opt_13 == 1) || ($opt_all == 1) );
	tippingpoint_log() if ( ($opt_16 == 1) || ($opt_all == 1) );
	fw1fwlog_log() if ( ($opt_14 == 1) || ($opt_all == 1) );
	fw1fwtab_log() if ( ($opt_15 == 1) || ($opt_all == 1) );
	#
	# If a log message has been repeated several times
	#
	if ($lastwassnort && $_ =~ m/last message repeated (\d+) times/) {
		$repeats = $1;
		while ($repeats) {
			push @result, $result[-1];
			$repeats--;
		}
	#
	# Else, this is not a matched SnortALog log 
	#
	} else {
		if ($opt_d == 1) {
			print STDERR "Log not recognized --> $_\n" if ( ($opt_x != 1) && ($snortfast || $snortsyslog || $snortfull || $fw1syslog || $fw1export || $fw1fwlog || $fw1fwtab || $pix || $netscreen || $tippingpoint || $ipfilter || $pfilter || $netfilter || $barnyardsyslog || $barnyardfast) == 0 );
	        	$scrolled_debug->insert('end', "Log not recognized --> $_\n") if ( ($opt_x == 1) && ($snortfast || $snortsyslog || $snortfull || $fw1syslog || $fw1export || $fw1fwlog || $fw1fwtab || $pix || $netscreen || $tippingpoint || $ipfilter || $pfilter ||  $netfilter || $barnyardsyslog || $barnyardfast) == 0 );
		}
		++$logdrop if ( ($snortfast || $snortsyslog || $snortfull || $fw1syslog || $fw1export || $fw1fwlog || $fw1fwtab || $pix || $netscreen || $tippingpoint || $ipfilter || $pfilter || $netfilter || $barnyardsyslog || $barnyardfast) == 0 );
	 	$lastwassnort = 0;
	}
}





sub clear_screen {
	$scrolled_result->delete('1.0','end');
}


sub reset_filter {
	my $entry_fproto->delete('0.0','end'); 
	$entry_fsrc->delete('0.0','end');
	$entry_fdst->delete('0.0','end');
	$entry_fdport->delete('0.0','end');
	$entry_fether->delete('0.0','end');
	$entry_fhour->delete('0.0','end');
	$entry_fday->delete('0.0','end');
	$entry_fmonth->delete('0.0','end');
	$entry_fsrc->delete('0.0','end');
	$entry_fhost->delete('0.0','end');
	$entry_fseverity->delete('0.0','end');
	$entry_faction->delete('0.0','end');
	$entry_freason->delete('0.0','end');
	$entry_frule->delete('0.0','end');
	$entry_ftype->delete('0.0','end');
	$entry_fclass->delete('0.0','end');
}


sub x_popup {
}

sub x_unloadstatusbar {
	$statusbar->delete('0.0','end');
}

sub x_readystatusbar {
	$statusbar->delete('0.0','end');
	$statusbar->insert('0','Ready');
}

sub x_unload {
	#
	# Undef variables
	#
	undef @result;
	undef_tables();
	$listbox_load->delete('0.0','end');
	# Initialize variables before xload function
	$nb_files = 0;
	$logtotal = 0;
	$logdrop = 0;
	$logfw = 0;
	$logpix = 0;
	$lognetscreen = 0;
	$logids = 0;
	$total_log = 0;
	$total_hw = 0;
	$total_s300 = 0;
	$total_s301 = 0;
	$logportscan = 0;
	$maxday = 1; $maxmonth = 1; $maxhour = 0; $maxmin = 0; $maxsec = 0;
	$minday = 31; $minmonth = 12; $minhour = 23; $minmin = 59; $minsec = 59;
}


sub x_daily_event {
	get_opt();
	x_report();
	daily_event();
}

sub x_severity {
	get_opt();
	x_report();
	severity();
}

sub x_interfaces {
	get_opt();
	x_report();
	interfaces();
}

sub x_nids {
	get_opt();
	x_report();
	nids();
}

sub x_proto {
	get_opt();
	x_report();
	proto();
}

sub x_src_dst_attack {
	get_opt();
	x_report();
	same_src_dst_attack();
}

sub x_src_dst_dport {
	get_opt();
	x_report();
	same_src_dst_dport();
}

sub x_src_dst_action {
	get_opt();
	x_report();
	same_src_dst_action();
}

sub x_src_dst_reason {
	get_opt();
	x_report();
	same_src_dst_reason();
}

sub x_forward {
	get_opt();
	x_report();
	forward();
}

sub x_src_attack {
	get_opt();
	x_report();
	same_src_attack();
}

sub x_dst_attack {
	get_opt();
	x_report();
	same_dst_attack();
}

sub x_attack {
	get_opt();
	x_report();
	attack();
}

sub x_attack_src {
	get_opt();
	x_report();
	attack_src();
}

sub x_attack_dst {
	get_opt();
	x_report();
	attack_dst();
}

sub x_domain_src {
	get_opt();
	x_report();
	domain_src();
}

sub x_hour {
	get_opt();
	x_report();
	hour();
}

sub x_class {
	get_opt();
	x_report();
	same_class();
}

sub x_same_hour_attack {
	get_opt();
	x_report();
	same_hour_attack();
}

sub x_dport {
	get_opt();
	x_report();
	dport();
}

sub x_dport_attack {
	get_opt();
	x_report();
	dport_attack();
}


sub x_portscan {
	get_opt();
	x_report();
	portscan();
}


sub x_actions {
	get_opt();
	x_report();
	actions();
}


sub x_reasons {
	get_opt();
	x_report();
	reasons();
}


sub x_rules {
	get_opt();
	x_report();
	rules();
}


sub x_src_dport {
	get_opt();
	x_report();
	same_src_dport();
}


sub x_defense_attack {
	get_opt();
	x_report();
	defense_attack();
}


sub x_dst_dport {
	get_opt();
	x_report();
	same_dst_dport();
}









sub load {	
$logtotal = 0;
$logdrop = 0;
$logfw = 0;
$logids = 0;
if ( $opt{genref} ) {
	open(RULES,">$opt{genref}") or die "Can not open domain file: $opt{genref} $!\n";
	while (<>) {
		next if ($_ eq "" or /^#/);
		if ( $_ =~ m/reference/ox ) {
			$_ =~ s/^alert\s(\w+)\s.+\s.+\>\s.+\s.+\(msg\:\"([^\"|^\"]*?)\".+reference\://x;
			$PROTO = $1; $PROTO =~ tr/A-Z/a-z/; $SIG = $2;
			$_ = ";$_";
			$_ =~ s/^\;([^\;|^\;]*?)\;.*$//x;
			$REF = $1;
			print RULES ("$SIG {$PROTO}\t\t$REF\n");
		}
	}
	close (RULES);
} else {	
	#
	# PROCESS WHATEVER COMES IN
	#
	while (<>) {
		search_log($_);
	}
}
}





sub print_head {
$kindlog = "IDS" if ( $logids > 0 );
$kindlog = "Firewall" if ( $logfw > 0 );
my $title = $lang{"title_". $val_opt_l};
	if ( $opt_o == 1 ) {
		$filename = $val_opt_o;
		$filename =~ /\.(\w+)$/;
		$filetype = $1;
		$filename =~ /([\w||\d||\-||\_]+\.\w+)$/;
		$filename = $1;
		$graph_name = $val_opt_o;
		$graph_name =~ /^([\w||\d||\-||\_]+)/;
		$graph_name = $1;
	open (FILEOUT, ">$val_opt_o") or die "Can no access file : $val_opt_o\n";
	print FILEOUT ("<HTML>\n<HEAD>\n");
	print FILEOUT ("<meta http-equiv='Content-Type' content='text/html; charset=ISO-8859-1'>\n");
	print FILEOUT ("<meta name='description' content='HTML report generated by SnortALog - Jeremy Chartier'>\n");
	print FILEOUT ("<meta name='keywords' content='snort,snortalog,fw1,fw-1,pix,netscreen,tippingpoint,barnyard,brick,checkpoint,lucent,ipfilter,pfilter,netfilter,packetfilter'>\n");
	print FILEOUT ("<TITLE>SnortALog V$version</TITLE>\n");
	print FILEOUT ("<STYLE TYPE='text/css'>\n");
	print FILEOUT ("\t.color1 { color: #cc0000 }\n");
	print FILEOUT ("\t.color2 { color: #cc9999 }\n");
	print FILEOUT ("\t.sizeLarge { font-size: 1.2em; }\n");
	print FILEOUT ("\t.sizeExtraLarge { font-size: 1.7em; }\n");
	print FILEOUT ("\t.sizeSmall { font-size: 0.9em; }\n");
	print FILEOUT ("\t/* Table Header */\n") if ( $opt_o == 1 );
	print FILEOUT ("\t.TH { font-family: Verdana,Arial,Helvetica,sans-serif; font-size: 10px; background-color: $th_bg_color; color: $th_color; font-weight: bold; }\n") if ( $opt_o == 1 );
	print FILEOUT ("\t/* Table body */\n") if ( $opt_o == 1 );
	print FILEOUT ("\t.TB { color: $tb_color; background-color: $tb_bg_color; font-size: 10px; }\n") if ( $opt_o == 1 );
	print FILEOUT ("\t/* Table body RED*/\n") if ( $opt_o == 1 );
	print FILEOUT ("\t.TBR { color: #FF0000; background-color: $tb_bg_color; font-size: 10px; }\n") if ( $opt_o == 1 );
	print FILEOUT ("\t/* Table body ORANGE*/\n") if ( $opt_o == 1 );
	print FILEOUT ("\t.TBG { color: #FFA500; background-color: $tb_bg_color; font-size: 10px; }\n") if ( $opt_o == 1 );
	print FILEOUT ("\tA { color: $anchor; }\n") if ( $opt_o == 1 );
	print FILEOUT ("\tDIV { width: 100%; text-align: center; color: white; background-color: #006666; font-size: 24px; }\n") if ( $opt_o == 1 );
	print FILEOUT ("</STYLE>\n</HEAD>\n");

	#
	# BORDER OF HTML PAGE
	#
	print FILEOUT ("<body leftmargin='0' topmargin='0' background='$picts_dir/bg.gif' bgcolor='#ffffff' marginheight='0' marginwidth='0'>\n");

	#
	# CORE OF HTML PAGE
	#
	print FILEOUT ("<table align='center' border='0' cellpadding='0' cellspacing='0' width='840'>\n");
	

	if ( $filetype ne 'pdf' ) {
		print FILEOUT ("<tbody><tr>\n");
		print FILEOUT ("<td width='30'><img src='$picts_dir/p_01.gif' height='80' width='30'></td>\n");
		print FILEOUT ("<td align='left' background='$picts_dir/p_02.gif' valign='top' width='240'><B class='sizeLarge'>$kindlog $title $date</B></TD>\n");
#		print FILEOUT ("<h3>$kindlog $title $date</h3><BR></TD>\n");
		print FILEOUT ("<td align='right' background='$picts_dir/p_02.gif' valign='bottom' width='440'><b class='color1'><span class='SizeExtraLarge'>SnortALog</span></b></td>\n");
		print FILEOUT ("<td width='170'><img src='$picts_dir/p_03.gif' height='80' width='170'></td>\n");
		print FILEOUT ("<td width='30'><img src='$picts_dir/p_04.gif' height='80' width='30'></td>\n");
		print FILEOUT ("</tr></tbody></table>\n");
		print FILEOUT ("\n");
		print FILEOUT ("<table align='center' border='0' cellpadding='0' cellspacing='0' width='840'>\n");
		print FILEOUT ("<tbody><tr>\n");
		print FILEOUT ("<td background='$picts_dir/p_26.jpg' valign='top' width='30'><img src='$picts_dir/p_05.jpg' height='254' width='30'></td>\n");
		print FILEOUT ("<td background='$picts_dir/p_22.gif' valign='top'>\n");
		print FILEOUT ("<br><table align='center' border='0' cellpadding='0' cellspacing='0' width='98%'>\n");
		print FILEOUT ("<tbody><tr><td>\n");
		print FILEOUT ("\n");
		print FILEOUT ("\n");
	}


} else {
	if ( !$opt{x} ) {			### IF GUI X
		print "subject: $kindlog $title $date\n"; 
	}
}
}


sub print_summary {
	# Heade variables
	my $head1 = $lang{"head1_". $val_opt_l};
	my $head2 = $lang{"head2_". $val_opt_l};
	my $head3 = $lang{"head3_". $val_opt_l};
	my $head4 = $lang{"head4_". $val_opt_l};
	my $head5 = $lang{"head5_". $val_opt_l};
	my $head6 = $lang{"head6_". $val_opt_l};
	my $head7 = $lang{"head7_". $val_opt_l};
	my $head8 = $lang{"head8_". $val_opt_l};
	my $head9 = $lang{"head9_". $val_opt_l};
	my $head10 = $lang{"head10_". $val_opt_l};
	my $head11 = $lang{"head11_". $val_opt_l};
	my $head12 = $lang{"head12_". $val_opt_l};
	my $head13 = $lang{"head13_". $val_opt_l};
	# Comment variables
	my $legende_red = $lang{"legendered_". $val_opt_l};
	my $legende_orange = $lang{"legendeorange_". $val_opt_l};
	my $legende_black = $lang{"legendeblack_". $val_opt_l};

	if ( $opt_o == 1 ) {
		print FILEOUT ("<TABLE BORDER=0 ALIGN=CENTER WIDTH=95%><TR><TD><TABLE BORDER=0><TR><TD WIDTH=65%>");
		print FILEOUT ("<TABLE VALIGN=top>\n");
		print FILEOUT ("<TR ALIGN=left><TH>$head1</TH>");
		print FILEOUT ("<TD>$daymonth{$minmonth} $minday $minhour\:$minmin\:$minsec</TD></TR>\n");
		print FILEOUT ("<TR ALIGN=left><TH>$head2</TH>");
		print FILEOUT ("<TD>$daymonth{$maxmonth} $maxday $maxhour\:$maxmin\:$maxsec</TD></TR>\n");
		print FILEOUT ("<TR><TD></TD></TR>\n");
		print FILEOUT ("<TR ALIGN=left><TH>$head3</TH>");
		print FILEOUT ("<TD>$logtotal</TD></TR>\n");
		if ( $logdrop > 0 ) {
			print FILEOUT ("<TR ALIGN=left><TH>$head4</TH>");
			printf FILEOUT ("<TD>%d (%2.2f%)</TD></TR>\n",$logdrop,$logdrop/$logtotal*100);
		}
		print FILEOUT ("<TR><TD></TD></TR>\n");
		print FILEOUT ("<TR ALIGN=left><TH>$head13</TH><TD>$filter</TD></TR>\n") if ( ($filter ne "") && ($opt_filter == 1) );
		print FILEOUT ("<TR><TD></TD></TR>\n");
		print FILEOUT ("<TR ALIGN=left><TH>$head5</TH>");
		print FILEOUT ("<TD>$total_log</TD></TR>\n");
		print FILEOUT ("<TR ALIGN=left><TH>$head6</TH>");
		print FILEOUT ("<TD>". keys(%s5) ."</TD></TR>\n");
		print FILEOUT ("<TR ALIGN=left><TH>$head7</TH>");
		print FILEOUT ("<TD>". keys(%s6) ."</TD></TR>\n");
		print FILEOUT ("<TR><TD></TD></TR>\n");
		if ( $logids > 1 ) {
			print FILEOUT ("<TR ALIGN=left><TH>$head8</TH>");
			print FILEOUT ("<TD>". keys(%s13) ." with ". keys(%s1) . " interface(s)</TD></TR>\n");
			print FILEOUT ("<TR ALIGN=left><TH>$head9</TH>");
			print FILEOUT ("<TD>". keys(%s4) ."<TD></TR>\n");
			print FILEOUT ("<TR ALIGN=left><TH>$head10</TH>");
			print FILEOUT ("<TD>". keys(%s10) ."</TD></TR>\n");
			print FILEOUT ("<TR ALIGN=left><TH>$head11</TH>");
			print FILEOUT ("<TD>". keys(%s20) ."</TD></TR>\n");
			print FILEOUT ("<TR ALIGN=left><TH>$head12</TH>");
			print FILEOUT ("<TD>$logportscan</TD></TR>\n");
		}
		if ( $logfw > 1 ) {
			print FILEOUT ("<TR ALIGN=left><TH>$head8</TH>");
			print FILEOUT ("<TD>". keys(%s13) ." with ". keys(%s1) . " interface(s)</TD></TR>\n");
		}
		print FILEOUT ("</TABLE>\n");
		
		print FILEOUT ("</TD><TD VALIGN=top>\n");
	
		print FILEOUT ("<TABLE>\n");
		print FILEOUT ("<TR ALIGN=left><TH>Domains File : </TH>");
		print FILEOUT ("<TD>". $domains_file ."</TD></TR>\n");
		print FILEOUT ("<TR ALIGN=left><TH>Number of domains : </TH>");
		print FILEOUT ("<TD>". keys(%DomainName) ."</TD></TR>\n");
		print FILEOUT ("<TR ALIGN=left><TH>Rules File : </TH>");
		print FILEOUT ("<TD>". $rules_file ."</TD></TR>\n");
		print FILEOUT ("<TR ALIGN=left><TH>Number of referenced rules : </TH>");
		print FILEOUT ("<TD>". keys(%link) ."</TD></TR>\n");
		print FILEOUT ("</TD></TABLE></TABLE></TABLE><BR>\n");

		print FILEOUT ("<TABLE BORDER=0 ALIGN=CENTER>\n");
#		print FILEOUT ("<TR ALIGN=left><TD WIDTH=12%><B><U>Legend :</U></B></TD><TD WIDTH=12%></TD><TD></TD></TR>\n");
		print FILEOUT ("<TR ALIGN=left><TD WIDTH=12%></TD><TD WIDTH=12%><FONT COLOR=#FF0000>RED :</FONT></TD><TD>$legende_red</TD></TR>\n");
		print FILEOUT ("<TR ALIGN=left><TD WIDTH=12%></TD><TD WIDTH=12%><FONT COLOR=#FFA500>ORANGE :</FONT></TD><TD>$legende_orange</TD></TR>\n");
		print FILEOUT ("<TR ALIGN=left><TD WIDTH=12%></TD><TD WIDTH=12%>BLACK :</TD><TD>$legende_black</TD></TR>\n");
		print FILEOUT ("</TABLE><BR>\n");

	} else {
		if ( $opt{x} ) {			### IF GUI X
			$scrolled_result->insert ('end', "$head1 $daymonth{$minmonth} $minday $minhour\:$minmin\:$minsec\n");
			$scrolled_result->insert ('end', "$head2 $daymonth{$maxmonth} $maxday $maxhour\:$maxmin\:$maxsec\n");
			$scrolled_result->insert ('end', "\n");
			$scrolled_result->insert ('end', "$head3 $logtotal\n");
			$scrolled_result->insert ('end', "$head4 ". $logdrop ." (". $logdrop/$logtotal*100 ."%)\n") if ( $logdrop > 0 );
			$scrolled_result->insert ('end', "\n");
			$scrolled_result->insert ('end', "$head13 $filter\n") if ( ($filter ne "") && ($opt_filter == 1) );
			$scrolled_result->insert ('end', "\n");
			$scrolled_result->insert ('end', "$head5 $total_log\n");
			$scrolled_result->insert ('end', "$head6 ". keys(%s5) ."\n");
			$scrolled_result->insert ('end', "$head7 ". keys(%s6) ."\n");
			$scrolled_result->insert ('end', "\n");
			if ( $logids > 1 ) {
				$scrolled_result->insert ('end', "$head8 ". keys(%s13) ." with ". keys(%s1) ." interface(s)\n");
				$scrolled_result->insert ('end', "$head9 ". keys(%s4) ."\n");
				$scrolled_result->insert ('end', "$head10 ". keys(%s10) ."\n");
				$scrolled_result->insert ('end', "$head11 ". keys(%s20) ."\n");
				$scrolled_result->insert ('end', "$head12 $logportscan\n");
				$scrolled_result->insert ('end', "\n");
			}
			if ( $logfw > 1 ) {
				$scrolled_result->insert ('end', "$head8 ". keys(%s13) ." with ". keys(%s1) ." interface(s)\n");
				$scrolled_result->insert ('end', "\n");
			}
		} else {
			chomp $minmonth;
			chomp $maxmonth;
			print BOLD, "$head1 $daymonth{$minmonth} $minday $minhour\:$minmin\:$minsec\n", RESET;
			print BOLD, "$head2 $daymonth{$maxmonth} $maxday $maxhour\:$maxmin\:$maxsec\n", RESET;
			print "\n";
			print "$head3 $logtotal\n";
			if ( $logdrop > 0 ) {
				print ("$head4 %d (%5.2f",$logdrop,$logdrop/$logtotal*100);
				print "%)\n";
			}
			print "\n";
			print "$head13 $filter\n" if ( ($filter ne "") && ($opt_filter == 1) );
			print "\n";
			print BOLD,"$head5 $total_log\n", RESET;
			print "$head6 ". keys(%s5) ."\n" if ( keys(%s5) > 0 );
			print "$head7 ". keys(%s6) ."\n" if ( keys(%s6) > 0 );
			print "\n";
			if ( $logids > 1 ) {
				print "$head8 ". keys(%s13) ." with ". keys(%s1) ." interface(s)\n";
				print "$head9 ". keys(%s4) ."\n";
				print "$head10 ". keys(%s10) ."\n";
				print "$head11 ". keys(%s20) ."\n";
				print "$head12 $logportscan\n";
			}
			if ( $logfw > 1 ) {
				print "$head8 ". keys(%s13) ." with ". keys(%s1) ." interface(s)\n";
			}
		}
	}
}









# print menu for HTML page
sub print_menu {
my $description = $lang{"s19_". $val_opt_l};
	if ( ( $opt_o == 1 ) || ( $filetype ne 'pdf') ) {
		print FILEOUT ("<TABLE BORDER=0 ALIGN=CENTER><TR ALIGN=left><TD WIDTH=40% VALIGN=top>\n");
		print FILEOUT ("<h4>General Statistics</h4>\n<menu>\n");
		print FILEOUT ("<li><a href=\"#hour\">". $lang{"s7_". $val_opt_l} ."</a>\n");
		print FILEOUT ("<li><a href=\"#daily_event\">". $lang{"s19_". $val_opt_l} ."</a>\n") if ($minmonth ne $maxmonth) || ($minday < $maxday);
		print FILEOUT ("<li><a href=\"#nids\">". $lang{"s13_". $val_opt_l} ."</a>\n") if (keys(%s13) > 1);
		print FILEOUT ("<li><a href=\"#domain_src\">". $lang{"s40_". $val_opt_l} ."</a>\n") if ( $opt{c} );
		print FILEOUT ("<li><a href=\"#attack_src\">". $lang{"s5_". $val_opt_l} ."</a>\n");
		print FILEOUT ("<li><a href=\"#attack_dst\">". $lang{"s6_". $val_opt_l} ."</a>\n");
		print FILEOUT ("<li><a href=\"#dport\">". $lang{"s16_". $val_opt_l} ."</a>\n");
		print FILEOUT ("<li><a href=\"#proto\">". $lang{"s11_". $val_opt_l} ."</a>\n");
		print FILEOUT ("<li><a href=\"#interfaces\">". $lang{"s1_". $val_opt_l} ."</a>\n") if (keys(%s1) > 1);
		print FILEOUT ("<li><a href=\"#typelog\">". $lang{"s17_". $val_opt_l} ."</a>\n</menu>") if (keys(%s17) > 0);	
		print FILEOUT ("</TD><TD WIDTH=60% VALIGN=top>\n");
		
		print FILEOUT ("<h4>Specific Statistics</h4><menu>\n");
		if ( $logfw gt 0 ) {	
			print FILEOUT ("<li><a href=\"#same_src_dport\">". $lang{"s22_". $val_opt_l} ."</a>\n");
			print FILEOUT ("<li><a href=\"#same_dst_dport\">". $lang{"s23_". $val_opt_l} ."</a>\n");
			print FILEOUT ("<li><a href=\"#same_src_dst_dport\">". $lang{"s29_". $val_opt_l} ."</a>\n");
			print FILEOUT ("<li><a href=\"#same_src_dst_action\">". $lang{"s30_". $val_opt_l} ."</a>\n");
			print FILEOUT ("<li><a href=\"#same_src_dst_reason\">". $lang{"s31_". $val_opt_l} ."</a>\n");
			print FILEOUT ("<li><a href=\"#reasons\">". $lang{"s12_". $val_opt_l} ."</a>\n") if ( keys(%s12) > 1 );
			print FILEOUT ("<li><a href=\"#actions\">". $lang{"s14_". $val_opt_l} ."</a>\n") if ( keys(%s14) > 1 );
			print FILEOUT ("<li><a href=\"#rules\">". $lang{"s21_". $val_opt_l} ."</a>\n") if ( keys(%s21) > 1 );
			print FILEOUT ("<li><a href=\"#forward\">". $lang{"s32_". $val_opt_l} ."</a>\n") if ( keys(%s32) > 1 );
			print FILEOUT ("<li><a href=\"#fw1_defense_attack\">". $lang{"s24_". $val_opt_l} ."</a>\n") if ( keys(%s24) > 0 );
			print FILEOUT ("<li><a href=\"#pix_hwlog\">". $lang{"s300_". $val_opt_l} ."</a>\n") if ( keys(%s300) > 0 );
			print FILEOUT ("<li><a href=\"#pix_idslog\">". $lang{"s301_". $val_opt_l} ."</a>\n") if ( keys(%s301) > 0 );
			print FILEOUT ("<li><a href=\"#netscreen_systemlog\">". $lang{"s302_". $val_opt_l} ."</a>\n") if ( keys(%s302) > 0 );
		} 
		if ( $logids gt 0 ) {	
			print FILEOUT ("<li><a href=\"#same_src_attack\">". $lang{"s2_". $val_opt_l} ."</a>\n");
			print FILEOUT ("<li><a href=\"#same_dst_attack\">". $lang{"s3_". $val_opt_l} ."</a>\n");
			print FILEOUT ("<li><a href=\"#same_src_dst_attack\">". $lang{"s0_". $val_opt_l} ."</a>\n");
			print FILEOUT ("<li><a href=\"#port_attack\">Events to one destination port grouped by attack</a>\n");
			print FILEOUT ("<li><a href=\"#attack\">". $lang{"s4_". $val_opt_l} ."</a>\n");
			print FILEOUT ("<li><a href=\"#same_class\">". $lang{"s10_". $val_opt_l} ."</a>\n");
			print FILEOUT ("<li><a href=\"#severity\">". $lang{"s20_". $val_opt_l} ."</a>\n");
			print FILEOUT ("<li><a href=\"#hour_attack\">". $lang{"s7_". $val_opt_l} ."</a>\n");
			print FILEOUT ("<li><a href=\"#portscan\">". $lang{"s25_". $val_opt_l} ."</a>\n") if ( keys(%s25) > 0 );
		}
		print FILEOUT ("</menu>\n");
		print FILEOUT ("</TD></TR></TABLE><BR>\n");
	}
}       






sub init_domains {
open(DOMAINS,$domains_file) or die "Can not open domain file: $domains_file $!\n";
$MaxDomain=0;
while (<DOMAINS>) {
	next if (/^$/ or /^#/);
	$Dots=1;
	($Code,$Description) = /(^\S+)\s+(.*)/;
	$Code =~ tr/A-Z/a-z/;
	$DomainName{$Code}="$Description";
	$Dots++ while $Code =~ /\./g;
	$MaxDomain=$Dots if ($Dots >$MaxDomain);
}
close(DOMAINS);
}



sub init_lang {
my $orig;
my $translation;
open(LANG,$lang_file) or die "Can not open language file: $lang_file $!\n";
while (<LANG>) {
	next if (/^$/ or /^#/);
	($orig,$translation) = /(^\S+)\s+(.*)/;
	$lang{$orig}="$translation";
}
close(LANG);
}



sub init_rules {
open(RULES,$rules_file) or die "Can not open rules file: $rules_file $!\n";
while (<RULES>) {
	next if (/^$/ or /^#/);
	($descr_attack,$link_attack) = /(^.+})\s+(.*)$/;
	$link{$descr_attack}="$link_attack";
}
close(RULES);
}



sub init_hw {
open(HW,$hw_file) or die "Can not open hardware file: $hw_file $!\n";
while (<HW>) {
	next if (/^$/ or /^#/);
	($hw_id,$hw_info) = /^(\%\S+)\s+(.*)$/;
	$hw{$hw_id}="$hw_info";
}
close(HW);
}



sub init_color {
my $LOG = shift;
my $COLOR;
if (($LOG eq "high") || ($LOG =~ /nresolved/)) {
	$COLOR="TBR";
} elsif ($LOG eq "medium") {
	$COLOR="TBG";
} else {
	$COLOR="TB";
}
return ($COLOR)
}




sub init_url {
my $LOG = shift;
my $URL;
if ($LOG eq "bugtraq") {
	$URL="http://www.securityfocus.com/bid/";
} elsif ($LOG eq "arachnids") {
	$URL="http://www.whitehats.com/info/IDS";
} elsif ($LOG eq "cve") {
	$URL="http://cve.mitre.org/cgi-bin/cvename.cgi?name=";
} elsif ($LOG eq "nessus") {
	$URL="http://cgi.nessus.org/plugins/dump.php3?id=";
} elsif ($LOG eq "MCAFEE") {
	$URL="http://vil.nai.com/vil/content/v_";
} elsif ($LOG eq "url") {
	$URL="http://";
}
return ($URL);
}





sub init_pixlog {
%pixlog = qw (
	1 Alert
	2 Critical
	3 Error
	4 Warning
	5 Notification
	6 Informational
	7 Debugging);
}




sub init_proto {
%proto = qw (
	0  ICMP
	1  ICMP
	6  TCP
	17 UDP);
}


sub init_monthday {
%monthday = qw (
	Jan 1
	Feb 2
	Mar 3
	Apr 4
	May 5
	Jun 6
	Jul 7
	Aug 8
	Sep 9
	Oct 10
	Nov 11
	Dec 12);
}



sub init_daymonth {
%daymonth = qw (
	1 Jan
	2 Feb
	3 Mar
	4 Apr
	5 May
	6 Jun
	7 Jul
	8 Aug
	9 Sep
	10 Oct 
	11 Nov
	12 Dec
	01 Jan
	02 Feb
	03 Mar
	04 Apr
	05 May
	06 Jun
	07 Jul
	08 Aug
	09 Sep);
}




sub search_date {
	if ( ! $opt{x} ) {
		$MONTH = $record->{MON};
		$DAY = $record->{DAY};
		$HOUR = $record->{HOUR};
		$MIN = $record->{MIN};
		$SEC = $record->{SEC};
	} else {
		$MONTH = $result[$i]->[0];
		$DAY = $result[$i]->[1];
		$HOUR = $result[$i]->[2];
		$MIN = $result[$i]->[3];
		$SEC = $result[$i]->[4];
	}

	if ( ($MONTH >= $maxmonth) || ( $MONTH == "" ) ) {
		if ($MONTH > $maxmonth) {
			$maxday = 0; $maxhour = 0; $maxmin = 0; $maxsec = 0;
		} 
		if ( ($DAY >= $maxday) || ($DAY == "") ) {
			if ($DAY > $maxday) {
				$maxhour = 0; $maxmin = 0; $maxsec = 0;
			} 
			if ( $HOUR >= $maxhour) {
				if ($HOUR > $maxhour) {
					$maxmin = 0; $maxsec = 0;
				} 
				if ($MIN >= $maxmin) {
					if ($MIN > $maxmin) {
						$maxsec = 0;
					} 
					if ($SEC >= $maxsec) {
						$maxmonth = $MONTH;
						$maxday = $DAY;
						$maxhour = $HOUR;
						$maxmin = $MIN;
						$maxsec = $SEC;
					}
				}
			}
		}
	}
	
	if ( ($MONTH <= $minmonth) || ( $MONTH == "" ) ) {
		if ( $MONTH <= $minmonth) {
			if ($MONTH < $minmonth) {
				$minday = 31; $minhour = 23; $minmin = 59; $minsec = 59;
			} 
			if ( ($DAY <= $minday) || ($DAY == "") ) {
				if ($DAY < $minday) {
					$minhour = 23; $minmin = 59; $minsec = 59;
				} 
				if ( $HOUR <= $minhour) {
					if ($HOUR < $minhour) {
						$minmin = 59; $minsec = 59;
					} 
					if ($MIN <= $minmin) {
						if ($MIN < $minmin) {
							$minsec = 59;
						} 
						if ($SEC <= $minsec) {
							$minmonth = $MONTH;
							$minday = $DAY;
							$minhour = $HOUR;
							$minmin = $MIN;
							$minsec = $SEC;
						}
					}
				}
			}
		}
	}

	#
	# ADD "0" IF DAY HAVE A SINGLE DIGIT (FOR SORTING TABLE IN DAILY_EVENT)
	#
	$DAY = "0".$record->{DAY} if ( $DAY =~ m/^\d{1}$/ox );
	$MONTH = "0".$record->{MON} if ( $MONTH =~ m/^\d{1}$/ox );
}



sub search_filter {
	$filter = "";
	if ( $opt_fsrc == 1 ) {
		$filter = $filter ." src = $val_opt_fsrc ";
	}
	if ( $opt_fdst == 1 ) {
		$filter = $filter ." dst = $val_opt_fdst ";
	}
	if ( $opt_fmonth == 1 ) {
		$filter = $filter ." month = $val_opt_fmonth ";
	}
	if ( $opt_fday == 1 ) {
		$filter = $filter ." day = $val_opt_fday ";
	}
	if ( $opt_fhost == 1 ) {
		$filter = $filter ." host = $val_opt_fhost ";
	}
	if ( $opt_fether == 1 ) {
		$filter = $filter ." ether = $val_opt_fether ";
	}
	if ( $opt_fseverity == 1 ) {
		$filter = $filter ." severity = $val_opt_fseverity ";
	}
	if ( $opt_fproto == 1 ) {
		$filter = $filter ." protocol = $val_opt_fproto ";
	}
	if ( $opt_faction == 1 ) {
		$filter = $filter ." action = $val_opt_faction ";
	}
	if ( $opt_frule == 1 ) {
		$filter = $filter ." rule = $val_opt_frule ";
	}
	if ( $opt_freason == 1 ) {
		$filter = $filter ." reason = $val_opt_freason ";
	}
	if ( $opt_ftype == 1 ) {
		$filter = $filter ." type = $val_opt_ftype ";
	}
	if ( $opt_fdport == 1 ) {
		$filter = $filter ." dport = $val_opt_fdport ";
	}
	if ( $opt_fclass == 1 ) {
		$filter = $filter ." classification = $val_opt_fclass ";
	}
}





sub portscan {
$i = 0;
my $description = $lang{"s25_". $val_opt_l};
if ( ( $opt_n != 1 ) || ( $val_opt_n > keys(%s25) ) ) {
	$n = keys %s25;
} else {
	$n = $val_opt_n;
}

if ( ( $opt_o == 1 ) || ( $opt_p == 1 ) ) {
	print FILEOUT ("<h3><CENTER><a name=\"portscan\" href=\"#top\">$description</a></CENTER></h3>\n");
	print FILEOUT ("<TABLE BORDER=$border ALIGN=center>\n");
	print FILEOUT ("<tr class=TH align=center><td>%</td><td>No</td><td>IP Source</td></tr>\n");
	foreach $k (sort { $s25{$b} <=> $s25{$a} } keys %s25) {
		printf FILEOUT ("<tr class=TB><TD>%-2.2f</TD><TD>%-${nb_len}d</TD><TD>%-${addr_len}s\n", $s25{$k}/$total*100,$s25{$k},$k) if ( $i < $n );
		++$i;
	}
	print FILEOUT ("</table><BR>\n");
} else {
	if ( $opt{x} ) {
		open (FILEOUT, ">$tmpout_file") or die "Can not open file: $tmpout_file\n";
		print FILEOUT "$description\n";
		$linelength = 40;
		print FILEOUT ( '=' x $linelength, "\n");
		print FILEOUT (" " x 4, "### Portscan List ###\n");
		print FILEOUT ("    %    No     IP source\n");
		print FILEOUT ( '=' x $linelength, "\n");
		foreach $k (sort { $s25{$b} <=> $s25{$a} } keys %s25) {
			printf FILEOUT ("  %5.2f  %-4d   %-${addr_len}s\n", $s25{$k}/$total*100,$s25{$k},$k) if ( $i < $n );
			++$i;
		}
		close (FILEOUT);
		open (FILEIN, "<$tmpout_file") or die "Can access file : $tmpout_file\n";
		while (<FILEIN>) {
			chomp $_;
			$scrolled_result->insert('end', "$_\n");
		}
		close (FILEIN);
		$scrolled_result->insert('end', "\n");
	} else {	
		section_header("$description\n", "portscan");
		foreach $k (sort { $s25{$b} <=> $s25{$a} } keys %s25) {
			printf("  %5.2f  %-6d  %-${addr_len}s\n", $s25{$k}/$total*100,$s25{$k},$k) if ( $i < $n );
			++$i;
		}
	}
}
}



# print the footer (needed for html)
sub print_footer {
if ( ( $opt_o == 1 ) && ( $filetype eq 'html' ) ) {
	
	print FILEOUT ("</TD></TR></TBODY></TABLE>\n");
	print FILEOUT ("");
	print FILEOUT ("<td background='$picts_dir/p_21.gif' valign='top' width='130'><table border='0' cellpadding='0' cellspacing='0' width='130'>\n");
	print FILEOUT ("<TBODY><TR><TD>\n");
	print FILEOUT ("<BR><img src='$picts_dir/p_08.gif' height='20' width='130'>\n");
	print FILEOUT ("</TD></TR>\n");
	print FILEOUT ("<TR><TD background='$picts_dir/p_10.gif'>\n");

	print FILEOUT ("<BR><B class='color1'><i>Main Stats</I></B><BR>\n");
	print FILEOUT ("<A HREF=\'#attack_src\' class='down'>IP Src</A><BR>\n");
	print FILEOUT ("<A HREF=\'#attack_dst\' class='down'>IP Dst</A><BR>\n");
	print FILEOUT ("<A HREF=\'#proto\' class='down'>Protocols</A><BR>\n");
	print FILEOUT ("<A HREF=\'#interfaces\' class='down'>Interfaces</A><BR>\n") if ( keys(%s1) gt 1 );
	print FILEOUT ("<A HREF=\'#hour\' class='down'>Hour</A><BR>\n");
	print FILEOUT ("<A HREF=\'#daily_event\' class='down'>Days</A><BR>\n") if ( ($minmonth ne $maxmonth) || ($minday < $maxday) );
	print FILEOUT ("<A HREF=\'#nids\' class='down'>Host Logger</A><BR>\n") if ( keys(%s13) gt 1 );
	print FILEOUT ("<A HREF=\'#dport\' class='down'>Services</A><BR>\n");
	print FILEOUT ("<A HREF=\'#domain_src\' class='down'>Domain Src</A><BR>\n") if $opt{c};
	print FILEOUT ("<A HREF=\'#typelog\' class='down'>Log's Type</A><BR>\n");

	if ( $logids gt 0 ) {
		print FILEOUT ("<BR><B class='color1'><i>IDS/IPS Stats</I></B><BR>\n");
		print FILEOUT ("<A HREF=\'#same_src_attack\' class='down'>Attack by Src</A><BR>\n");
		print FILEOUT ("<A HREF=\'#same_dst_attack\' class='down'>Attack by Dst</A><BR>\n");
		print FILEOUT ("<A HREF=\'#same_src_dst_attack\' class='down'>Attack by Src and Dst</A><BR>\n");
		print FILEOUT ("<A HREF=\'#attack\' class='down'>Attacks</A><BR>\n");
		print FILEOUT ("<A HREF=\'#severity\' class='down'>Alert Severity</A><BR>\n");
		print FILEOUT ("<A HREF=\'#same_class\' class='down'>Alert Classification</A><BR>\n");
		print FILEOUT ("<A HREF=\'#dport_attack\' class='down'>Attacks by Services</A><BR>\n");
		print FILEOUT ("<A HREF=\'#same_hour_attack\' class='down'>Attacks by Hours</A><BR>\n");
	}

	if ( $logfw gt 0 ) {
		print FILEOUT ("<BR><B class='color1'><i>Firewall Stats</I></B><BR>\n");
		print FILEOUT ("<A HREF=\'#same_src_dport\' class='down'>Log by Src and Service</A><BR>\n");
		print FILEOUT ("<A HREF=\'#same_dst_dport\' class='down'>Log by Dst and Service</A><BR>\n");
		print FILEOUT ("<A HREF=\'#same_src_dst_dport\' class='down'>Log from Src to Dst by Service</A><BR>\n");
		print FILEOUT ("<A HREF=\'#same_src_dst_action\' class='down'>Log from Src to Dst by Action</A><BR>\n");
		print FILEOUT ("<A HREF=\'#same_src_dst_reason\' class='down'>Log from Src to Dst by Reason</A><BR>\n");
		print FILEOUT ("<A HREF=\'#rules\' class='down'>Log by Rule</A><BR>\n") if ( keys(%s21) gt 1 );
		print FILEOUT ("<A HREF=\'#reasons\' class='down'>Log by Reason</A><BR>\n") if ( keys(%s12) gt 1 );
		print FILEOUT ("<A HREF=\'#actions\' class='down'>Log by Action</A><BR>\n") if ( keys(%s14) gt 1 ) ;
		print FILEOUT ("<A HREF=\'#forward\' class='down'>Into Zone Out to Zone</A><BR>\n") if ( keys(%s21) gt 1 ) ;
		print FILEOUT ("<A HREF=\'#fw1_defense_attack\' class='down'>Log from SmartDefense</A><BR>\n") if ( keys(%s24) gt 0 );
		print FILEOUT ("<A HREF=\'#pix_hwlog\' class='down'>Logs from Hardware</A><BR>\n") if ( keys(%s300) gt 0 );
		print FILEOUT ("<A HREF=\'#pix_idslog\' class='down'>IDS logs from Pix</A><BR>\n") if ( keys(%s301) gt 0 );
		print FILEOUT ("<A HREF=\'#netscreen_systemlog\' class='down'>NetScreen System logs</A><BR>\n") if ( keys(%s302) gt 0 );
	}

	print FILEOUT ("<BR>\n");
	print FILEOUT ("</TD></TR>\n");
	print FILEOUT ("</TBODY></TABLE></TD>\n");
	print FILEOUT ("");
	print FILEOUT ("<td background='$picts_dir/p_25.gif' valign='top' width='30'>&nbsp;</td></tr>\n");

	print FILEOUT ("<tr>\n");
	print FILEOUT ("<td background='$picts_dir/p_26.jpg' valign='top'>&nbsp;</td>\n");
	print FILEOUT ("<td background='$picts_dir/p_22.gif' valign='top'><hr height='1'></td>\n");
	print FILEOUT ("<td background='$picts_dir/p_21.gif' valign='top'>&nbsp;</td>\n");
	print FILEOUT ("<td background='$picts_dir/p_25.gif' valign='top'>&nbsp;</td>\n");
	print FILEOUT ("</tr>\n");
	print FILEOUT ("</tbody></table>\n");

	print FILEOUT ("<table align='center' border='0' cellpadding='0' cellspacing='0' width='840'><tbody><tr>\n");
	print FILEOUT ("<td background='$picts_dir/p_26.jpg' valign='top' width='30'>&nbsp;</td>\n");
	print FILEOUT ("<td background='$picts_dir/p_22.gif' valign='top'><table border='0' cellpadding='0' cellspacing='0' width='100%'>\n");
	print FILEOUT ("<tbody><tr>\n");
	print FILEOUT ("<td rowspan='2' align='center' background='$picts_dir/p_06.gif' height='130' width='50%'>&nbsp;</td>\n");
	print FILEOUT ("<td align='left' valign='top' width='50%'>\n");
	print FILEOUT ("<tr><td align='left' valign='bottom'>\n");
	print FILEOUT ("<i><span class='color1'>powered by&nbsp;</span><b><a target='_blank' class='linkcopy' href='http://jeremy.chartier.free.fr/snortalog/'>SnortALog</a></b></i><br><span class='sizeSmall'>\n");
	print FILEOUT ("\xa9&nbsp;SnortALog&nbsp;2000-2007</span><br></td></tr></tbody></table></td>\n");
	print FILEOUT ("<td background='$picts_dir/p_21.gif' valign='top' width='130'>&nbsp;</td>\n");
	print FILEOUT ("<td background='$picts_dir/p_25.gif' width='30'>&nbsp;</td>\n");
	print FILEOUT ("</tr></tbody></table>\n");
	print FILEOUT ("<table align='center' border='0' cellpadding='0' cellspacing='0' width='840'><tbody><tr><td><img src='$picts_dir/p_27.gif' height='40' width='846'></td></tr></tbody></table>\n");
	print FILEOUT ("</BODY>\n</HTML>");
	close (FILEOUT);

} elsif ( ( $opt_o == 1 ) && ( $filetype eq 'pdf' ) ) {
		print FILEOUT ("<BR><BR>");
		print FILEOUT ("<CENTER>Version: $version<BR>\n");
		print FILEOUT ("Jeremy CHARTIER, <jeremy.chartier\@free.fr>");
		print FILEOUT ("Date: $datever</CENTER><BR>\n");
	print FILEOUT ("</BODY>\n</HTML>");
	close (FILEOUT);

} else {
	if ( $opt{x} ) {
		open (FILEOUT, ">$tmpout_file") or die "Can not open file: $tmpout_file\n";
		print FILEOUT ("\n");
		print FILEOUT ("Version: $version\n");
		print FILEOUT ("Jeremy CHARTIER, <jeremy.chartier\@free.fr>\n");
		print FILEOUT ("Date: $datever\n");
		close (FILEOUT);
		open (FILEIN, "<$tmpout_file") or die "Can access file : $tmpout_file\n";
		while (<FILEIN>) {
			chomp $_;
			$scrolled_result->insert('end', "$_\n");
		}
		close (FILEIN);
		$scrolled_result->insert('end', "\n");
	} else {	
print <<FootMessage

Version: $version
Jeremy CHARTIER, <jeremy.chartier\@free.fr>
Date: $datever
FootMessage
}
}
}


#
# resolve host name and cache it
#
sub resolve {
my $Address=shift;
my $Hostname;
if ($Address =~ /(\d+\.\d+\.\d+\.\d+)/) {
	$Hostname = gethostbyaddr(inet_aton($Address),AF_INET) or $Hostname="unresolved";
}
return $Hostname;
}






# Use a title and a short code to write the section headers
# This is used in place of a FORMAT as this allows variable column widths
# contributed by: Ned Patterson, <jpatter@alum.mit.edu>
#
sub section_header {
my $linelength;
$title = shift; 
$report = shift;
$_ = shift;

if ( $opt{x} ) {
	print FILEOUT ("\n\n$title");
} else {
	print BOLD,("\n\n$title"), RESET;
}

if ( $report eq "attack_src_resolve") {
	$linelength = 11 + $nb_len + 2 + $addr_len + 2 + $resolve_len + 2 + $domain_len;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s5) ." ###\n");
	print("    %    No      IP source        Resolve                                             Domain\n");
} elsif ($report eq "attack_src_whois") {
	$linelength = 11 + $nb_len + 2 + $addr_len + 2 + $whois_len;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s5) ." ###\n");
	print("    %    No      IP source        Inetnum                            Netname                         Descr                 Email\n");
} elsif ($report eq "attack_src_resolve_whois") {
	$linelength = 11 + $nb_len + 2 + $addr_len + 2 + $resolve_len + 2 + $domain_len + 2 + $whois_len;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s5) ." ###\n");
	print("    %    No      IP source        Resolve                                             Domain      Inetnum                            Netname                         Descr                 Email\n");
} elsif ($report eq "domain_src") {
	$linelength = 11 + $domain_len;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s40) ." ###\n");
	print("    %    No      Domain\n");
} elsif ($report eq "attack_dst_resolve") {
	$linelength = 11 + $nb_len + 2 + $addr_len + 2 + $resolve_len;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s6) ." ###\n");
	print("    %    No      IP destination   Resolve\n");
} elsif ($report eq "attack") {
	$linelength = 13 + $nb_len + 4 + $attack_len + 4 + $prior_len + 4 + $sever_len;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". keys(%s4) ." of ". keys(%s4) ." ###\n");
	print("    %    No      Attack                                                           Priority Severity\n");
} elsif ($report eq "nids") {
	$linelength = 50;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". keys(%s13) ." of ". keys(%s13) ." ###\n");
	print("    %    No      Host Logger\n");
} elsif ($report eq "proto") {
	$linelength = 50;
	print( '=' x $linelength, "\n");
	print (" " x 4, "### ". keys(%s11) ." of ". keys(%s11) ." ###\n");
	print("    %    No      Protocols\n");
} elsif ($report eq "interfaces") {
	$linelength = 55;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". keys(%s1) ." of ". keys(%s1) ." ###\n");
	print("    %    No      Interfaces       Host\n");
} elsif ($report eq "same_class") {
	$linelength = 13 + $nb_len + 4 + $class_len + 4 + $sever_len;
	print ( '=' x $linelength, "\n");
	print (" " x 4, "### ". keys(%s10) ." of ". keys(%s10) ." ###\n");
	print ("    %    No      Classification                                                Severity\n");
} elsif ($report eq "xsame_class") {
	$linelength = 13 + $nb_len + 4 + $class_len + 4 + $sever_len;
	print FILEOUT ( '=' x $linelength, "\n");
	print FILEOUT (" " x 4, "### ". keys(%s10) ." of ". keys(%s10) ." ###\n");
	print FILEOUT ("    %    No      Classification                                                Severity\n");
} elsif ($report eq "same_hour_attack") {
	$linelength = 11 + $nb_len + 4 + $hour_len + 4 + $attack_len;
	print ( '=' x $linelength, "\n");
	print (" " x 4, "### ". $n ." of ". keys(%s9) ." ###\n");
	print ("    %    No      Heure  Attack\n");
} elsif ($report eq "xsame_hour_attack") {
	$linelength = 11 + $nb_len + 4 + $hour_len + 4 + $attack_len;
	print FILEOUT ( '=' x $linelength, "\n");
	print FILEOUT (" " x 4, "### ". $n ." of ". keys(%s9) ." ###\n");
	print FILEOUT ("    %    No      Heure  Attack\n");
} elsif ($report eq "same_src_attack") {
	$linelength = 11 + $nb_len + 4 + $addr_len + 4 + $attack_len + 4 + $sever_len;
	print ( '=' x $linelength, "\n");
	print (" " x 4, "### ". $n ." of ". keys(%s2) ." ###\n");
	print ("    %    No      IP source        Attack                                                                  Severity\n");
} elsif ($report eq "xsame_src_attack") {
	$linelength = 11 + $nb_len + 4 + $addr_len + 4 + $attack_len + 4 + $sever_len;
	print FILEOUT ( '=' x $linelength, "\n");
	print FILEOUT (" " x 4, "### ". $n ." of ". keys(%s2) ." ###\n");
	print FILEOUT ("    %    No      IP source        Attack                                                                  Severity\n");
} elsif ($report eq "same_dst_attack") {
	$linelength = 13 + $nb_len + 4 + $addr_len + 4 + $attack_len + 4 + $sever_len;
	print ( '=' x $linelength, "\n");
	print (" " x 4, "### ". $n ." of ". keys(%s3) ." ###\n");
	print ("    %    No      IP destination   Attack                                                                  Severity\n");
} elsif ($report eq "xsame_dst_attack") {
	$linelength = 13 + $nb_len + 4 + $addr_len + 4 + $attack_len + 4 + $sever_len;
	print FILEOUT ( '=' x $linelength, "\n");
	print FILEOUT (" " x 4, "### ". $n ." of ". keys(%s3) ." ###\n");
	print FILEOUT ("    %    No      IP destination   Attack\n");
} elsif ($report eq "same_src_dst_attack") {
	$linelength = 13 + $nb_len + 4 + $addr_len + 4 + $addr_len + 4 + $attack_len;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s0) ." ###\n");
	print("    %    No      IP source        IP destination   Attack\n");
} elsif ($report eq "same_src_dst_dport") {
	$linelength = 13 + $nb_len + 4 + $addr_len + 4 + $addr_len + 4 + 6;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s29) ." ###\n");
	print("    %    No      IP source        IP destination   Dport\n");
} elsif ($report eq "same_src_dst_action") {
	$linelength = 13 + $nb_len + 4 + $addr_len + 4 + $addr_len + 4 + 8;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s30) ." ###\n");
	print("    %    No      IP source        IP destination   Action\n");
} elsif ($report eq "same_src_dst_reason") {
	$linelength = 13 + $nb_len + 4 + $addr_len + 4 + $addr_len + 4 + 12;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s31) ." ###\n");
	print("    %    No      IP source        IP destination   Reason\n");
} elsif ($report eq "forward") {
	$linelength = 13 + $nb_len + 4 + $zone_len + 4 + $zone_len;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s32) ." ###\n");
	print("    %    No      Zone source      Zone destination\n");
} elsif ($report eq "dport_attack") {
	$linelength = 11 + $nb_len + 4 + $port_len + 4 +  $attack_len;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s18) ." ###\n");
	print("    %    No      Port   Attack\n");
} elsif ($report eq "dport") {
	$linelength = 11 + $nb_len + 4 + $port_len + 4;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s16) ." ###\n");
	print("    %    No      Port\n");
} elsif ($report eq "same_src_dport") {
	$linelength = 13 + $nb_len + 4 + 40;
	print ( '=' x $linelength, "\n");
	print (" " x 4, "### ". $n ." of ". keys(%s22) ." ###\n");
	print ("    %    No      IP Src           Dport\n");
} elsif ($report eq "xsame_src_dport") {
	$linelength = 13 + $nb_len + 4 + 40;
	print FILEOUT ( '=' x $linelength, "\n");
	print FILEOUT (" " x 4, "### ". $n ." of ". keys(%s22) ." ###\n");
	print FILEOUT ("    %    No      IP Src           Dport\n");
} elsif ($report eq "same_dst_dport") {
	$linelength = 13 + $nb_len + 4 + 40;
	print ( '=' x $linelength, "\n");
	print (" " x 4, "### ". $n ." of ". keys(%s23) ." ###\n");
	print ("    %    No      IP Dest          Dport\n");
} elsif ($report eq "xsame_dst_dport") {
	$linelength = 13 + $nb_len + 4 + 40;
	print FILEOUT ( '=' x $linelength, "\n");
	print FILEOUT (" " x 4, "### ". $n ." of ". keys(%s23) ." ###\n");
	print FILEOUT ("    %    No      IP Dest          Dport\n");
} elsif ($report eq "reasons") {
	$linelength = 13 + $nb_len + 4 + 40;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s12) ." ###\n");
	print("    %    No      Reasons\n");
} elsif ($report eq "actions") {
	$linelength = 13 + $nb_len + 4 + 6;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s14) ." ###\n");
	print("    %    No      Actions\n");
} elsif ($report eq "rules") {
	$linelength = 13 + $nb_len + 4 + 8;
	print ( '=' x $linelength, "\n");
	print (" " x 4, "### ". $n ." of ". keys(%s21) ." ###\n");
	print ("    %    No      Rules\n");
} elsif ($report eq "xrules") {
	$linelength = 13 + $nb_len + 4 + 8;
	print FILEOUT ( '=' x $linelength, "\n");
	print FILEOUT (" " x 4, "### ". $n ." of ". keys(%s21) ." ###\n");
	print FILEOUT ("    %    No      Rules\n");
} elsif ($report eq "defense_attack") {
	$linelength = 13 + $nb_len + 4 + 70;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s24) ." ###\n");
	print("    %    No      SmartDefense Attack             Infos\n");
} elsif ($report eq "typelog") {
	$linelength = 13 + $nb_len + 4 + 30;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s17) ." ###\n");
	print("    %    No      Type\n");
} elsif ($report eq "hwlog") {
	$linelength = 13 + $nb_len + 4 + 50;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s300) ." ###\n");
	print("    %    No      Type\n");
} elsif ($report eq "idslog") {
	$linelength = 13 + $nb_len + 4 + 50;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s301) ." ###\n");
	print("    %    No      Type\n");
} elsif ($report eq "systemlog") {
	$linelength = 13 + $nb_len + 4 + 50;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s302) ." ###\n");
	print("    %    No      Type\n");
} elsif ($report eq "daily_event") {
	$linelength = 20 + $nb_len + 6 + $graph_len;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". keys(%s19) ." of ". keys(%s19) ." ###\n");
	print(" Day Month    No        %    Graph\n");
} elsif ($report eq "hour") {
	$linelength = 13 + $nb_len + 2 + $hour_len + 2 + $graph_len;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". keys(%s7) ." of ". keys(%s7) ." ###\n");
	print("  Hour No        %    Graph\n");
} elsif ($report eq "portscan") {
	$linelength = 40;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### Portscan List ###\n");
	print("    %    No      IP source\n");
} elsif ($report eq "attack_dst") {
	$linelength = 13 + $nb_len + 4 + $addr_len;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s6) ." ###\n");
	print("    %    No      IP destination\n");
} elsif ($report eq "attack_src") {
	$linelength = 13 + $nb_len + 4 + $addr_len;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". $n ." of ". keys(%s5) ." ###\n");
	print("    %    No      IP source\n");
} elsif ($report eq "severity") {
	$linelength = 13 + $nb_len + 2 + $sever_len + 2 + $graph_len;
	print( '=' x $linelength, "\n");
	print(" " x 4, "### ". keys(%s20) ." of ". keys(%s20) ." ###\n");
	print("    %    No      Severity Graph\n");
}


if ( $opt{x} ) {
	print FILEOUT ( '=' x $linelength, "\n");
} else {
	print ( '=' x $linelength, "\n");
}

}








sub record_data {
	$record = shift;

	if ( ! $opt_x ) {
		if ( $opt_filter == 1 ) {
			if ( ($record->{PROTO} ne $val_opt_fproto) && ($opt_fproto == 1) ) {
                        } elsif ( ($record->{SADDR} ne $val_opt_fsrc) && ($opt_fsrc == 1) ) {
                        } elsif ( ($record->{DADDR} ne $val_opt_fdst) && ($opt_fdst == 1) ) {
                        } elsif ( ($record->{DPORT} ne $val_opt_fdport) && ($opt_fdport == 1) ) {
                        } elsif ( ($record->{ETHER} ne $val_opt_fether) && ($opt_fether == 1) ) {
                        } elsif ( ($record->{HOUR} ne $val_opt_fhour) && ($opt_fhour == 1) ) {
                        } elsif ( ($record->{DAY} ne $val_opt_fday) && ($opt_fday == 1) ) {
                        } elsif ( ($record->{MON} ne $val_opt_fmonth) && ($opt_fmonth == 1) ) {
                        } elsif ( ($record->{HOST} ne $val_opt_fhost) && ($opt_fhost == 1) ) {
                        } elsif ( ($record->{SEVERITY} ne $val_opt_fseverity) && ($opt_fseverity == 1) ) {
                        } elsif ( ($record->{ACTION} ne $val_opt_faction) && ($opt_faction == 1) ) {
                        } elsif ( ($record->{RULE} ne $val_opt_frule) && ($opt_frule == 1) ) {
                        } elsif ( ($record->{REASON} ne $val_opt_freason) && ($opt_freason == 1) ) {
                        } elsif ( ($record->{TYPE} ne $val_opt_ftype) && ($opt_ftype == 1) ) {
                        } elsif ( ($record->{CLASS} ne $val_opt_fclass) && ($opt_fclass == 1) ) {
			} else {
				$fwlog = 1 if ( $record->{TYPE} =~ m/Fire||UTM|VPN-1|ipfilter|pfilter|netfilter|Smart|Pix|NetScreen|Brick/ox );
				++$logfw if ( $fwlog == 1 );
				$idslog = 1 if ( $record->{TYPE} =~ m/snort|TippingPoint/ox );
				++$logids if ( $idslog == 1 );
				++$logpix if ( $record->{TYPE} =~ m/Pix/ox );
				++$total_s300 if ( $record->{PLUGIN} eq "alerthw" );
				++$total_s301 if ( $record->{ACTION} eq "IDS" );
				++$total_hw if ( $record->{PLUGIN} eq "alerthw" );
				++$total_log;
				search_date($record);
				process_data($record);
			}
		} else {
			$fwlog = 1 if ( $record->{TYPE} =~ m/Fire||UTM|VPN-1|ipfilter|pfilter|netfilter|Smart|Pix|NetScreen|Brick/ox );
			++$logfw if ( $fwlog == 1 );
			$idslog = 1 if ( $record->{TYPE} =~ m/snort|TippingPoint/ox );
			++$logids if ( $idslog == 1 );
			++$logpix if ( $record->{TYPE} =~ m/Pix/ox );
			++$total_s300 if ( $record->{PLUGIN} eq "alerthw" );
			++$total_s301 if ( $record->{ACTION} eq "IDS" );
			++$total_hw if ( $record->{PLUGIN} eq "alerthw" );
			++$total_log;
			search_date($record);
			process_data($record);
		}
	} else {
		$fwlog = 1 if ( $record->{TYPE} =~ m/Fire|UTM|VPN-1|ipfilter|pfilter|netfilter|Smart|Pix|NetScreen|Brick/ox );
		++$logfw if ( $fwlog == 1 );
		$idslog = 1 if ( $record->{TYPE} =~ m/snort|TippingPoint/ox );
		++$logids if ( $idslog == 1 );
		++$logpix if ( $record->{TYPE} =~ m/Pix/ox );
		++$total_s300 if ( $record->{PLUGIN} eq "alerthw" );
		++$total_s301 if ( $record->{ACTION} eq "IDS" );
		++$total_hw if ( $record->{PLUGIN} eq "alerthw" );
		++$total_log;
                push @result , [$record->{MON},$record->{DAY},$record->{HOUR},$record->{MIN},
                $record->{SEC},$record->{HOST},$record->{SIG},$record->{SADDR},
                $record->{SPORT},$record->{DADDR},$record->{DPORT},$record->{CLASS},
                $record->{PRIORITY},$record->{SEVERITY},$record->{ETHER},
                $record->{PROTO},$record->{ACTION},$record->{REASON},$record->{RULE},
                $record->{TYPE},$record->{PLUGIN},$record->{ATTACK},$record->{ATTACK_INFO},
                $record->{SZONE},$record->{DZONE},$record->{HW_INFO}]; 
	}
}





