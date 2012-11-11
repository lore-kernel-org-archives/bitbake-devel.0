Received: from mail-ie0-f175.google.com ([209.85.223.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <seth.boll@gmail.com>) id 1TXZVV-00086y-Hx
	for bitbake-devel@lists.openembedded.org;
	Sun, 11 Nov 2012 16:31:33 +0100
Received: by mail-ie0-f175.google.com with SMTP id c13so8060259ieb.6
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Nov 2012 07:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=l1zigdY0NLLPupR8aDorzSBURdiMIoO6eD0LU7wriPU=;
	b=WJV1YxTmK0DDoFoR8cvgvw4ssswRQVNTJ1styXbmciMC6BZNQxr/tlKQF3NmuX4zdK
	typS1SxA7MVdWElVcz/dTd18GpPmjjvjMqWjW6oyX81YaooadulX4+rIzyfLKvx9EU+W
	Eq5IglXSQNZmVeKasOxQkOAH3iYLNsLuKAujB0HGjYCbK3m/566dlqu8BPNnuXkK2a4I
	dCP9lXNNA58AYerIaeiBNtpHvF7LxxIx7ymhd8lcsbMd+dLj88l3wwjUmdCMLLld2jgB
	HesNopJxnj4PCelAsu5HZCq6UY0SB4GE8LwoRTAww6bhglOwDU4eiGW48xx7wjlGt4KL
	wHbA==
MIME-Version: 1.0
Received: by 10.50.17.129 with SMTP id o1mr5594985igd.21.1352647060965; Sun,
	11 Nov 2012 07:17:40 -0800 (PST)
Received: by 10.64.35.170 with HTTP; Sun, 11 Nov 2012 07:17:40 -0800 (PST)
Date: Sun, 11 Nov 2012 09:17:40 -0600
Message-ID: <CA+JN8xNzAvDdt4bgS=z536YciYVAvZGE2+Z=qQa1XP4HCE8=gg@mail.gmail.com>
From: Seth Bollinger <seth.boll@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] bitbake: Colorize knotty interactive console output
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 11 Nov 2012 15:31:33 -0000
Content-Type: multipart/alternative; boundary=14dae93407e593496204ce39affe

--14dae93407e593496204ce39affe
Content-Type: text/plain; charset=ISO-8859-1

Add bold color output to log level name and standard color output to log msg
when bitbake is run from an iteractive console.  Color output is only
enabled
if the terminal supports color.

Signed-off-by: Seth Bollinger <seth.boll@gmail.com>
---
 bitbake/lib/bb/msg.py       |   40 ++++++++++++++++++++++++++++++++++++++++
 bitbake/lib/bb/ui/knotty.py |    6 +++++-
 2 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index 9b39325..68b2ad7 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -55,6 +55,25 @@ class BBLogFormatter(logging.Formatter):
         CRITICAL: 'ERROR',
     }

+    color_enabled = False
+    BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE = range(30,38)
+
+    COLORS = {
+        DEBUG3  : CYAN,
+        DEBUG2  : CYAN,
+        DEBUG   : CYAN,
+        VERBOSE : WHITE,
+        NOTE    : WHITE,
+        PLAIN   : WHITE,
+        WARNING : YELLOW,
+        ERROR   : RED,
+        CRITICAL: RED,
+    }
+
+    BLD = '\033[1;%dm'
+    STD = '\033[%dm'
+    RST = '\033[0m'
+
     def getLevelName(self, levelno):
         try:
             return self.levelnames[levelno]
@@ -67,6 +86,8 @@ class BBLogFormatter(logging.Formatter):
         if record.levelno == self.PLAIN:
             msg = record.getMessage()
         else:
+            if self.color_enabled:
+                self.colorize(record)
             msg = logging.Formatter.format(self, record)

         if hasattr(record, 'bb_exc_info'):
@@ -75,6 +96,25 @@ class BBLogFormatter(logging.Formatter):
             msg += '\n' + ''.join(formatted)
         return msg

