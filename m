Return-Path: <jacob.kroon@gmail.com>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
	[209.85.214.48])
	by mail.openembedded.org (Postfix) with ESMTP id B06BD65D58
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 13:29:19 +0000 (UTC)
Received: by mail-bk0-f48.google.com with SMTP id mx12so231552bkb.35
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Apr 2014 06:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=QHIQDg5bjUt/78ccqkvW+t0vnAJpGLgQwj/RHRoHr1E=;
	b=XTNlF2l8PNsnBQphWbYijxoigW7NywxKiXfMm7VuHrBHjMNG+nFHSdeZAST/ECFyQQ
	LTy2axX4j950m0ChrQADiNhEwgLzr7+ZIeAcoyAqQXPQKHuj5pjNgBJ57OziaJAVm7Ar
	59NR5HL8Chwd9354cLF4sMedhUL6twKkbAOryHuvamZlzvAWj+ncaLNKxqpDct2Gi8BG
	kr8sj89BtP8uv8Ba7qztMUuz453sLujqWF5IMMxi5gLXF43P+QPG6z+0bnbD8U1lYu9X
	NiKi4yNq6s5z2eKVHCkk34BWx+dGV3qVaR9arbSRkpaEefl2w5ltt5Q1HX3MWoItkdSQ
	yefQ==
MIME-Version: 1.0
X-Received: by 10.112.85.6 with SMTP id d6mr615904lbz.8.1396923372223; Mon, 07
	Apr 2014 19:16:12 -0700 (PDT)
Received: by 10.112.53.73 with HTTP; Mon, 7 Apr 2014 19:16:12 -0700 (PDT)
Date: Tue, 8 Apr 2014 04:16:12 +0200
Message-ID: <CAPbeDC=oN3w3_o6nG3Lwtrc0r33C6+95hR8nLJSYOxy0oXXDAA@mail.gmail.com>
From: Jacob Kroon <jacob.kroon@gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Problem with globs in SRC_URI
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
X-List-Received-Date: Tue, 08 Apr 2014 13:29:21 -0000
Content-Type: multipart/alternative; boundary=001a11349f4c61404204f67e918d

--001a11349f4c61404204f67e918d
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I've run into a strange problem on master. I have a recipe:

test-bug.bb
===========
LICENSE = "CLOSED"

SRC_URI = "\
    file://a \
    file://dir/* \
"
============

The accompaning test-bug/ folder looks like:
test-bug/a
test-bug/b
test-bug/dir
test-bug/dir/c

Note the extra file "b", which is not specified in the SRC_URI.

Adding debug prints according to the patch at the bottom of the mail gives
me the following output:

WARNING: #1 /home/jkroon/Projects/oe-devel/meta-monkey/recipes/test-bug/a
/home/jkroon/Projects/oe-devel/meta-monkey/recipes/test-bug/.
WARNING: #2 /home/jkroon/Projects/oe-devel/meta-monkey/recipes/test-bug/a
WARNING: #5 /home/jkroon/Projects/oe-devel/meta-monkey/recipes/test-bug/a
WARNING: #2 /home/jkroon/Projects/oe-devel/meta-monkey/recipes/test-bug/.
WARNING: #4 /home/jkroon/Projects/oe-devel/meta-monkey/recipes/test-bug/./a
WARNING: #4 /home/jkroon/Projects/oe-devel/meta-monkey/recipes/test-bug/./b
WARNING: #4
/home/jkroon/Projects/oe-devel/meta-monkey/recipes/test-bug/./dir/c

and running bitbake-diffsigs on the resulting test-bug:do_fetch signature
gives me:

This task depends on the checksums of files: [
('a', 'b026324c6904b2a9cb4b88d6d61c81d1'),
('a', 'b026324c6904b2a9cb4b88d6d61c81d1'),
('b', '26ab0db90d72e28ad0ba1e22ee510510'),
('c', '6d7fce9fee471194aa8b5b6e47267f03')
]

'a' is duplicated, and 'b' is included although I assume it shouldn't be.

The debug prints I've added are:

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 8e5342f..15f4081 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -961,13 +961,16 @@ def get_file_checksums(filelist, pn):
         return checksum

     checksums = []
+    bb.warn("#1 " + filelist)
     for pth in filelist.split():
         checksum = None
+        bb.warn("#2 " + pth)
         if '*' in pth:
             # Handle globs
             for f in glob.glob(pth):
                 checksum = checksum_file(f)
                 if checksum:
+                    bb.warn("#3 " + f)
                     checksums.append((f, checksum))
             continue
         elif os.path.isdir(pth):
@@ -977,12 +980,14 @@ def get_file_checksums(filelist, pn):
                     fullpth = os.path.join(root, name)
                     checksum = checksum_file(fullpth)
                     if checksum:
+                        bb.warn("#4 " + fullpth)
                         checksums.append((fullpth, checksum))
             continue
         else:
             checksum = checksum_file(pth)

         if checksum:
+            bb.warn("#5 " + pth)
             checksums.append((pth, checksum))

     checksums.sort(key=operator.itemgetter(1))

