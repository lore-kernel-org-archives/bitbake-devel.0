Received: from mail-ie0-f175.google.com ([209.85.223.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <seth.boll@gmail.com>) id 1TYeOy-0006Vh-8p
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Nov 2012 15:57:16 +0100
Received: by mail-ie0-f175.google.com with SMTP id c13so662213ieb.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2012 06:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=1FYzcCPMIWUe7Vls3s5CULFa9FZjvRfJpEC4NOMDRrE=;
	b=WtLQu6uWUE86mtDv9Xkx8kfsFGdtcI4Y77DVfGwHoi1OodXpp0aIcTizj51NpG6FFO
	F6qvA1RPGBhmgUEHHorAJZlCT/Q9S/ul/KRU7oKqEM/vGj3IoplBcZhRXiU89kuzVENk
	fSTb14EC2jzBIKCfVeUqnVIDcP/cvi83nyiT7puuUA+FrDoXtpY5WVkM020ucYnVR14n
	s3Vls5a3OyMm/NHwRUckmF2e6oq9QSikhIvm0hBtFMOmHaFDf3n+Q6Y/KF+1W8P6+RBp
	qynweMToCKUsIEeVcicJ3N+q+ws0RkZO1lSc2s4bjAp//FcZr6xPatuwjGYaXWYWy3sB
	AaRA==
MIME-Version: 1.0
Received: by 10.50.0.129 with SMTP id 1mr1966400ige.21.1352904200234; Wed, 14
	Nov 2012 06:43:20 -0800 (PST)
Received: by 10.64.35.170 with HTTP; Wed, 14 Nov 2012 06:43:19 -0800 (PST)
In-Reply-To: <1352899334.13332.0.camel@ted>
References: <CA+JN8xNzAvDdt4bgS=z536YciYVAvZGE2+Z=qQa1XP4HCE8=gg@mail.gmail.com>
	<1352816623.24487.128.camel@ted>
	<CA+JN8xOF_iVQb30NVdrXEtqieh0E6m2-tSE2uG6UiG+f9C6qHw@mail.gmail.com>
	<1352820166.24487.136.camel@ted> <50A2CB5E.8030600@windriver.com>
	<CA+JN8xNDqbvnymb8pOpmEe=P5GV=WYtnLVskCNxmFPxYwkomvQ@mail.gmail.com>
	<1352899334.13332.0.camel@ted>
Date: Wed, 14 Nov 2012 08:43:19 -0600
Message-ID: <CA+JN8xMP_dhBBiFGJx2qjNs1mpWox98=BaKixPOtX_BBb3rO-g@mail.gmail.com>
From: Seth Bollinger <seth.boll@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] bitbake: Colorize knotty interactive console output
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
X-List-Received-Date: Wed, 14 Nov 2012 14:57:16 -0000
Content-Type: multipart/alternative; boundary=e89a8f5032cc4527b604ce758ea1

--e89a8f5032cc4527b604ce758ea1
Content-Type: text/plain; charset=ISO-8859-1

Add bold color output to log level name and standard color output to log msg
when bitbake is run from an iteractive console.  Color output is only
enabled
if the terminal supports color.

Used Jason Wessel's recommendation for transparency on verbose, note and
plain.

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
+    BASECOLOR, BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE =
range(29,38)
+
+    COLORS = {
+        DEBUG3  : CYAN,
+        DEBUG2  : CYAN,
+        DEBUG   : CYAN,
+        VERBOSE : BASECOLOR,
+        NOTE    : BASECOLOR,
+        PLAIN   : BASECOLOR,
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



On Wed, Nov 14, 2012 at 7:22 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2012-11-14 at 07:18 -0600, Seth Bollinger wrote:
> > Thanks!  I've tested this and it works on my dark color scheme (it's
> > better actually :)).  I also tested on white and it looks fine.  If
> > Richard is ok with this solution, I'll make the changes and submit
> > another patch.
> >
> It sounds promising, I would like to try the patch...
>
> Cheers,
>
> Richard
>
>
>
>

