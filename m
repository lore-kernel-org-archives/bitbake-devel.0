Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <seth.boll@gmail.com>) id 1T1pHM-00068O-3t
	for bitbake-devel@lists.openembedded.org;
	Thu, 16 Aug 2012 03:53:44 +0200
Received: by obc16 with SMTP id 16so2868670obc.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2012 18:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=dQb1NBihNMb6Rqht/NThoATHYjzN9gEeVK8+LQuPOuI=;
	b=JDWjxwfyClnW07+N1QjHMTmGiVxLszBG9ax4pO/VzOw3BeILIHC5jQ1pw+bXbIMRcf
	65JkzXqzy3vIcm+AOMhNyThQ6otsIacR6kXGIjCuOlsfHyOEEuzycU23+JKt/YZ1dbva
	/9sPLw2+RRIew90FVVIuJ2sUszb2CO3HvfMS+6nMhyYSufDEhYcdHBTM2Vl09VzRlcTN
	h6CuMRvEStANyZGxNw3t7z0a40f/E+mlT6IeDlRCQpURoXWLVFmbzyPMAFlMSA09byLK
	OvdJCkkn5j2M563TTI6shCA19XRpOX+PtFsQ173PPujNT688OPrlNnXve708Kc0HE+7R
	SHYw==
MIME-Version: 1.0
Received: by 10.60.30.101 with SMTP id r5mr3448527oeh.68.1345081306879; Wed,
	15 Aug 2012 18:41:46 -0700 (PDT)
Received: by 10.76.33.234 with HTTP; Wed, 15 Aug 2012 18:41:46 -0700 (PDT)
Date: Wed, 15 Aug 2012 20:41:46 -0500
Message-ID: <CA+JN8xNHZUNn5FiUXAnBt=d0DabOt1A+M6RH4XGJsi1Ed2Gzbw@mail.gmail.com>
From: Seth Bollinger <seth.boll@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] Add color to bitbake interactive console log formatter
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
X-List-Received-Date: Thu, 16 Aug 2012 01:53:44 -0000
Content-Type: multipart/alternative; boundary=e89a8fb206787d97cc04c758250b

--e89a8fb206787d97cc04c758250b
Content-Type: text/plain; charset=ISO-8859-1

Add bold color output to log level name and standard color output to log msg
when bitbake is run from an iteractive console.  Color output is only
enabled
if the terminal supports colors.
---
 lib/bb/msg.py       |   40 ++++++++++++++++++++++++++++++++++++++++
 lib/bb/ui/knotty.py |    6 +++++-
 2 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index 9b39325..51e335b 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
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
+        if color is not None:
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
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 9f51823..a6f29a9 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -114,12 +114,16 @@ def main(server, eventHandler, tf = TerminalFilter):
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

--e89a8fb206787d97cc04c758250b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Add bold color output to log level name and standard color output to l=
og msg</div><div>when bitbake is run from an iteractive console. =A0Color o=
utput is only enabled</div><div>if the terminal supports colors.</div><div>
---</div><div>=A0lib/bb/msg.py =A0 =A0 =A0 | =A0 40 +++++++++++++++++++++++=
+++++++++++++++++</div><div>=A0lib/bb/ui/knotty.py | =A0 =A06 +++++-</div><=
div>=A02 files changed, 45 insertions(+), 1 deletions(-)</div><div><br></di=
v><div>diff --git a/lib/bb/msg.py b/lib/bb/msg.py</div>
<div>index 9b39325..51e335b 100644</div><div>--- a/lib/bb/msg.py</div><div>=
+++ b/lib/bb/msg.py</div><div>@@ -55,6 +55,25 @@ class BBLogFormatter(loggi=
ng.Formatter):</div><div>=A0 =A0 =A0 =A0 =A0CRITICAL: &#39;ERROR&#39;,</div=
><div>
=A0 =A0 =A0}</div><div>=A0</div><div>+ =A0 =A0color_enabled =3D False</div>=
<div>+ =A0 =A0BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE =3D ran=
ge(30,38)</div><div>+</div><div>+ =A0 =A0COLORS =3D {</div><div>+ =A0 =A0 =
=A0 =A0DEBUG3 =A0: CYAN,</div><div>
+ =A0 =A0 =A0 =A0DEBUG2 =A0: CYAN,</div><div>+ =A0 =A0 =A0 =A0DEBUG =A0 : C=
YAN,</div><div>+ =A0 =A0 =A0 =A0VERBOSE : WHITE,</div><div>+ =A0 =A0 =A0 =
=A0NOTE =A0 =A0: WHITE,</div><div>+ =A0 =A0 =A0 =A0PLAIN =A0 : WHITE,</div>=
<div>+ =A0 =A0 =A0 =A0WARNING : YELLOW,</div><div>+ =A0 =A0 =A0 =A0ERROR =
=A0 : RED,</div>
<div>+ =A0 =A0 =A0 =A0CRITICAL: RED,</div><div>+ =A0 =A0}</div><div>+ =A0 =
=A0</div><div>+ =A0 =A0BLD =3D &#39;\033[1;%dm&#39;</div><div>+ =A0 =A0STD =
=3D &#39;\033[%dm&#39;</div><div>+ =A0 =A0RST =3D &#39;\033[0m&#39;</div><d=
iv>+</div><div>=A0 =A0 =A0def getLevelName(self, levelno):</div>
<div>=A0 =A0 =A0 =A0 =A0try:</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0return se=
lf.levelnames[levelno]</div><div>@@ -67,6 +86,8 @@ class BBLogFormatter(log=
ging.Formatter):</div><div>=A0 =A0 =A0 =A0 =A0if record.levelno =3D=3D self=
.PLAIN:</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0msg =3D record.getMessage()</d=
iv>
<div>=A0 =A0 =A0 =A0 =A0else:</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0if self.co=
lor_enabled:</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.colorize(recor=
d)</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0msg =3D logging.Formatter.format(se=
lf, record)</div><div>=A0</div><div>=A0 =A0 =A0 =A0 =A0if hasattr(record, &=
#39;bb_exc_info&#39;):</div>
<div>@@ -75,6 +96,25 @@ class BBLogFormatter(logging.Formatter):</div><div>=
=A0 =A0 =A0 =A0 =A0 =A0 =A0msg +=3D &#39;\n&#39; + &#39;&#39;.join(formatte=
d)</div><div>=A0 =A0 =A0 =A0 =A0return msg</div><div>=A0</div><div>+ =A0 =
=A0def colorize(self, record):</div>
<div>+ =A0 =A0 =A0 =A0color =3D self.COLORS[record.levelno]</div><div>+ =A0=
 =A0 =A0 =A0if color is not None:</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0record=
