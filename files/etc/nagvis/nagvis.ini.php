; MANAGED VIA SALT -- DO NOT EDIT
{% set data = salt['mc_utils.json_load'](data) %}
; <?php return 1; ?>
; the line above is to prevent
; viewing this file from web.
; DON'T REMOVE IT!

; ----------------------------
; Default NagVis Configuration File
; At delivery everything here is commented out. The default values are set in the NagVis code.
; You can make your changes here, they'll overwrite the default settings.
; ----------------------------

; ----------------------------
; !!! The sections/variables with a leading ";" won't be recognised by NagVis (commented out) !!!
; ----------------------------

; General options which affect the whole NagVis installation
[global]
; Enable/Disable logging of security related user actions in Nagvis. For
; example user logins and logouts are logged in var/nagvis-audit.log

audit_log="{{data.nagvis_ini_php.global.audit_log}}"

;
; Defines the authentication module to use. By default NagVis uses the built-in
; SQLite authentication module. On delivery there is no other authentication
; module available. It is possible to add own authentication modules for
; supporting other authorisation mechanisms. For details take a look at the
; documentation.

authmodule="{{data.nagvis_ini_php.global.authmodule}}"

;
; Defines the authorisation module to use. By default NagVis uses the built-in
; SQLite authorisation module. On delivery there is no other authorisation
; module available. It is possible to add own authorisation modules for
; supporting other authorisation mechanisms. For details take a look at the
; documentation.

authorisationmodule="{{data.nagvis_ini_php.global.authorisationmodule}}"

;
; Sets the size of the controls in unlocked (edit) mode of the frontend. This
; defaults to a value of 10 which makes each control be sized to 10px * 10px.

controls_size="10"

;
; Dateformat of the time/dates shown in nagvis (For valid format see PHP docs)

dateformat="Y-m-d H:i:s"

;
; Used to configure the preselected options in the "acknowledge problem" dialog

dialog_ack_sticky="1"


dialog_ack_notify="1"


dialog_ack_persist="0"

;
; File group and mode are applied to all files which are written by NagVis.
; Usualy these values can be left as they are. In some rare cases you might
; want to change these values to make the files writeable/readable by some other
; users in a group.

file_group="{{data.nagvis_ini_php.global.file_group}}"


file_mode="{{data.nagvis_ini_php.global.file_mode}}"

;
; The server to use as source for the NagVis geomaps. Must implement the API which
; can be found on http://pafciu17.dev.openstreetmap.org/

geomap_server="{{data.nagvis_ini_php.global.geomap_server}}"

;
; In some cases NagVis needs to open connections to the internet. The cases are:
; - The new geomap needs access to openstreetmap webservices to be able to fetch
;   mapping information
; Most company networks don't allow direct HTTP access to the internet. The most
; networks require the users to use proxy servers for outbound HTTP requests.
; The proxy url to be used in NagVis can be configured here. One possible value
; is "tcp://127.0.0.1:8080".

{% if data.nagvis_ini_php.global.get('http_proxy', None) %}
http_proxy="{{data.nagvis_ini_php.global.http_proxy}}"
{% endif %}
; Most proxies require authentication to access the internet. Use the format
; "<username>:<password>" to provide auth credentials
{% if data.nagvis_ini_php.global.get('http_proxy_auth', None) %}
http_proxy_auth="{{data.nagvis_ini_php.global.http_proxy_auth}}"
{% endif %}
; Set the timeout (in seconds) for outbound HTTP requests (for example geomap requests)

http_timeout="10"

;
; Defines which translations of NagVis are available to the users

language_available="de_DE,en_US,es_ES,fr_FR,pt_BR"

; Language detection steps to use. Available:
;  - User:    The user selection
;  - Session: Language saved in the session (Usually set after first setting an
;             explicit language)
;  - Browser: Detection by user agent information from the browser
;  - Config:  Use configured default language (See below)

language_detection="user,session,browser,config"

;
; Select language (Available by default: en_US, de_DE, fr_FR, pt_BR)

language="en_US"