I've tried tracing backwards trying to understand why the '*' gets replaced
with a '.', but I get lost in the cache code.

-- Jacob

--001a11349f4c61404204f67e918d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>I&#39;ve run into a strange problem on master. =
I have a recipe:<br><br><a href=3D"http://test-bug.bb">test-bug.bb</a><br>=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>LICENSE =3D &quot;CLOSED&quot;<br><br>=
SRC_URI =3D &quot;\<br>=A0=A0=A0 file://a \<br>
=A0=A0=A0 file://dir/* \<br>&quot;<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<=
br><br>The accompaning test-bug/ folder looks like:<br>test-bug/a<br>test-b=
ug/b<br>test-bug/dir<br>test-bug/dir/c<br><br>Note the extra file &quot;b&q=
uot;, which is not specified in the SRC_URI.<br>
<br>Adding debug prints according to the patch at the bottom of the mail gi=
ves me the following output:<br><br>WARNING: #1 /home/jkroon/Projects/oe-de=
vel/meta-monkey/recipes/test-bug/a /home/jkroon/Projects/oe-devel/meta-monk=
ey/recipes/test-bug/.<br>
WARNING: #2 /home/jkroon/Projects/oe-devel/meta-monkey/recipes/test-bug/a<b=
r>WARNING: #5 /home/jkroon/Projects/oe-devel/meta-monkey/recipes/test-bug/a=
<br>WARNING: #2 /home/jkroon/Projects/oe-devel/meta-monkey/recipes/test-bug=
/.<br>
WARNING: #4 /home/jkroon/Projects/oe-devel/meta-monkey/recipes/test-bug/./a=
<br>WARNING: #4 /home/jkroon/Projects/oe-devel/meta-monkey/recipes/test-bug=
/./b<br>WARNING: #4 /home/jkroon/Projects/oe-devel/meta-monkey/recipes/test=
-bug/./dir/c<br>
<br>and running bitbake-diffsigs on the resulting test-bug:do_fetch signatu=
re gives me:<br><br>This task depends on the checksums of files: [<br>(&#39=
;a&#39;, &#39;b026324c6904b2a9cb4b88d6d61c81d1&#39;),<br>(&#39;a&#39;, &#39=
;b026324c6904b2a9cb4b88d6d61c81d1&#39;),<br>
(&#39;b&#39;, &#39;26ab0db90d72e28ad0ba1e22ee510510&#39;),<br>(&#39;c&#39;,=
 &#39;6d7fce9fee471194aa8b5b6e47267f03&#39;)<br>]<br><br>&#39;a&#39; is dup=
licated, and &#39;b&#39; is included although I assume it shouldn&#39;t be.=
<br>
<br>The debug prints I&#39;ve added are:<br><br>diff --git a/lib/bb/fetch2/=
__init__.py b/lib/bb/fetch2/__init__.py<br>index 8e5342f..15f4081 100644<br=
>--- a/lib/bb/fetch2/__init__.py<br>+++ b/lib/bb/fetch2/__init__.py<br>
@@ -961,13 +961,16 @@ def get_file_checksums(filelist, pn):<br>=A0=A0=A0=A0=
=A0=A0=A0=A0 return checksum<br>=A0<br>=A0=A0=A0=A0 checksums =3D []<br>+=
=A0=A0=A0 bb.warn(&quot;#1 &quot; + filelist)<br>=A0=A0=A0=A0 for pth in fi=
lelist.split():<br>=A0=A0=A0=A0=A0=A0=A0=A0 checksum =3D None<br>
+=A0=A0=A0=A0=A0=A0=A0 bb.warn(&quot;#2 &quot; + pth)<br>=A0=A0=A0=A0=A0=A0=
=A0=A0 if &#39;*&#39; in pth:<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # Han=
dle globs<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for f in glob.glob(pth):<=
br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 checksum =3D checksum_f=
ile(f)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if checksum:<br>
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bb.warn(&quot;#3=
 &quot; + f)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 checksums.append((f, checksum))<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 continue<br>=A0=A0=A0=A0=A0=A0=A0=A0 elif os.path.isdir(pth):<br>@@ -977,1=
2 +980,14 @@ def get_file_checksums(filelist, pn):<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fullpth =3D os=
.path.join(root, name)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 checksum =3D checksum_file(fullpth)<br>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if checksum:<br>+=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bb.warn(&quot;#4 &quot;=
 + fullpth)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 checksums.append((fullpth, checksum))<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue<br>=A0=A0=A0=A0=A0=A0=A0=A0 e=
lse:<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 checksum =3D checksum_file(pth=
)<br>=A0<br>=A0=A0=A0=A0=A0=A0=A0=A0 if checksum:<br>+=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 bb.warn(&quot;#5 &quot; + pth)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 checksums.append((pth, checksum))<br>=A0<br>
=A0=A0=A0=A0 checksums.sort(key=3Doperator.itemgetter(1))<br><br>I&#39;ve t=
ried tracing backwards trying to understand why the &#39;*&#39; gets replac=
ed with a &#39;.&#39;, but I get lost in the cache code.<br><br>-- Jacob<br=
><br></div>

--001a11349f4c61404204f67e918d--