.levelname =3D &quot;&quot;.join([self.BLD % color, record.levelname, self.=
RST])</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0record.msg =3D &quot;&quot;.join([=
self.STD % color, record.msg, self.RST])</div>
<div>+</div><div>+ =A0 =A0def enable_color(self):</div><div>+ =A0 =A0 =A0 =
=A0import curses</div><div>+ =A0 =A0 =A0 =A0try:</div><div>+ =A0 =A0 =A0 =
=A0 =A0 =A0win =3D None</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0win =3D curses.i=
nitscr()</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0if curses.has_colors():</div>
<div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.color_enabled =3D True</div><div=
>+ =A0 =A0 =A0 =A0except:</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0pass</div><div=
>+ =A0 =A0 =A0 =A0finally:</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0if win is not=
 None:</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0curses.endwin()</div>
<div>+</div><div>=A0class BBLogFilter(object):</div><div>=A0 =A0 =A0def __i=
nit__(self, handler, level, debug_domains):</div><div>=A0 =A0 =A0 =A0 =A0se=
lf.stdlevel =3D level</div><div>diff --git a/lib/bb/ui/knotty.py b/lib/bb/u=
i/knotty.py</div>
<div>index 9f51823..a6f29a9 100644</div><div>--- a/lib/bb/ui/knotty.py</div=
><div>+++ b/lib/bb/ui/knotty.py</div><div>@@ -114,12 +114,16 @@ def main(se=
rver, eventHandler, tf =3D TerminalFilter):</div><div>=A0 =A0 =A0helper =3D=
 uihelper.BBUIHelper()</div>
<div>=A0</div><div>=A0 =A0 =A0console =3D logging.StreamHandler(sys.stdout)=
</div><div>- =A0 =A0format =3D bb.msg.BBLogFormatter(&quot;%(levelname)s: %=
(message)s&quot;)</div><div>+ =A0 =A0format_str =3D &quot;%(levelname)s: %(=
message)s&quot;</div>
<div>+ =A0 =A0format =3D bb.msg.BBLogFormatter(format_str)</div><div>+ =A0 =
=A0if interactive:</div><div>+ =A0 =A0 =A0 =A0format.enable_color()</div><d=
iv>=A0 =A0 =A0bb.msg.addDefaultlogFilter(console)</div><div>=A0 =A0 =A0cons=
ole.setFormatter(format)</div>
<div>=A0 =A0 =A0logger.addHandler(console)</div><div>=A0 =A0 =A0if consolel=
ogfile:</div><div>=A0 =A0 =A0 =A0 =A0bb.utils.mkdirhier(os.path.dirname(con=
solelogfile))</div><div>+ =A0 =A0 =A0 =A0format =3D bb.msg.BBLogFormatter(f=
ormat_str)</div><div>=A0 =A0 =A0 =A0 =A0consolelog =3D logging.FileHandler(=
consolelogfile)</div>
<div>=A0 =A0 =A0 =A0 =A0bb.msg.addDefaultlogFilter(consolelog)</div><div>=
=A0 =A0 =A0 =A0 =A0consolelog.setFormatter(format)</div><div>--=A0</div><di=
v>1.7.2.5</div>

--e89a8fb206787d97cc04c758250b--