--e89a8f5032cc4527b604ce758ea1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Add bold color output to log level name and standard color output to l=
og msg</div><div>when bitbake is run from an iteractive console. =A0Color o=
utput is only enabled</div><div>if the terminal supports color.</div><div>
<br></div><div>Used Jason Wessel&#39;s recommendation for transparency on v=
erbose, note and plain.</div><div><br></div><div>Signed-off-by: Seth Bollin=
ger &lt;<a href=3D"mailto:seth.boll@gmail.com">seth.boll@gmail.com</a>&gt;<=
/div>
<div>---</div><div>=A0bitbake/lib/bb/msg.py =A0 =A0 =A0 | =A0 40 ++++++++++=
++++++++++++++++++++++++++++++</div><div>=A0bitbake/lib/bb/ui/knotty.py | =
=A0 =A06 +++++-</div><div>=A02 files changed, 45 insertions(+), 1 deletions=
(-)</div><div><br>
</div><div>diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py</div>=
<div>index 9b39325..68b2ad7 100644</div><div>--- a/bitbake/lib/bb/msg.py</d=
iv><div>+++ b/bitbake/lib/bb/msg.py</div><div>@@ -55,6 +55,25 @@ class BBLo=
gFormatter(logging.Formatter):</div>
<div>=A0 =A0 =A0 =A0 =A0CRITICAL: &#39;ERROR&#39;,</div><div>=A0 =A0 =A0}</=
div><div>=A0</div><div>+ =A0 =A0color_enabled =3D False</div><div>+ =A0 =A0=
BASECOLOR, BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE =3D range(=
29,38)</div><div>+</div><div>
+ =A0 =A0COLORS =3D {</div><div>+ =A0 =A0 =A0 =A0DEBUG3 =A0: CYAN,</div><di=
v>+ =A0 =A0 =A0 =A0DEBUG2 =A0: CYAN,</div><div>+ =A0 =A0 =A0 =A0DEBUG =A0 :=
 CYAN,</div><div>+ =A0 =A0 =A0 =A0VERBOSE : BASECOLOR,</div><div>+ =A0 =A0 =
=A0 =A0NOTE =A0 =A0: BASECOLOR,</div><div>+ =A0 =A0 =A0 =A0PLAIN =A0 : BASE=
COLOR,</div>
<div>+ =A0 =A0 =A0 =A0WARNING : YELLOW,</div><div>+ =A0 =A0 =A0 =A0ERROR =
=A0 : RED,</div><div>+ =A0 =A0 =A0 =A0CRITICAL: RED,</div><div>+ =A0 =A0}</=
div><div>+</div><div>+ =A0 =A0BLD =3D &#39;\033[1;%dm&#39;</div><div>+ =A0 =
=A0STD =3D &#39;\033[%dm&#39;</div><div>
+ =A0 =A0RST =3D &#39;\033[0m&#39;</div><div>+</div><div>=A0 =A0 =A0def get=
LevelName(self, levelno):</div><div>=A0 =A0 =A0 =A0 =A0try:</div><div>=A0 =
=A0 =A0 =A0 =A0 =A0 =A0return self.levelnames[levelno]</div><div>@@ -67,6 +=
86,8 @@ class BBLogFormatter(logging.Formatter):</div>
<div>=A0 =A0 =A0 =A0 =A0if record.levelno =3D=3D self.PLAIN:</div><div>=A0 =
=A0 =A0 =A0 =A0 =A0 =A0msg =3D record.getMessage()</div><div>=A0 =A0 =A0 =
=A0 =A0else:</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0if self.color_enabled:</div=
><div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.colorize(record)</div>
<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0msg =3D logging.Formatter.format(self, reco=
rd)</div><div>=A0</div><div>=A0 =A0 =A0 =A0 =A0if hasattr(record, &#39;bb_e=
xc_info&#39;):</div><div>@@ -75,6 +96,25 @@ class BBLogFormatter(logging.Fo=
rmatter):</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0msg +=3D &#39;\n&#39; + &#39=
;&#39;.join(formatted)</div>
<div>=A0 =A0 =A0 =A0 =A0return msg</div><div>=A0</div><div>+ =A0 =A0def col=
orize(self, record):</div><div>+ =A0 =A0 =A0 =A0color =3D self.COLORS[recor=
d.levelno]</div><div>+ =A0 =A0 =A0 =A0if self.color_enabled and color is no=
t None:</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0record.levelname =3D &quot;&quot=
;.join([self.BLD % color, record.levelname, self.RST])</div>
<div>+ =A0 =A0 =A0 =A0 =A0 =A0record.msg =3D &quot;&quot;.join([self.STD % =
color, record.msg, self.RST])</div><div>+</div><div>+ =A0 =A0def enable_col=
or(self):</div><div>+ =A0 =A0 =A0 =A0import curses</div><div>+ =A0 =A0 =A0 =
=A0try:</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0win =3D None</div>
<div>+ =A0 =A0 =A0 =A0 =A0 =A0win =3D curses.initscr()</div><div>+ =A0 =A0 =
=A0 =A0 =A0 =A0if curses.has_colors():</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0self.color_enabled =3D True</div><div>+ =A0 =A0 =A0 =A0except:</div>=
<div>+ =A0 =A0 =A0 =A0 =A0 =A0pass</div><div>+ =A0 =A0 =A0 =A0finally:</div=
>
<div>+ =A0 =A0 =A0 =A0 =A0 =A0if win is not None:</div><div>+ =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0curses.endwin()</div><div>+</div><div>=A0class BBLogFilt=
er(object):</div><div>=A0 =A0 =A0def __init__(self, handler, level, debug_d=
omains):</div><div>=A0 =A0 =A0 =A0 =A0self.stdlevel =3D level</div>
<div>diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py=
</div><div>index b99a121..d9aa973 100644</div><div>--- a/bitbake/lib/bb/ui/=
knotty.py</div><div>+++ b/bitbake/lib/bb/ui/knotty.py</div><div>@@ -238,12 =
+238,16 @@ def main(server, eventHandler, tf =3D TerminalFilter):</div>
<div>=A0 =A0 =A0helper =3D uihelper.BBUIHelper()</div><div>=A0</div><div>=
=A0 =A0 =A0console =3D logging.StreamHandler(sys.stdout)</div><div>- =A0 =
=A0format =3D bb.msg.BBLogFormatter(&quot;%(levelname)s: %(message)s&quot;)=
</div><div>+ =A0 =A0format_str =3D &quot;%(levelname)s: %(message)s&quot;</=
div>
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
v>1.7.2.5</div><div><br></div><div class=3D"gmail_extra"><br><br><div class=
=3D"gmail_quote">On Wed, Nov 14, 2012 at 7:22 AM, Richard Purdie <span dir=
=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=
=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On Wed, 2012-11-14 at 07:18 -0600, Seth Boll=
inger wrote:<br>
&gt; Thanks! =A0I&#39;ve tested this and it works on my dark color scheme (=
it&#39;s<br>
&gt; better actually :)). =A0I also tested on white and it looks fine. =A0I=
f<br>
&gt; Richard is ok with this solution, I&#39;ll make the changes and submit=
<br>
&gt; another patch.<br>
&gt;<br>
It sounds promising, I would like to try the patch...<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
<br>
</blockquote></div><br></div>

--e89a8f5032cc4527b604ce758ea1--
