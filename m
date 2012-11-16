Received: from mail-ie0-f175.google.com ([209.85.223.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <seth.boll@gmail.com>) id 1TZNNl-0007NI-Ol
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Nov 2012 15:59:02 +0100
Received: by mail-ie0-f175.google.com with SMTP id c13so3626590ieb.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Nov 2012 06:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:content-type; bh=HuTVSfTzOtB+hCQdA1g21XfrIYWRUbLpyB+C/ypL9jI=;
	b=S4al/8Vt0rPekb8SabypnlV0wcnKqWzaybWJpqyBJDmePVqmgX2N4KBo3cqUoFKNFA
	Fto7JvOhIok0TpLW5RdbNx0X3Z/w/cgEZH9Q3FbrRK1HhobC0KP3nGiMuzXPNU/xVges
	hHldEifFQmJL2RVtoLPIsOA/PyPpdgK2mk4ETBpXOEYZKPONqLRzMCcVB62dGLUo4mMN
	gsIXZUcEn/4OnfFiVlqZbHi7tMqaXg8SAK3WoHSq2/35lH7KkbFCulSwaMwlrt/eFbvp
	DM2E9A7nQbSOkSjsWgnZx/E2eSP/kSHXKFE4HzMZpdBXFwIwAzIClnGFTTewlhg+zg+a
	6ixw==
MIME-Version: 1.0
Received: by 10.50.40.225 with SMTP id a1mr3477609igl.7.1353077102794; Fri, 16
	Nov 2012 06:45:02 -0800 (PST)
Received: by 10.64.35.170 with HTTP; Fri, 16 Nov 2012 06:45:02 -0800 (PST)
In-Reply-To: <CA+JN8xN-vkLxtd+J4BZoQ39xs3Yujh-J=CQ8q+T1k0r-t-bpzA@mail.gmail.com>
References: <CA+JN8xNzAvDdt4bgS=z536YciYVAvZGE2+Z=qQa1XP4HCE8=gg@mail.gmail.com>
	<1352816623.24487.128.camel@ted>
	<CA+JN8xOF_iVQb30NVdrXEtqieh0E6m2-tSE2uG6UiG+f9C6qHw@mail.gmail.com>
	<1352820166.24487.136.camel@ted> <50A2CB5E.8030600@windriver.com>
	<CA+JN8xNDqbvnymb8pOpmEe=P5GV=WYtnLVskCNxmFPxYwkomvQ@mail.gmail.com>
	<1352899334.13332.0.camel@ted>
	<CA+JN8xMP_dhBBiFGJx2qjNs1mpWox98=BaKixPOtX_BBb3rO-g@mail.gmail.com>
	<1352935577.3709.7.camel@ted>
	<CA+JN8xN-vkLxtd+J4BZoQ39xs3Yujh-J=CQ8q+T1k0r-t-bpzA@mail.gmail.com>
Date: Fri, 16 Nov 2012 08:45:02 -0600
Message-ID: <CA+JN8xNJFQC5S8t_+_0qhYMMGnUj7oqLySesJR0hV77AwbQgaA@mail.gmail.com>
From: Seth Bollinger <seth.boll@gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Fri, 16 Nov 2012 14:59:02 -0000
Content-Type: multipart/alternative; boundary=14dae9340cb710d8a004ce9dd022

--14dae9340cb710d8a004ce9dd022
Content-Type: text/plain; charset=ISO-8859-1

Turns out the record object is shared between handlers.  This was not
obvious to me at first glance.

Hopefully this is the final patch.  :)  This is against the bitbake repo
instead of poky.  Please let me know if this is ok.

Thanks for your patience.

Seth

--------------------------------------------------------------------------------------

Colorize knotty interactive console output

Add bold color output to log level name and standard color output to log msg
when bitbake is run from an iteractive console.  Color output is only
enabled
if the terminal supports color.

Used Jason Wessel's recommendation for transparency on verbose, note and
plain.

Signed-off-by: Seth Bollinger <seth.boll@gmail.com>
---
 lib/bb/msg.py       |   43 +++++++++++++++++++++++++++++++++++++++++++
 lib/bb/ui/knotty.py |    6 +++++-
 2 files changed, 48 insertions(+), 1 deletions(-)

diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index 9b39325..007c95a 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -23,6 +23,7 @@ Message handling infrastructure for bitbake
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

 import sys
+import copy
 import logging
 import collections
 from itertools import groupby
@@ -55,6 +56,25 @@ class BBLogFormatter(logging.Formatter):
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
@@ -67,6 +87,8 @@ class BBLogFormatter(logging.Formatter):
         if record.levelno == self.PLAIN:
             msg = record.getMessage()
         else:
+            if self.color_enabled:
+                record = self.colorize(record)
             msg = logging.Formatter.format(self, record)

         if hasattr(record, 'bb_exc_info'):
@@ -75,6 +97,27 @@ class BBLogFormatter(logging.Formatter):
             msg += '\n' + ''.join(formatted)
         return msg

+    def colorize(self, record):
+        color = self.COLORS[record.levelno]
+        if self.color_enabled and color is not None:
+            record = copy.copy(record)
+            record.levelname = "".join([self.BLD % color,
record.levelname, self.RST])
+            record.msg = "".join([self.STD % color, record.msg, self.RST])
+        return record
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
index 77ec730..a63d8b1 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
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


On Wed, Nov 14, 2012 at 5:26 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:
>
> This works much better. I've realised the escape sequences are ending up
> in logfiles like the cooker log though so some further tweaking is
> needed...
>
> Also, your patches are coming through linewrapped so I have to fix them
> manually before applying.
>
> Cheers,
>
> Richard
>

--14dae9340cb710d8a004ce9dd022
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Turns out the record object is shared between handlers. =A0This was no=
t obvious to me at first glance.</div><br><div class=3D"gmail_quote">Hopefu=
lly this is the final patch. =A0:) =A0This is against the bitbake repo inst=
ead of poky. =A0Please let me know if this is ok.<div>
<br></div><div>Thanks for your patience.</div><div><br></div><div>Seth</div=
><div><br></div><div>
---------------------------------------------------------------------------=
-----------</div><div><br></div><div><div>Colorize knotty interactive conso=
le output</div><div><br></div><div>Add bold color output to log level name =
and standard color output to log msg</div>

<div>when bitbake is run from an iteractive console. =A0Color output is onl=
y enabled</div><div>if the terminal supports color.</div><div><br></div><di=
v>Used Jason Wessel&#39;s recommendation for transparency on verbose, note =
and plain.</div>

<div><br></div><div>Signed-off-by: Seth Bollinger &lt;<a href=3D"mailto:set=
h.boll@gmail.com" target=3D"_blank">seth.boll@gmail.com</a>&gt;</div><div>-=
--</div><div>=A0lib/bb/msg.py =A0 =A0 =A0 | =A0 43 ++++++++++++++++++++++++=
+++++++++++++++++++</div>
<div>
=A0lib/bb/ui/knotty.py | =A0 =A06 +++++-</div><div>=A02 files changed, 48 i=
nsertions(+), 1 deletions(-)</div><div><br></div><div>diff --git a/lib/bb/m=
sg.py b/lib/bb/msg.py</div><div>index 9b39325..007c95a 100644</div><div>---=
 a/lib/bb/msg.py</div>

<div>+++ b/lib/bb/msg.py</div><div>@@ -23,6 +23,7 @@ Message handling infra=
structure for bitbake</div><div>=A0# 51 Franklin Street, Fifth Floor, Bosto=
n, MA 02110-1301 USA.</div><div>=A0</div><div>=A0import sys</div><div>+impo=
rt copy</div>

<div>=A0import logging</div><div>=A0import collections</div><div>=A0from it=
ertools import groupby</div><div>@@ -55,6 +56,25 @@ class BBLogFormatter(lo=
gging.Formatter):</div><div>=A0 =A0 =A0 =A0 =A0CRITICAL: &#39;ERROR&#39;,</=
div><div>=A0 =A0 =A0}</div>