+    def colorize(self, record):
+        color = self.COLORS[record.levelno]
+        if self.color_enabled and color is not None:
+            record.levelname = "".join([self.BLD % color,
record.levelname, self.RST])
+            record.msg = "".join([self.STD % color, record.msg, self.RST])
+
+    def enable_color(self):
+        import curses
+        try:
+            win = None
+            win = curses.initscr()
+            if curses.has_colors():
+                self.color_enabled = True
+        except:
+            pass
+        finally:
+            if win is not None:
+                curses.endwin()
+
 class BBLogFilter(object):
     def __init__(self, handler, level, debug_domains):
         self.stdlevel = level
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index b99a121..d9aa973 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -238,12 +238,16 @@ def main(server, eventHandler, tf = TerminalFilter):
     helper = uihelper.BBUIHelper()

     console = logging.StreamHandler(sys.stdout)
-    format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
+    format_str = "%(levelname)s: %(message)s"
+    format = bb.msg.BBLogFormatter(format_str)
+    if interactive:
+        format.enable_color()
     bb.msg.addDefaultlogFilter(console)
     console.setFormatter(format)
     logger.addHandler(console)
     if consolelogfile:
         bb.utils.mkdirhier(os.path.dirname(consolelogfile))
+        format = bb.msg.BBLogFormatter(format_str)
         consolelog = logging.FileHandler(consolelogfile)
         bb.msg.addDefaultlogFilter(consolelog)
         consolelog.setFormatter(format)
-- 
1.7.2.5

--14dae93407e593496204ce39affe
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div><font face=3D"arial, sans-serif">Add bold color output to log level na=
me and standard color output to log msg</font></div><div><font face=3D"aria=
l, sans-serif">when bitbake is run from an iteractive console. =A0Color out=
put is only enabled</font></div>
<div><font face=3D"arial, sans-serif">if the terminal supports color.</font=
></div><div><font face=3D"arial, sans-serif"><br></font></div><div><font fa=
ce=3D"arial, sans-serif">Signed-off-by: Seth Bollinger &lt;<a href=3D"mailt=
o:seth.boll@gmail.com">seth.boll@gmail.com</a>&gt;</font></div>
<div><font face=3D"arial, sans-serif">---</font></div><div><font face=3D"ar=
ial, sans-serif">=A0bitbake/lib/bb/msg.py =A0 =A0 =A0 | =A0 40 ++++++++++++=
++++++++++++++++++++++++++++</font></div><div><font face=3D"arial, sans-ser=
if">=A0bitbake/lib/bb/ui/knotty.py | =A0 =A06 +++++-</font></div>
<div><font face=3D"arial, sans-serif">=A02 files changed, 45 insertions(+),=
 1 deletions(-)</font></div><div><font face=3D"arial, sans-serif"><br></fon=
t></div><div><font face=3D"arial, sans-serif">diff --git a/bitbake/lib/bb/m=
sg.py b/bitbake/lib/bb/msg.py</font></div>
<div><font face=3D"arial, sans-serif">index 9b39325..68b2ad7 100644</font><=
/div><div><font face=3D"arial, sans-serif">--- a/bitbake/lib/bb/msg.py</fon=
t></div><div><font face=3D"arial, sans-serif">+++ b/bitbake/lib/bb/msg.py</=
font></div>
<div><font face=3D"arial, sans-serif">@@ -55,6 +55,25 @@ class BBLogFormatt=
er(logging.Formatter):</font></div><div><font face=3D"arial, sans-serif">=
=A0 =A0 =A0 =A0 =A0CRITICAL: &#39;ERROR&#39;,</font></div><div><font face=
=3D"arial, sans-serif">=A0 =A0 =A0}</font></div>
<div><font face=3D"arial, sans-serif">=A0</font></div><div><font face=3D"ar=
ial, sans-serif">+ =A0 =A0color_enabled =3D False</font></div><div><font fa=
ce=3D"arial, sans-serif">+ =A0 =A0BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA,=
 CYAN, WHITE =3D range(30,38)</font></div>
<div><font face=3D"arial, sans-serif">+</font></div><div><font face=3D"aria=
l, sans-serif">+ =A0 =A0COLORS =3D {</font></div><div><font face=3D"arial, =
sans-serif">+ =A0 =A0 =A0 =A0DEBUG3 =A0: CYAN,</font></div><div><font face=
=3D"arial, sans-serif">+ =A0 =A0 =A0 =A0DEBUG2 =A0: CYAN,</font></div>
<div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =A0DEBUG =A0 : CYAN,</f=
ont></div><div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =A0VERBOSE : =
WHITE,</font></div><div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =A0N=
OTE =A0 =A0: WHITE,</font></div>
<div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =A0PLAIN =A0 : WHITE,</=
font></div><div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =A0WARNING :=
 YELLOW,</font></div><div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =
=A0ERROR =A0 : RED,</font></div>
<div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =A0CRITICAL: RED,</font=
></div><div><font face=3D"arial, sans-serif">+ =A0 =A0}</font></div><div><f=
ont face=3D"arial, sans-serif">+</font></div><div><font face=3D"arial, sans=
-serif">+ =A0 =A0BLD =3D &#39;\033[1;%dm&#39;</font></div>
<div><font face=3D"arial, sans-serif">+ =A0 =A0STD =3D &#39;\033[%dm&#39;</=
font></div><div><font face=3D"arial, sans-serif">+ =A0 =A0RST =3D &#39;\033=
[0m&#39;</font></div><div><font face=3D"arial, sans-serif">+</font></div><d=
iv><font face=3D"arial, sans-serif">=A0 =A0 =A0def getLevelName(self, level=
no):</font></div>
<div><font face=3D"arial, sans-serif">=A0 =A0 =A0 =A0 =A0try:</font></div><=
div><font face=3D"arial, sans-serif">=A0 =A0 =A0 =A0 =A0 =A0 =A0return self=
.levelnames[levelno]</font></div><div><font face=3D"arial, sans-serif">@@ -=
67,6 +86,8 @@ class BBLogFormatter(logging.Formatter):</font></div>
<div><font face=3D"arial, sans-serif">=A0 =A0 =A0 =A0 =A0if record.levelno =
=3D=3D self.PLAIN:</font></div><div><font face=3D"arial, sans-serif">=A0 =
=A0 =A0 =A0 =A0 =A0 =A0msg =3D record.getMessage()</font></div><div><font f=
ace=3D"arial, sans-serif">=A0 =A0 =A0 =A0 =A0else:</font></div>
<div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =A0 =A0 =A0if self.colo=
r_enabled:</font></div><div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0self.colorize(record)</font></div><div><font face=3D"ari=
al, sans-serif">=A0 =A0 =A0 =A0 =A0 =A0 =A0msg =3D logging.Formatter.format=
(self, record)</font></div>
<div><font face=3D"arial, sans-serif">=A0</font></div><div><font face=3D"ar=
ial, sans-serif">=A0 =A0 =A0 =A0 =A0if hasattr(record, &#39;bb_exc_info&#39=
;):</font></div><div><font face=3D"arial, sans-serif">@@ -75,6 +96,25 @@ cl=
ass BBLogFormatter(logging.Formatter):</font></div>
<div><font face=3D"arial, sans-serif">=A0 =A0 =A0 =A0 =A0 =A0 =A0msg +=3D &=
#39;\n&#39; + &#39;&#39;.join(formatted)</font></div><div><font face=3D"ari=
al, sans-serif">=A0 =A0 =A0 =A0 =A0return msg</font></div><div><font face=
=3D"arial, sans-serif">=A0</font></div>
<div><font face=3D"arial, sans-serif">+ =A0 =A0def colorize(self, record):<=
/font></div><div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =A0color =
=3D self.COLORS[record.levelno]</font></div><div><font face=3D"arial, sans-=
serif">+ =A0 =A0 =A0 =A0if self.color_enabled and color is not None:</font>=
</div>
<div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =A0 =A0 =A0record.level=
name =3D &quot;&quot;.join([self.BLD % color, record.levelname, self.RST])<=
/font></div><div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =A0 =A0 =A0=
record.msg =3D &quot;&quot;.join([self.STD % color, record.msg, self.RST])<=
/font></div>
<div><font face=3D"arial, sans-serif">+</font></div><div><font face=3D"aria=
l, sans-serif">+ =A0 =A0def enable_color(self):</font></div><div><font face=
=3D"arial, sans-serif">+ =A0 =A0 =A0 =A0import curses</font></div><div><fon=
t face=3D"arial, sans-serif">+ =A0 =A0 =A0 =A0try:</font></div>
<div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =A0 =A0 =A0win =3D None=
</font></div><div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =A0 =A0 =
=A0win =3D curses.initscr()</font></div><div><font face=3D"arial, sans-seri=
f">+ =A0 =A0 =A0 =A0 =A0 =A0if curses.has_colors():</font></div>
<div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self=
.color_enabled =3D True</font></div><div><font face=3D"arial, sans-serif">+=
 =A0 =A0 =A0 =A0except:</font></div><div><font face=3D"arial, sans-serif">+=
 =A0 =A0 =A0 =A0 =A0 =A0pass</font></div>