;
; Defines the logon module to use. There are three logon modules to be used by
; default. It is possible to add own logon modules for serving other dialogs or
; ways of logging in. For details take a look at the documentation.
;
; The delivered modules are:
;
; LogonMixed: The mixed logon module uses the LogonEnv module as default and
;   the LogonDialog module as fallback when LogonEnv returns no username. This
;   should fit the requirements of most environments.
;
; LogonDialog: This is an HTML logon dialog for requesting authentication
;   information from the user.
;
; LogonEnv: It is possible to realise a fully "trusted" authentication
;   mechanism like all previous NagVis versions used it before. This way the user
;   is not really authenticated with NagVis. NagVis trusts the provided username
;   implicitly. NagVis uses the configured environment variable to identify the
;   user. You can add several authentication mechanisms to your webserver,
;   starting from the basic authentication used by Nagios (.htaccess) to single
;   sign-on environments.
;   Simply set logonmodule to "LogonEnv", put the environment variable to use as
;   username to the option logonenvvar and tell the authentication module to
;   create users in the database when provided users does not exist. The option
;   logonenvcreaterole tells the module to assign the new user to a specific role
;   set to empty string to disable that behaviour.
;
; LogonMultisite: This module uses the authentication provided by auth_* cookies
;   which have been generated by Check_MK multisite when using the cookie based
;   authentication. Since 1.2.1i2 Check_MK uses a new cookie format. To be able
;   to use this, you need to define a new option called logon_multisite_serials
;   which points to the auth.serial file generated by Check_MK.
;   Special options for this module:
;
;

logonmodule="LogonMixed"

logonenvvar="REMOTE_USER"
logonenvcreateuser="1"
logonenvcreaterole="Guests"

;
; Default rotation time of pages in rotations

refreshtime="60"

;
; Some user information is stored in sessions which are identified by session
; cookies placed on the users computer. The options below set the properties
; of the session cookie.
; Domain to set the cookie for. By default NagVis tries to auto-detect this
; options value by using the webserver's environment variables.

sesscookiedomain="auto-detect"

; Absolute web path to set the cookie for. This defaults to configured
; paths/htmlbase option

sesscookiepath="auto-detect"

; Lifetime of the NagVis session cookie in seconds. The default value is set to
; 24 hours. The NagVis session cookie contents will be renewed on every page
; visit. If a session is idle for more time than configured here it will become
; invalid.

sesscookieduration="86400"

;
; Start page to redirect the user to when first visiting NagVis without
; special parameters.

startmodule="Overview"


startaction="view"

; The startshow parameter is only used by some views at the moment. It is used
; by the Map module.

startshow=""

;
; Turn on to enable some shinken related features in NagVis, like the
; min_business_impact-filter on automaps which can be used to render automaps
; based on the shinken attribute "business_impact".

shinken_features="0"


; Path definitions
[paths]
; absolute physical NagVis path

base="{{data.nagvis_ini_php.paths.base}}"

; absolute html NagVis path

htmlbase="{{data.nagvis_ini_php.paths.htmlbase}}"

; absolute html NagVis cgi path

htmlcgi="{{data.nagvis_ini_php.paths.htmlcgi}}"


; Default values which get inherited to the maps and its objects
[defaults]
; default backend (id of the default backend)

backend="{{data.nagvis_ini_php.defaults.backend}}"

; background color of maps
backgroundcolor="transparent"

; Enable/Disable the context menu on map objects. With the context menu you are
; able to bind commands or links to your map objects
contextmenu="1"

; Choose the default context template
contexttemplate="default"

; Raise frontend events for problematic objects also on page loading. Set to 1 to
; enable this feature
event_on_load="0"

; Repeat frontend events in the given interval. The interval is configured in seconds.
event_repeat_interval="0"

; The time in seconds to repeat alerts for a problematic ojects for as configured in
; event_repeat_interval. This value defaults to -1, this leads to repeated events
; till the problematic state has been fixed.
event_repeat_duration="-1"

; Enable/Disable changing background color on state changes (Configured color is
; shown when summary state is PENDING, OK or UP)
eventbackground="0"

; Enable/Disable highlighting of the state changing object by adding a flashing
; border
eventhighlight="1"

; The duration of the event highlight in milliseconds (10 seconds by default)
eventhighlightduration="10000"

; The interval of the event highlight in milliseconds (0.5 seconds by default)
eventhighlightinterval="500"