<div>=A0</div><div>+ =A0 =A0color_enabled =3D False</div><div>+ =A0 =A0BASE=
COLOR, BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE =3D range(29,3=
8)</div><div>+</div><div>+ =A0 =A0COLORS =3D {</div><div>+ =A0 =A0 =A0 =A0D=
EBUG3 =A0: CYAN,</div><div>

+ =A0 =A0 =A0 =A0DEBUG2 =A0: CYAN,</div><div>+ =A0 =A0 =A0 =A0DEBUG =A0 : C=
YAN,</div><div>+ =A0 =A0 =A0 =A0VERBOSE : BASECOLOR,</div><div>+ =A0 =A0 =
=A0 =A0NOTE =A0 =A0: BASECOLOR,</div><div>+ =A0 =A0 =A0 =A0PLAIN =A0 : BASE=
COLOR,</div><div>+ =A0 =A0 =A0 =A0WARNING : YELLOW,</div>

<div>+ =A0 =A0 =A0 =A0ERROR =A0 : RED,</div><div>+ =A0 =A0 =A0 =A0CRITICAL:=
 RED,</div><div>+ =A0 =A0}</div><div>+</div><div>+ =A0 =A0BLD =3D &#39;\033=
[1;%dm&#39;</div><div>+ =A0 =A0STD =3D &#39;\033[%dm&#39;</div><div>+ =A0 =
=A0RST =3D &#39;\033[0m&#39;</div><div>

+</div><div>=A0 =A0 =A0def getLevelName(self, levelno):</div><div>=A0 =A0 =
=A0 =A0 =A0try:</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0return self.levelnames=
[levelno]</div><div>@@ -67,6 +87,8 @@ class BBLogFormatter(logging.Formatte=
r):</div><div>=A0 =A0 =A0 =A0 =A0if record.levelno =3D=3D self.PLAIN:</div>

<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0msg =3D record.getMessage()</div><div>=A0 =
=A0 =A0 =A0 =A0else:</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0if self.color_enabl=
ed:</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0record =3D self.colorize(rec=
ord)</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0msg =3D logging.Formatter.format(=
self, record)</div>

<div>=A0</div><div>=A0 =A0 =A0 =A0 =A0if hasattr(record, &#39;bb_exc_info&#=
39;):</div><div>@@ -75,6 +97,27 @@ class BBLogFormatter(logging.Formatter):=
</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0msg +=3D &#39;\n&#39; + &#39;&#39;.jo=
in(formatted)</div><div>

=A0 =A0 =A0 =A0 =A0return msg</div><div>=A0</div><div>+ =A0 =A0def colorize=
(self, record):</div><div>+ =A0 =A0 =A0 =A0color =3D self.COLORS[record.lev=
elno]</div><div>+ =A0 =A0 =A0 =A0if self.color_enabled and color is not Non=
e:</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0record =3D copy.copy(record)</div>

<div>+ =A0 =A0 =A0 =A0 =A0 =A0record.levelname =3D &quot;&quot;.join([self.=
BLD % color, record.levelname, self.RST])</div><div>+ =A0 =A0 =A0 =A0 =A0 =
=A0record.msg =3D &quot;&quot;.join([self.STD % color, record.msg, self.RST=
])</div><div>+ =A0 =A0 =A0 =A0return record</div>

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

<div>index 77ec730..a63d8b1 100644</div><div>--- a/lib/bb/ui/knotty.py</div=
><div>+++ b/lib/bb/ui/knotty.py</div><div>@@ -238,12 +238,16 @@ def main(se=
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
v>1.7.2.5</div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Wed, Nov 14, 2012 at 5:26 PM, Richard Purdie <span dir=3D"ltr">&=
lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">=
richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:<blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">


This works much better. I&#39;ve realised the escape sequences are ending u=
p<br>
in logfiles like the cooker log though so some further tweaking is<br>
needed...<br>
<br>
Also, your patches are coming through linewrapped so I have to fix them<br>
manually before applying.<br>
<br>
Cheers,<br>
<br>
Richard<br></blockquote></div></div>
</div><br>

--14dae9340cb710d8a004ce9dd022--