<div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =A0finally:</font></div=
><div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =A0 =A0 =A0if win is n=
ot None:</font></div><div><font face=3D"arial, sans-serif">+ =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0curses.endwin()</font></div>
<div><font face=3D"arial, sans-serif">+</font></div><div><font face=3D"aria=
l, sans-serif">=A0class BBLogFilter(object):</font></div><div><font face=3D=
"arial, sans-serif">=A0 =A0 =A0def __init__(self, handler, level, debug_dom=
ains):</font></div>
<div><font face=3D"arial, sans-serif">=A0 =A0 =A0 =A0 =A0self.stdlevel =3D =
level</font></div><div><font face=3D"arial, sans-serif">diff --git a/bitbak=
e/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py</font></div><div><font =
face=3D"arial, sans-serif">index b99a121..d9aa973 100644</font></div>
<div><font face=3D"arial, sans-serif">--- a/bitbake/lib/bb/ui/knotty.py</fo=
nt></div><div><font face=3D"arial, sans-serif">+++ b/bitbake/lib/bb/ui/knot=
ty.py</font></div><div><font face=3D"arial, sans-serif">@@ -238,12 +238,16 =
@@ def main(server, eventHandler, tf =3D TerminalFilter):</font></div>
<div><font face=3D"arial, sans-serif">=A0 =A0 =A0helper =3D uihelper.BBUIHe=
lper()</font></div><div><font face=3D"arial, sans-serif">=A0</font></div><d=
iv><font face=3D"arial, sans-serif">=A0 =A0 =A0console =3D logging.StreamHa=
ndler(sys.stdout)</font></div>
<div><font face=3D"arial, sans-serif">- =A0 =A0format =3D bb.msg.BBLogForma=
tter(&quot;%(levelname)s: %(message)s&quot;)</font></div><div><font face=3D=
"arial, sans-serif">+ =A0 =A0format_str =3D &quot;%(levelname)s: %(message)=
s&quot;</font></div>
<div><font face=3D"arial, sans-serif">+ =A0 =A0format =3D bb.msg.BBLogForma=
tter(format_str)</font></div><div><font face=3D"arial, sans-serif">+ =A0 =
=A0if interactive:</font></div><div><font face=3D"arial, sans-serif">+ =A0 =
=A0 =A0 =A0format.enable_color()</font></div>
<div><font face=3D"arial, sans-serif">=A0 =A0 =A0bb.msg.addDefaultlogFilter=
(console)</font></div><div><font face=3D"arial, sans-serif">=A0 =A0 =A0cons=
ole.setFormatter(format)</font></div><div><font face=3D"arial, sans-serif">=
=A0 =A0 =A0logger.addHandler(console)</font></div>
<div><font face=3D"arial, sans-serif">=A0 =A0 =A0if consolelogfile:</font><=
/div><div><font face=3D"arial, sans-serif">=A0 =A0 =A0 =A0 =A0bb.utils.mkdi=
rhier(os.path.dirname(consolelogfile))</font></div><div><font face=3D"arial=
, sans-serif">+ =A0 =A0 =A0 =A0format =3D bb.msg.BBLogFormatter(format_str)=
</font></div>
<div><font face=3D"arial, sans-serif">=A0 =A0 =A0 =A0 =A0consolelog =3D log=
ging.FileHandler(consolelogfile)</font></div><div><font face=3D"arial, sans=
-serif">=A0 =A0 =A0 =A0 =A0bb.msg.addDefaultlogFilter(consolelog)</font></d=
iv><div><font face=3D"arial, sans-serif">=A0 =A0 =A0 =A0 =A0consolelog.setF=
ormatter(format)</font></div>
<div><font face=3D"arial, sans-serif">--=A0</font></div><div><font face=3D"=
arial, sans-serif">1.7.2.5</font></div><div style=3D"font-family:arial,sans=
-serif;font-size:13px"><br></div>

--14dae93407e593496204ce39affe--
