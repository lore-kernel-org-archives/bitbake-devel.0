Return-Path: <ross.burton@intel.com>
Received: from mail-qk0-f180.google.com (mail-qk0-f180.google.com
	[209.85.220.180])
	by mail.openembedded.org (Postfix) with ESMTP id AC5E760043
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 09:32:36 +0000 (UTC)
Received: by qkbm65 with SMTP id m65so55800848qkb.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 02:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=qICKWqeDs8YDXd6G1mo4sD/0NiPBOw6gCq2Bj+h8hlA=;
	b=j7kTYWsNj+3M7LLZuvUVSInHrw7+tJ/7Pkbtfev2wuUctGhWVXOV0AJmx6CRfzphtJ
	a0TiCdiBvk9eeZyw1BQLGpZL77VyUttrUHj/bqKyBpP7DNeot3JwulAndT5LxNfM8ytN
	0fT9gs2Sv/7mTjyMccXiwU5pp3mec9YCwsoKX0iFX8L4UlAdb9KV0vLTx58Go/oWQn+o
	hAEgoGSz/QLNaTLqresPL9vgMa2M/RufDdC4xMphJefmbfGj+7SrpcD8kCP3ibJNlYM3
	M1d7xLIXp18OLVOLGzB+kJajOM6AbQ7CChbmtciQJgVyg6EZo4lVzwCQsYOzjHGDoBBl
	Hauw==
X-Gm-Message-State: ALoCoQm9wWeo3EetoETRJuK4PRBY52eti04cqON4TJxb7Kz+ZITltP3cQaZiuDrUDC7k5tiBi/Dw
X-Received: by 10.55.55.82 with SMTP id e79mr10949970qka.100.1439890356986;
	Tue, 18 Aug 2015 02:32:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.98.67 with HTTP; Tue, 18 Aug 2015 02:32:17 -0700 (PDT)
In-Reply-To: <4f97e8585f449c28d935e5859f619b1a05e5210a.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
	<4f97e8585f449c28d935e5859f619b1a05e5210a.1439809654.git.paul.eggleton@linux.intel.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 18 Aug 2015 10:32:17 +0100
Message-ID: <CAJTo0LagN2RZRA0G1LW=nQMTRBidy0T87q5HMY_2BYZkd3nPVw@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 07/13] lib/bb/main: consolidate UI/server extension listing and loading
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 18 Aug 2015 09:32:43 -0000
Content-Type: multipart/alternative; boundary=001a114900f43e7a8f051d929964

--001a114900f43e7a8f051d929964
Content-Type: text/plain; charset=UTF-8

It looks like this is responsible for some autobuilder failures where
bitbake decides to use hob instead of knotty2 and aborts on start up with:

FATAL: Hob requires Gtk+ 2.20.0 or higher, PyGtk 2.21.0 or higher (No
module named gobject).

Ross

On 17 August 2015 at 12:12, Paul Eggleton <paul.eggleton@linux.intel.com>
wrote:

