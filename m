Return-Path: <jussi.kukkonen@intel.com>
Received: from mail-yw0-f173.google.com (mail-yw0-f173.google.com
	[209.85.161.173])
	by mail.openembedded.org (Postfix) with ESMTP id F339A77A93
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Mar 2017 08:39:38 +0000 (UTC)
Received: by mail-yw0-f173.google.com with SMTP id i203so27606723ywc.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Mar 2017 01:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:from:date:message-id:subject:to:cc;
	bh=ZLwXVTiBrXSvCBPSBimOfq8WpHY+BiyWiQ6MDIf35H0=;
	b=nRxsInHObJo44qVGST7tWU+akMAtUXtLXgK7TrbS2xfkQduYSKFpYf1wGrLaUq8nxQ
	yQIBG0sOGiXl9Vg8aeY67UYU+4U2VJh/y7bEh7yB0nThbLJQGPZUFjw3JvpjjUNA9Bn8
	YlFqZYYa0lUmDRJeK5+DdC/egp+gLGCtpLIlL596uMCNdxrMsLnljbUUARGqrIkqGKx4
	VYyF8y9Ks0JJB3/DQC4qL8JfkvrtG82E9o4HA6eMn7r/ArsFt6VLAp79x7IUT98SfIi/
	QUz4R7K4C0u0ncjjUfkCS5A/mq8pheYAX3DVGQw2wGfMAzL2ON8v1Ww5yOAlQ9Nnch5/
	dwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
	bh=ZLwXVTiBrXSvCBPSBimOfq8WpHY+BiyWiQ6MDIf35H0=;
	b=ZohCoXlpIMfsuuQQ2+ol38MqIgQe6KxmvsmNPRLaig2FTm7MbH8nhmi0y+pBYPaamC
	wOPWlZQmr9kx2XgBVxXALGJ+VOlqE1+NZkOJ9Q36WKTO92szT4FXnkA2bRlwJHbJM4ji
	jc8I0xm3xiOGZ3U/FxMYQEkpDa7Pr5Rq2iLv1QJYhKCuA3icJe0dWNC7oJ+cuPwyNCDo
	tvy/pDJjPhfa9xTTk/O2AG5kxZEbaEG0v5kfxjv0HDBB6+Wyf+8vkCnPGAhB0xKtnJja
	0GDRYuHg2S1qgi2RXO4HvAIZIBIXMPPVyOFdCMay19NxdU0KyXRXEU/uTfJ4Uq6EuKWC
	dsVQ==
X-Gm-Message-State: AFeK/H2dlF94OkJkCikF3byRhmRFmDqzfmy/g+fTMNGUsWdnQfWKauIsJ2q7WrgtOMMsne1MOKkfmfRkWtMOzJ1M
X-Received: by 10.37.174.67 with SMTP id g3mr801860ybe.189.1490258379590; Thu,
	23 Mar 2017 01:39:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.81.136 with HTTP; Thu, 23 Mar 2017 01:39:09 -0700 (PDT)
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
Date: Thu, 23 Mar 2017 10:39:09 +0200
Message-ID: <CAHiDW_Ewz6TjRW5A7V31U9128cA65EAepYoVcKHxJN43AyyD8g@mail.gmail.com>
To: daniel@lublin.se
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [1.32][PATCH 1/1] bitbake: Fix imports from html5lib >= 0.9999999/1.0b8
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
X-List-Received-Date: Thu, 23 Mar 2017 08:39:39 -0000
Content-Type: multipart/alternative; boundary=f403045ec144570546054b61d1af

--f403045ec144570546054b61d1af
Content-Type: text/plain; charset=UTF-8

On 5 December 2016 at 19:42, <daniel@lublin.se> wrote:

> From: Daniel Lublin <daniel@lublin.se>
>
> As of html5lib 0.9999999/1.0b8 (released on July 14, 2016), some modules
> have moved from _base to base. Handle this, while staying compatible
> with earlier versions.
>