; Enable/Disable the eventlog in the new javascript frontend. The eventlog keeps
; track of important actions and information
eventlog="0"

; Loglevel of the eventlog (available: debug, info, warning, critical)
eventloglevel="info"

; Number of events kept in the scrollback
eventlogevents="24"

; Height of the eventlog when visible in px
eventlogheight="100"

; Hide/Show the eventlog on page load
eventloghidden="1"

; Enable/Disable scrolling to the icon which changed the state when the icon is
; out of the visible scope
eventscroll="1"

; Enable/Disable sound signals on state changes
eventsound="1"

; enable/disable header menu
headermenu="1"

; header template
headertemplate="default"

; Enable/Diable the fading effect of the submenus in the header menu
headerfade="0"

; enable/disable hover menu
hovermenu="1"

; hover template
hovertemplate="default"

; hover menu open delay (seconds)
hoverdelay="0"

; show children in hover menus
hoverchildsshow="1"

; limit shown child objects to n
hoverchildslimit="10"

; order method of children (desc: descending, asc: ascending)
hoverchildsorder="asc"

; sort method of children (s: state, a: alphabetical)
hoverchildssort="a"

; default icons

icons="std_medium"

; recognize only hard states (not soft)
onlyhardstates="0"

; recognize service states in host/hostgroup objects
recognizeservices="1"

; show map in lists (dropdowns, index page, ...)
showinlists="1"

; Name of the custom stylesheet to use on the maps (The file needs to be located
; in the share/nagvis/styles directory)

; target for the icon links
urltarget="_self"

; URL template for host object links
hosturl="[htmlcgi]/status.cgi?host=[host_name]"

; URL template for hostgroup object links
hostgroupurl="[htmlcgi]/status.cgi?hostgroup=[hostgroup_name]"

; URL template for service object links
serviceurl="[htmlcgi]/extinfo.cgi?type=2&host=[host_name]&service=[service_description]"

; URL template for servicegroup object links
servicegroupurl="[htmlcgi]/status.cgi?servicegroup=[servicegroup_name]&style=detail"

; URL template for nested map links
mapurl="[htmlbase]/index.php?mod=Map&act=view&show=[map_name]"

; Templates to be used for the different views.
view_template="default"

; Enable/disable object labels for all objects
label_show="0"

; Configure the colors used by weathermap lines
line_weather_colors="10:#8c00ff,25:#2020ff,40:#00c0ff,55:#00f000,70:#f0f000,85:#ffc000,100:#ff0000"


; Options to configure the Overview page of NagVis
[index]
; Color of the overview background
backgroundcolor="#ffffff"

; Set number of map cells per row
cellsperrow="4"

; enable/disable header menu
headermenu="1"

; header template
headertemplate="default"

; Enable/Disable map listing
showmaps="1"

; Enable/Disable geomap listing
; Note: It is disabled here since it is unfinished yet and not for production
; use in current 1.5 code.
showgeomap="0"

; Enable/Disable rotation listing
showrotations="1"

; Enable/Disable map thumbnails
showmapthumbs="0"


; Options for the Automap
[automap]
; Default URL parameters for links to the automap

defaultparams="&childLayers=2"