> Provide us with a means of showing the list of UIs / server choices for
> the command line help, and do the processing in one place for both.
>
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  lib/bb/main.py | 78
> ++++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 48 insertions(+), 30 deletions(-)
>
> diff --git a/lib/bb/main.py b/lib/bb/main.py
> index 4d77408..2b720aa 100755
> --- a/lib/bb/main.py
> +++ b/lib/bb/main.py
> @@ -41,22 +41,45 @@ logger = logging.getLogger("BitBake")
>  class BBMainException(Exception):
>      pass
>
> -def get_ui(config):
> -    if not config.ui:
> -        # modify 'ui' attribute because it is also read by cooker
> -        config.ui = os.environ.get('BITBAKE_UI', 'knotty')
> -
> -    interface = config.ui
> -
> +def list_extension_modules(pkg, checkattr):
> +    """
> +    Lists extension modules in a specific Python package
> +    (e.g. UIs, servers)
> +    Parameters:
> +        pkg: previously imported Python package to list
> +        checkattr: attribute to look for in module to determine if it's
> valid
> +            as the type of extension you are looking for
> +    """
> +    import pkgutil
> +    pkgdir = os.path.dirname(pkg.__file__)
> +
> +    modules = []
> +    for _, modulename, _ in pkgutil.iter_modules([pkgdir]):
> +        if os.path.isdir(os.path.join(pkgdir, modulename)):
> +            # ignore directories
> +            continue
> +        try:
> +            module = __import__(pkg.__name__, fromlist=[modulename])
> +        except ImportError:
> +            # If we can't import it, it's not valid
> +            continue
> +        module_if = getattr(module, modulename)
> +        if getattr(module_if, 'hidden_extension', False):
> +            continue
> +        if not checkattr or hasattr(module_if, checkattr):
> +            modules.append(modulename)
> +    return modules
> +
> +def import_extension_module(pkg, modulename):
>      try:
>          # Dynamically load the UI based on the ui name. Although we
>          # suggest a fixed set this allows you to have flexibility in which
>          # ones are available.
> -        module = __import__("bb.ui", fromlist = [interface])
> -        return getattr(module, interface)
> +        module = __import__(pkg.__name__, fromlist = [modulename])
> +        return getattr(module, modulename)
>      except AttributeError:
> -        raise BBMainException("FATAL: Invalid user interface '%s'
> specified.\n"
> -                 "Valid interfaces: depexp, goggle, ncurses, hob, knotty
> [default]." % interface)
> +        raise BBMainException("FATAL: Unable to import extension module
> %s from %s" % (modulename, pkg.__name__))
> +
>
>
>  # Display bitbake/OE warnings via the BitBake.Warnings logger, ignoring
> others"""
> @@ -146,11 +169,19 @@ class
> BitBakeConfigParameters(cookerdata.ConfigParameters):
>          parser.add_option("-P", "--profile", help = "Profile the command
> and save reports.",
>                     action = "store_true", dest = "profile", default =
> False)
>
> -        parser.add_option("-u", "--ui", help = "The user interface to use
> (e.g. knotty, hob, depexp).",
> -                   action = "store", dest = "ui")
> +        env_ui = os.environ.get('BITBAKE_UI', None)
> +        valid_uis = list_extension_modules(bb.ui, 'main')
> +        default_ui = env_ui or 'knotty'
> +        if env_ui and not env_ui in valid_uis:
> +            raise BBMainException('Invalid UI "%s" specified in
> BITBAKE_UI environment variable - valid choices: %s' % (env_ui, ',
> '.join(valid_uis)))
> +        elif not default_ui in valid_uis:
> +            raise BBMainException('Default UI "%s" could not be found')
> +        parser.add_option("-u", "--ui", help = "The user interface to use
> (%s)." % ', '.join(valid_uis),
> +                   action="store", dest="ui", type="choice",
> choices=valid_uis, default=default_ui)
>
> -        parser.add_option("-t", "--servertype", help = "Choose which
> server to use, process or xmlrpc.",
> -                   action = "store", dest = "servertype")
> +        valid_server_types = list_extension_modules(bb.server,
> 'BitBakeServer')
> +        parser.add_option("-t", "--servertype", help = "Choose which
> server type to use (%s)." % ', '.join(valid_server_types),
> +                   action = "store", dest = "servertype", default =
> "process")
>
>          parser.add_option("", "--token", help = "Specify the connection
> token to be used when connecting to a remote server.",
>                     action = "store", dest = "xmlrpctoken")
> @@ -279,21 +310,8 @@ def bitbake_main(configParams, configuration):
>
>      configuration.setConfigParameters(configParams)
>
> -    ui_module = get_ui(configParams)
> -
> -    # Server type can be xmlrpc or process currently, if nothing is
> specified,
> -    # the default server is process
> -    if configParams.servertype:
> -        server_type = configParams.servertype
> -    else:
> -        server_type = 'process'
> -
> -    try:
> -        module = __import__("bb.server", fromlist = [server_type])
> -        servermodule = getattr(module, server_type)
> -    except AttributeError:
> -        raise BBMainException("FATAL: Invalid server type '%s'
> specified.\n"
> -                              "Valid interfaces: xmlrpc, process
> [default]." % server_type)
> +    ui_module = import_extension_module(bb.ui, configParams.ui)
> +    servermodule = import_extension_module(bb.server,
> configParams.servertype)
>
>      if configParams.server_only:
>          if configParams.servertype != "xmlrpc":
> --
> 2.1.0
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--001a114900f43e7a8f051d929964
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">It looks like this is responsible for some autobuilder fai=
lures where bitbake decides to use hob instead of knotty2 and aborts on sta=
rt up with:<br><br>FATAL: Hob requires Gtk+ 2.20.0 or higher, PyGtk 2.21.0 =
or higher (No module named gobject).<div><br></div><div>Ross</div></div><di=
v class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 17 August 2015 at=
 12:12, Paul Eggleton <span dir=3D"ltr">&lt;<a href=3D"mailto:paul.eggleton=
@linux.intel.com" target=3D"_blank">paul.eggleton@linux.intel.com</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">Provide us with a means of s=
howing the list of UIs / server choices for<br>
the command line help, and do the processing in one place for both.<br>
<br>
Signed-off-by: Paul Eggleton &lt;<a href=3D"mailto:paul.eggleton@linux.inte=
l.com">paul.eggleton@linux.intel.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/main.py | 78 ++++++++++++++++++++++++++++++++++++-------------=
---------<br>
=C2=A01 file changed, 48 insertions(+), 30 deletions(-)<br>
<br>
diff --git a/lib/bb/main.py b/lib/bb/main.py<br>
index 4d77408..2b720aa 100755<br>
--- a/lib/bb/main.py<br>
+++ b/lib/bb/main.py<br>
@@ -41,22 +41,45 @@ logger =3D logging.getLogger(&quot;BitBake&quot;)<br>
=C2=A0class BBMainException(Exception):<br>
=C2=A0 =C2=A0 =C2=A0pass<br>
<br>
-def get_ui(config):<br>
-=C2=A0 =C2=A0 if not config.ui:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # modify &#39;ui&#39; attribute because it is =
also read by cooker<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 config.ui =3D os.environ.get(&#39;BITBAKE_UI&#=
39;, &#39;knotty&#39;)<br>
-<br>
-=C2=A0 =C2=A0 interface =3D config.ui<br>
-<br>
+def list_extension_modules(pkg, checkattr):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Lists extension modules in a specific Python package<br>
+=C2=A0 =C2=A0 (e.g. UIs, servers)<br>
+=C2=A0 =C2=A0 Parameters:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkg: previously imported Python package to lis=
t<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 checkattr: attribute to look for in module to =
determine if it&#39;s valid<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 as the type of extension you are=
 looking for<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 import pkgutil<br>
+=C2=A0 =C2=A0 pkgdir =3D os.path.dirname(pkg.__file__)<br>
+<br>
+=C2=A0 =C2=A0 modules =3D []<br>
+=C2=A0 =C2=A0 for _, modulename, _ in pkgutil.iter_modules([pkgdir]):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.isdir(os.path.join(pkgdir, modulena=
me)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # ignore directories<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 module =3D __import__(pkg.__name=
__, fromlist=3D[modulename])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except ImportError:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # If we can&#39;t import it, it&=
#39;s not valid<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 module_if =3D getattr(module, modulename)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if getattr(module_if, &#39;hidden_extension&#3=
9;, False):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not checkattr or hasattr(module_if, checkat=
tr):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 modules.append(modulename)<br>
+=C2=A0 =C2=A0 return modules<br>
+<br>
+def import_extension_module(pkg, modulename):<br>
=C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Dynamically load the UI based on the ui=
 name. Although we<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# suggest a fixed set this allows you to =
have flexibility in which<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# ones are available.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 module =3D __import__(&quot;bb.ui&quot;, froml=
ist =3D [interface])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return getattr(module, interface)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 module =3D __import__(pkg.__name__, fromlist =
=3D [modulename])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return getattr(module, modulename)<br>
=C2=A0 =C2=A0 =C2=A0except AttributeError:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise BBMainException(&quot;FATAL: Invalid use=
r interface &#39;%s&#39; specified.\n&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Valid =
interfaces: depexp, goggle, ncurses, hob, knotty [default].&quot; % interfa=
ce)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise BBMainException(&quot;FATAL: Unable to i=
mport extension module %s from %s&quot; % (modulename, pkg.__name__))<br>
+<br>
<br>
<br>
=C2=A0# Display bitbake/OE warnings via the BitBake.Warnings logger, ignori=
ng others&quot;&quot;&quot;<br>
@@ -146,11 +169,19 @@ class BitBakeConfigParameters(cookerdata.ConfigParame=
ters):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parser.add_option(&quot;-P&quot;, &quot;-=
-profile&quot;, help =3D &quot;Profile the command and save reports.&quot;,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actio=
n =3D &quot;store_true&quot;, dest =3D &quot;profile&quot;, default =3D Fal=
se)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 parser.add_option(&quot;-u&quot;, &quot;--ui&q=
uot;, help =3D &quot;The user interface to use (e.g. knotty, hob, depexp).&=
quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0actio=
n =3D &quot;store&quot;, dest =3D &quot;ui&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env_ui =3D os.environ.get(&#39;BITBAKE_UI&#39;=
, None)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 valid_uis =3D list_extension_modules(bb.ui, &#=
39;main&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default_ui =3D env_ui or &#39;knotty&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if env_ui and not env_ui in valid_uis:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise BBMainException(&#39;Inval=
id UI &quot;%s&quot; specified in BITBAKE_UI environment variable - valid c=
hoices: %s&#39; % (env_ui, &#39;, &#39;.join(valid_uis)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif not default_ui in valid_uis:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise BBMainException(&#39;Defau=
lt UI &quot;%s&quot; could not be found&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 parser.add_option(&quot;-u&quot;, &quot;--ui&q=
uot;, help =3D &quot;The user interface to use (%s).&quot; % &#39;, &#39;.j=
oin(valid_uis),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0actio=
n=3D&quot;store&quot;, dest=3D&quot;ui&quot;, type=3D&quot;choice&quot;, ch=
oices=3Dvalid_uis, default=3Ddefault_ui)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 parser.add_option(&quot;-t&quot;, &quot;--serv=
ertype&quot;, help =3D &quot;Choose which server to use, process or xmlrpc.=
&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0actio=
n =3D &quot;store&quot;, dest =3D &quot;servertype&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 valid_server_types =3D list_extension_modules(=
bb.server, &#39;BitBakeServer&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 parser.add_option(&quot;-t&quot;, &quot;--serv=
ertype&quot;, help =3D &quot;Choose which server type to use (%s).&quot; % =
&#39;, &#39;.join(valid_server_types),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0actio=
n =3D &quot;store&quot;, dest =3D &quot;servertype&quot;, default =3D &quot=
;process&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parser.add_option(&quot;&quot;, &quot;--t=
oken&quot;, help =3D &quot;Specify the connection token to be used when con=
necting to a remote server.&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actio=
n =3D &quot;store&quot;, dest =3D &quot;xmlrpctoken&quot;)<br>
@@ -279,21 +310,8 @@ def bitbake_main(configParams, configuration):<br>
<br>
=C2=A0 =C2=A0 =C2=A0configuration.setConfigParameters(configParams)<br>
<br>
-=C2=A0 =C2=A0 ui_module =3D get_ui(configParams)<br>
-<br>
-=C2=A0 =C2=A0 # Server type can be xmlrpc or process currently, if nothing=
 is specified,<br>
-=C2=A0 =C2=A0 # the default server is process<br>
-=C2=A0 =C2=A0 if configParams.servertype:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 server_type =3D configParams.servertype<br>
-=C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 server_type =3D &#39;process&#39;<br>
-<br>
-=C2=A0 =C2=A0 try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 module =3D __import__(&quot;bb.server&quot;, f=
romlist =3D [server_type])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 servermodule =3D getattr(module, server_type)<=
br>
-=C2=A0 =C2=A0 except AttributeError:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise BBMainException(&quot;FATAL: Invalid ser=
ver type &#39;%s&#39; specified.\n&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Valid interfaces: xmlrpc, process [de=
fault].&quot; % server_type)<br>
+=C2=A0 =C2=A0 ui_module =3D import_extension_module(bb.ui, configParams.ui=
)<br>
+=C2=A0 =C2=A0 servermodule =3D import_extension_module(bb.server, configPa=
rams.servertype)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if configParams.server_only:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if configParams.servertype !=3D &quot;xml=
rpc&quot;:<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.0<br>
<br>
--<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</font></span></blockquote></div><br></div>

--001a114900f43e7a8f051d929964--