This fixes a build breaking bug on newish host OSes and should be
cherry-picked to supported releases. I've tested 1.32: applies cleanly and
fixes the issue.

Thanks,
  Jussi



> Signed-off-by: Daniel Lublin <daniel@lublin.se>
> ---
>  lib/bs4/builder/_html5lib.py | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/lib/bs4/builder/_html5lib.py b/lib/bs4/builder/_html5lib.py
> index f0e5924..2b7a70a 100644
> --- a/lib/bs4/builder/_html5lib.py
> +++ b/lib/bs4/builder/_html5lib.py
> @@ -15,7 +15,14 @@ from bs4.element import (
>      whitespace_re,
>  )
>  import html5lib
> +try:
> +    # html5lib >= 0.99999999/1.0b9
> +    from html5lib.treebuilders import base as treebuildersbase
> +except ImportError:
> +    # html5lib <= 0.9999999/1.0b8
> +    from html5lib.treebuilders import _base as treebuildersbase
>  from html5lib.constants import namespaces
> +
>  from bs4.element import (
>      Comment,
>      Doctype,
> @@ -67,7 +74,7 @@ class HTML5TreeBuilder(HTMLTreeBuilder):
>          return '<html><head></head><body>%s</body></html>' % fragment
>
>
> -class TreeBuilderForHtml5lib(html5lib.treebuilders._base.TreeBuilder):
> +class TreeBuilderForHtml5lib(treebuildersbase.TreeBuilder):
>
>      def __init__(self, soup, namespaceHTMLElements):
>          self.soup = soup
> @@ -105,7 +112,7 @@ class TreeBuilderForHtml5lib(
> html5lib.treebuilders._base.TreeBuilder):
>          return self.soup
>
>      def getFragment(self):
> -        return html5lib.treebuilders._base.TreeBuilder.getFragment(self).
> element
> +        return treebuildersbase.TreeBuilder.getFragment(self).element
>
>  class AttrList(object):
>      def __init__(self, element):
> @@ -137,9 +144,9 @@ class AttrList(object):
>          return name in list(self.attrs.keys())
>
>
> -class Element(html5lib.treebuilders._base.Node):
> +class Element(treebuildersbase.Node):
>      def __init__(self, element, soup, namespace):
> -        html5lib.treebuilders._base.Node.__init__(self, element.name)
> +        treebuildersbase.Node.__init__(self, element.name)
>          self.element = element
>          self.soup = soup
>          self.namespace = namespace
> @@ -324,7 +331,7 @@ class Element(html5lib.treebuilders._base.Node):
>
>  class TextNode(Element):
>      def __init__(self, element, soup):
> -        html5lib.treebuilders._base.Node.__init__(self, None)
> +        treebuildersbase.Node.__init__(self, None)
>          self.element = element
>          self.soup = soup
>
> --
> 2.10.2
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--f403045ec144570546054b61d1af
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On 5=
 December 2016 at 19:42,  <span dir=3D"ltr">&lt;<a href=3D"mailto:daniel@lu=
blin.se" target=3D"_blank">daniel@lublin.se</a>&gt;</span> wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">From: Daniel Lublin &lt;<a href=3D"mailto:daniel@l=
ublin.se">daniel@lublin.se</a>&gt;<br>
<br>
As of html5lib 0.9999999/1.0b8 (released on July 14, 2016), some modules<br=
>
have moved from _base to base. Handle this, while staying compatible<br>
with earlier versions.<br></blockquote><div><br></div><div>This fixes a bui=
ld breaking bug on newish host OSes and should be cherry-picked to supporte=
d releases. I&#39;ve tested 1.32: applies cleanly and fixes the issue.</div=
><div><br></div><div>Thanks,</div><div>=C2=A0 Jussi</div><div><br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
Signed-off-by: Daniel Lublin &lt;<a href=3D"mailto:daniel@lublin.se">daniel=
@lublin.se</a>&gt;<br>
---<br>
=C2=A0lib/bs4/builder/_html5lib.py | 17 ++++++++++++-----<br>
=C2=A01 file changed, 12 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/lib/bs4/builder/_html5lib.py b/lib/bs4/builder/_html5lib.py<br=
>
index f0e5924..2b7a70a 100644<br>
--- a/lib/bs4/builder/_html5lib.py<br>
+++ b/lib/bs4/builder/_html5lib.py<br>
@@ -15,7 +15,14 @@ from bs4.element import (<br>
=C2=A0 =C2=A0 =C2=A0whitespace_re,<br>
=C2=A0)<br>
=C2=A0import html5lib<br>
+try:<br>
+=C2=A0 =C2=A0 # html5lib &gt;=3D 0.99999999/1.0b9<br>
+=C2=A0 =C2=A0 from html5lib.treebuilders import base as treebuildersbase<b=
r>
+except ImportError:<br>
+=C2=A0 =C2=A0 # html5lib &lt;=3D 0.9999999/1.0b8<br>
+=C2=A0 =C2=A0 from html5lib.treebuilders import _base as treebuildersbase<=
br>
=C2=A0from html5lib.constants import namespaces<br>
+<br>
=C2=A0from bs4.element import (<br>
=C2=A0 =C2=A0 =C2=A0Comment,<br>
=C2=A0 =C2=A0 =C2=A0Doctype,<br>
@@ -67,7 +74,7 @@ class HTML5TreeBuilder(<wbr>HTMLTreeBuilder):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &#39;&lt;html&gt;&lt;head&gt;&lt;/=
head&gt;&lt;body&gt;%s&lt;/<wbr>body&gt;&lt;/html&gt;&#39; % fragment<br>
<br>
<br>
-class TreeBuilderForHtml5lib(<wbr>html5lib.treebuilders._base.<wbr>TreeBui=
lder):<br>
+class TreeBuilderForHtml5lib(<wbr>treebuildersbase.TreeBuilder):<br>
<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self, soup, namespaceHTMLElements):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.soup =3D soup<br>
@@ -105,7 +112,7 @@ class TreeBuilderForHtml5lib(<wbr>html5lib.treebuilders=
._base.<wbr>TreeBuilder):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self.soup<br>
<br>
=C2=A0 =C2=A0 =C2=A0def getFragment(self):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return html5lib.treebuilders._base.<wbr>TreeBu=
ilder.getFragment(self).<wbr>element<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return treebuildersbase.TreeBuilder.<wbr>getFr=
agment(self).element<br>
<br>
=C2=A0class AttrList(object):<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self, element):<br>
@@ -137,9 +144,9 @@ class AttrList(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return name in list(self.attrs.keys())<br=
>
<br>
<br>
-class Element(html5lib.treebuilders.<wbr>_base.Node):<br>
+class Element(treebuildersbase.Node)<wbr>:<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self, element, soup, namespace):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 html5lib.treebuilders._base.<wbr>Node.__init__=
(self, <a href=3D"http://element.name" rel=3D"noreferrer" target=3D"_blank"=
>element.name</a>)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 treebuildersbase.Node.__init__<wbr>(self, <a h=
ref=3D"http://element.name" rel=3D"noreferrer" target=3D"_blank">element.na=
me</a>)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.element =3D element<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.soup =3D soup<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.namespace =3D namespace<br>
@@ -324,7 +331,7 @@ class Element(html5lib.treebuilders.<wbr>_base.Node):<b=
r>
<br>
=C2=A0class TextNode(Element):<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self, element, soup):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 html5lib.treebuilders._base.<wbr>Node.__init__=
(self, None)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 treebuildersbase.Node.__init__<wbr>(self, None=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.element =3D element<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.soup =3D soup<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
2.10.2<br>
<br>
--<br>
______________________________<wbr>_________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.<wbr>openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/<wbr>mailm=
an/listinfo/bitbake-devel</a><br>
</font></span></blockquote></div><br></div></div>

--f403045ec144570546054b61d1af--