; Default root host (NagVis uses this if it can't detect it via backend)
; You can configure a hostname here or use "<<<monitoring>>>" as "virtual"
; node which shows the parent tree and all hosts which have no parents
; defined below the is node.

defaultroot="{{data.nagvis_ini_php.automap.defaultroot}}"

; Path to the graphviz binaries (dot,neato,...); Only needed if not in ENV PATH

graphvizpath="{{data.nagvis_ini_php.automap.graphvizpath}}"


; Options for the WUI
[wui]
; map lock time (minutes). When a user edits a map other users trying to edit
; the map are warned about this fact.
maplocktime="5"

; Show/hide the grid
grid_show="0"

; The color of the grid lines
grid_color="#F7F7F7"

; The space between the single grid lines in pixels
grid_steps="32"


; Options for the new Javascript worker
[worker]
; The interval in seconds in which the worker will check for objects which need
; to be updated
interval="{{data.nagvis_ini_php.worker.interval}}"

; The maximum number of parameters used in ajax http requests
; Some intrusion detection/prevention systems have a problem with
; too many parameters in the url. Give 0 for no limit.
requestmaxparams="0"

; The maximum length of http request urls during ajax http requests
; Some intrusion detection/prevention systems have a problem with
; queries being too long
requestmaxlength="1900"

; The retention time of the states in the frontend in seconds. The state
; information will be refreshed after this time
updateobjectstates="15"



; ----------------------------
; Backend definitions
; ----------------------------

{% if data.nagvis_ini_php.get('backends', None) %}
{% for name,backend in data.nagvis_ini_php.backends.items() %}
[backend_{{name}}]

{% for key,value in backend.items() %}
{{key}}="{{value}}"

{% endfor %}
{% endfor %}
{% endif %}

; ----------------------------
; Rotation pool definitions
; ----------------------------

{% if data.nagvis_ini_php.get('rotations', None) %}
{% for name,rotation in data.nagvis_ini_php.rotations.items() %}
[rotation_{{name}}]

{% for key,value in rotation.items() %}
{{key}}="{{value}}"

{% endfor %}
{% endfor %}
{% endif %}

; ----------------------------
; Action definitions
; ----------------------------
; Since NagVis 1.7.6 it is possible to use so called actions to extend the
; default context menu. This enables users to connect directly to the monitored
; hosts from the NagVis context menu. Here you can configure those actions.
;
; It is possible to add such actions to the context menus of service and host
; objects. They are not added blindly to all objects of those types, you can
; use the attribute "condition" to configure which objects shal have the
; specific actions. By default we use Nagios custom macros of the host object
; to make the actions visible/invisible. This filtering mechanism is not limited
; to custom macros, you can also use regular host attributes which are available
; within NagVis.
; With the option "client_os" you can configure the option to only be available
; on the clients which have a listed operating system running.

; Adds the action "connect via rdp" to service/host objects where the host object
; has the string "win" in the TAGS Nagios custom macro.
; When clicking on the link, NagVis generates a .rdp file which contains makes
; the client connect to the given host via RDP.

{% if data.nagvis_ini_php.get('actions', None) %}
{% for name,action in data.nagvis_ini_php.actions.items() %}
[action_{{name}}]

{% for key,value in action.items() %}
{{key}}="{{value}}"

{% endfor %}
{% endfor %}
{% endif %}

; ------------------------------------------------------------------------------
; Below you find some advanced stuff
; ------------------------------------------------------------------------------

; Configure different state related settings
[states]
; State coverage/weight: This defines the state handling behaviour. For example
; a critical state will cover a warning state and an acknowledged critical
; state will not cover a warning state.
;
; These options are being used when calculating the summary state of the map
; objects. The default values should fit most needs.
;

down="10"
down_ack="6"
down_downtime="6"
unreachable="9"
unreachable_ack="6"
unreachable_downtime="6"
critical="8"
critical_ack="6"
critical_downtime="6"
warning="7"
warning_ack="5"
warning_downtime="5"
unknown="4"
unknown_ack="3"
unknown_downtime="3"
error="4"
error_ack="3"
error_downtime="3"
up="2"
ok="1"
unchecked="0"
pending="0"

; Colors of the different states. The colors are used in lines and hover menus
; and for example in the frontend highlight and background event handler
; 

unreachable_bgcolor="#F1811B"
unreachable_color="#F1811B"
down_bgcolor="#FF0000"
down_color="#FF0000"
critical_bgcolor="#FF0000"
critical_color="#FF0000"
warning_bgcolor="#FFFF00"
warning_color="#FFFF00"
unknown_bgcolor="#FFCC66"
unknown_color="#FFCC66"
error_bgcolor="#0000FF"
error_color="#0000FF"
up_bgcolor="#00FF00"
up_color="#00FF00"
ok_bgcolor="#00FF00"
ok_color="#00FF00"
unchecked_bgcolor="#C0C0C0"
unchecked_color="#C0C0C0"
pending_bgcolor="#C0C0C0"
pending_color="#C0C0C0"

;
; Sound of the different states to be used by the sound eventhandler in the
; frontend. The sounds are only being fired when changing to some
; worse state.
;

unreachable_sound="std_unreachable.mp3"
down_sound="std_down.mp3"
critical_sound="std_critical.mp3"
warning_sound="std_warning.mp3"

; -------------------------
; EOF
; -------------------------
