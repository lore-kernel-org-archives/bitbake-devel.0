Return-Path: <rob.woolley@windriver.com>
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D12CDB479
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 17:20:32 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12957.1782321631221907239
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Jun 2026 10:20:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=YPLLt1PV;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0635205cc7=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEegxW2602576
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 10:20:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Yp4PteAFp2SMk7uUB2DoCl855qSVUxHdH0b9/yTEcQU=; b=
	YPLLt1PVHRY7tOMQe+NdCljoIfUGUTiXCcrRcKrNZ+HbHBA4gMEDWNTEzHlKwm+Q
	+BKv+L+5+bVUlKbPfQIsCHccUtsr+ekGxGxXs+JGrFnEQqncy2QmPPOptf8Z7Jpl
	GOKZR1UXUdk36LiFGXPccvpaHCaunmh7EJ7ACKslIbNSb6rFrgZfKDV/Bc1HNw+7
	PamLLUD0Q2Zlypuv7y4W9qG9rPWCRJQV/P6HTKdTGVV2TwJRQDflVZ1N6OdEJ84U
	zHuZ3SCsMObedIdf1knCetgxG8T58/aREFWmQZQIqdfliDuXte28vgp47W247OXz
	WwjA5xTvqoziTUjLisjOFg==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eykj1jntn-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 10:20:28 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 24 Jun 2026 10:20:13 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 24 Jun 2026 10:20:13 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Wed, 24 Jun 2026 10:20:08 -0700
Subject: [PATCH v4 08/11] Update vendorized modules
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID: <20260624-add-pypi-v8-v4-8-ff499f1fd5a5@windriver.com>
References: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
In-Reply-To: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX674QCyU/FG9K
 QlGRzBrYy5Y6tt4CeXqZGYf1TEoCIXc5yD7ZG2V+izFpk/s9eIzYPWWzNIxStL7GUBH0tiRsuiS
 tim9YswAVymcbBeQ4UB3bmxJBHaV8/RiuAIrsVhi3oNMvdthmJnKVRmwMNIpDoNXwhjL2//X3Ha
 7dixee3LC4iJVjpN/KIQLiywGpS3fnhtHqIJFAF3hcHYMHacWiBi0n6XxDLMGeW+6EyQ/Z/as7p
 x93oyHcfNYga2fcrtuX+iHxwUOMilQt85jVhDLBemO60wAYIdpz2QWUsvwenuR/PlroTe7Hnqss
 /lNoI1KpN0nbUlawCCh4lLIRkZczmRgUaB09ImOGc/N0KwoOKQwYiCB9I8ekHgbOeVf0y4+StZe
 yNbAEihpfbAq7/JOZqZU3oK20cQaJw==
X-Proofpoint-ORIG-GUID: eec6tPyEBZZ5ri-jXa8LJxXJaj6SmCZb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX6zw3jobeau0M
 FzwMwLXae0v8iXfLGI0Ss5ZU7Ou5VxZBBiY4r5jlzl53cqPZbVsZae8i5sCeqvEoEUSI5mP9DPQ
 jXfgh00oqxs0Z8q+l8kS3PJ9greymSxnOrM93v8bDrvMN5Zijr9A
X-Proofpoint-GUID: eec6tPyEBZZ5ri-jXa8LJxXJaj6SmCZb
X-Authority-Analysis: v=2.4 cv=JNILdcKb c=1 sm=1 tr=0 ts=6a3c11dd cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=CckQENj0AAAA:8
 a=danhDmx_AAAA:8 a=NEAV23lmAAAA:8 a=ekYV4lpRAAAA:8 a=48Kcd2OYAAAA:8
 a=SSmOFEACAAAA:8 a=0x2vhHYrAAAA:8 a=8AHkEIZyAAAA:8 a=IZVGuq1iAAAA:8
 a=mDV3o1hIAAAA:8 a=t7CeM3EgAAAA:8 a=bo08yYyjAAAA:8 a=HxmDso_oAAAA:8
 a=LZ1EdHRVAAAA:8 a=WP5zsaevAAAA:8 a=pGLkceISAAAA:8 a=K7ZyPv_3mASGp8tg8XoA:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=fTTRyY75f2tJ7nP0:21 a=L03L2QfmqWoA:10
 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=ImwWUX5h3JJ3gRE9moBe:22 a=mrCxpU6zTNQDHnudu_9Q:22 a=SDE4kRAlhdREaT3mAHa9:22
 a=jKTDQKFe_9NOjXLEHhtL:22 a=qnRFykaDRnJ3NeEHDCy2:22 a=FdTzh2GWekK77mhwV6Dw:22
 a=sJLr6QBoMFAj2pSMC3bB:22 a=wVk_OTPmZRE1ccVI5G2I:22 a=8WfeQlEPN7eFB_yiPD7s:22
 a=t8Kx07QrZZTALmIZmm-o:22 a=5VJXQO18lHU1uJw8Rqww:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240145
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 65OEegxW2602576
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 17:20:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19776

This was automated with "vendoring sync .".

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 lib/bb/_vendor/__init__.py                         |   18 -
 .../{bs4/LICENSE =3D> beautifulsoup4.LICENSE}        |    0
 lib/bb/_vendor/bs4/AUTHORS                         |   49 -
 lib/bb/_vendor/bs4/CHANGELOG                       | 1839 -----------
 lib/bb/_vendor/bs4/__init__.py                     |  856 +++--
 lib/bb/_vendor/bs4/_deprecation.py                 |   80 +
 lib/bb/_vendor/bs4/_typing.py                      |  205 ++
 lib/bb/_vendor/bs4/_warnings.py                    |   98 +
 lib/bb/_vendor/bs4/builder/__init__.py             |  828 +++--
 lib/bb/_vendor/bs4/builder/_html5lib.py            |  592 ++--
 lib/bb/_vendor/bs4/builder/_htmlparser.py          |  426 ++-
 lib/bb/_vendor/bs4/builder/_lxml.py                |  387 ++-
 lib/bb/_vendor/bs4/css.py                          |  268 +-
 lib/bb/_vendor/bs4/dammit.py                       | 1622 +++++----
 lib/bb/_vendor/bs4/diagnose.py                     |  169 +-
 lib/bb/_vendor/bs4/element.py                      | 3494 +++++++++++++-=
------
 lib/bb/_vendor/bs4/exceptions.py                   |   28 +
 lib/bb/_vendor/bs4/filter.py                       |  764 +++++
 lib/bb/_vendor/bs4/formatter.py                    |  211 +-
 lib/bb/_vendor/bs4/py.typed                        |    0
 lib/bb/_vendor/ply.pyi                             |    1 +
 lib/bb/_vendor/ply/__init__.py                     |    1 +
 lib/bb/_vendor/ply/cpp.py                          |  918 +++++
 lib/bb/_vendor/ply/ctokens.py                      |  133 +
 lib/bb/_vendor/ply/lex.py                          |  845 ++---
 lib/bb/_vendor/ply/yacc.py                         | 2231 +++++++------
 lib/bb/_vendor/ply/ygen.py                         |   74 +
 lib/bb/_vendor/progressbar.pyi                     |    1 +
 lib/bb/_vendor/progressbar/__init__.py             |    4 +-
 lib/bb/_vendor/progressbar/progressbar.py          |   21 +-
 lib/bb/_vendor/progressbar/widgets.py              |   14 +-
 lib/bb/_vendor/simplediff.pyi                      |    1 +
 lib/bb/_vendor/simplediff/__init__.py              |    2 +-
 33 files changed, 9570 insertions(+), 6610 deletions(-)

diff --git a/lib/bb/_vendor/__init__.py b/lib/bb/_vendor/__init__.py
deleted file mode 100644
index 3c054dc32..000000000
--- a/lib/bb/_vendor/__init__.py
+++ /dev/null
@@ -1,18 +0,0 @@
-#
-# Copyright BitBake Contributors
-#
-# SPDX-License-Identifier: GPL-2.0-only
-#
-
-"""
-Vendored third-party libraries for BitBake.
-
-These libraries have been modified from their upstream versions and are
-bundled here to avoid conflicts with system-installed packages.
-
-Vendored packages:
-    - bs4 (BeautifulSoup4)
-    - ply
-    - progressbar
-    - simplediff
-"""
diff --git a/lib/bb/_vendor/bs4/LICENSE b/lib/bb/_vendor/beautifulsoup4.L=
ICENSE
similarity index 100%
rename from lib/bb/_vendor/bs4/LICENSE
rename to lib/bb/_vendor/beautifulsoup4.LICENSE
diff --git a/lib/bb/_vendor/bs4/AUTHORS b/lib/bb/_vendor/bs4/AUTHORS
deleted file mode 100644
index 1f14fe07d..000000000
--- a/lib/bb/_vendor/bs4/AUTHORS
+++ /dev/null
@@ -1,49 +0,0 @@
-Behold, mortal, the origins of Beautiful Soup...
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Leonard Richardson is the primary maintainer.
-
-Aaron DeVore and Isaac Muse have made significant contributions to the
-code base.
-
-Mark Pilgrim provided the encoding detection code that forms the base
-of UnicodeDammit.
-
-Thomas Kluyver and Ezio Melotti finished the work of getting Beautiful
-Soup 4 working under Python 3.
-
-Simon Willison wrote soupselect, which was used to make Beautiful Soup
-support CSS selectors. Isaac Muse wrote SoupSieve, which made it
-possible to _remove_ the CSS selector code from Beautiful Soup.
-
-Sam Ruby helped with a lot of edge cases.
-
-Jonathan Ellis was awarded the prestigious Beau Potage D'Or for his
-work in solving the nestable tags conundrum.
-
-An incomplete list of people have contributed patches to Beautiful
-Soup:
-
- Istvan Albert, Andrew Lin, Anthony Baxter, Oliver Beattie, Andrew
-Boyko, Tony Chang, Francisco Canas, "Delong", Zephyr Fang, Fuzzy,
-Roman Gaufman, Yoni Gilad, Richie Hindle, Toshihiro Kamiya, Peteris
-Krumins, Kent Johnson, Marek Kapolka, Andreas Kostyrka, Roel Kramer,
-Ben Last, Robert Leftwich, Stefaan Lippens, "liquider", Staffan
-Malmgren, Ksenia Marasanova, JP Moins, Adam Monsen, John Nagle, "Jon",
-Ed Oskiewicz, Martijn Peters, Greg Phillips, Giles Radford, Stefano
-Revera, Arthur Rudolph, Marko Samastur, James Salter, Jouni Sepp=EF=BF=BD=
nen,
-Alexander Schmolck, Tim Shirley, Geoffrey Sneddon, Ville Skytt=EF=BF=BD,
-"Vikas", Jens Svalgaard, Andy Theyers, Eric Weiser, Glyn Webster, John
-Wiseman, Paul Wright, Danny Yoo
-
-An incomplete list of people who made suggestions or found bugs or
-found ways to break Beautiful Soup:
-
- Hanno B=EF=BF=BDck, Matteo Bertini, Chris Curvey, Simon Cusack, Bruce E=
ckel,
- Matt Ernst, Michael Foord, Tom Harris, Bill de hOra, Donald Howes,
- Matt Patterson, Scott Roberts, Steve Strassmann, Mike Williams,
- warchild at redho dot com, Sami Kuisma, Carlos Rocha, Bob Hutchison,
- Joren Mc, Michal Migurski, John Kleven, Tim Heaney, Tripp Lilley, Ed
- Summers, Dennis Sutch, Chris Smith, Aaron Swartz, Stuart
- Turner, Greg Edwards, Kevin J Kalupson, Nikos Kouremenos, Artur de
- Sousa Rocha, Yichun Wei, Per Vognsen
diff --git a/lib/bb/_vendor/bs4/CHANGELOG b/lib/bb/_vendor/bs4/CHANGELOG
deleted file mode 100644
index 2701446a6..000000000
--- a/lib/bb/_vendor/bs4/CHANGELOG
+++ /dev/null
@@ -1,1839 +0,0 @@
-=3D 4.12.3 (20240117)
-
-* The Beautiful Soup documentation now has a Spanish translation, thanks
-  to Carlos Romero. Delong Wang's Chinese translation has been updated
-  to cover Beautiful Soup 4.12.0.
-
-* Fixed a regression such that if you set .hidden on a tag, the tag
-  becomes invisible but its contents are still visible. User manipulatio=
n
-  of .hidden is not a documented or supported feature, so don't do this,
-  but it wasn't too difficult to keep the old behavior working.
-
-* Fixed a case found by Mengyuhan where html.parser giving up on
-  markup would result in an AssertionError instead of a
-  ParserRejectedMarkup exception.
-
-* Added the correct stacklevel to instances of the XMLParsedAsHTMLWarnin=
g.
-  [bug=3D2034451]
-
-* Corrected the syntax of the license definition in pyproject.toml. Patc=
h
-  by Louis Maddox. [bug=3D2032848]
-
-* Corrected a typo in a test that was causing test failures when run aga=
inst
-  libxml2 2.12.1. [bug=3D2045481]
-
-=3D 4.12.2 (20230407)
-
-* Fixed an unhandled exception in BeautifulSoup.decode_contents
-  and methods that call it. [bug=3D2015545]
-
-=3D 4.12.1 (20230405)
-
-NOTE: the following things are likely to be dropped in the next
-feature release of Beautiful Soup:
-
- Official support for Python 3.6.
- Inclusion of unit tests and test data in the wheel file.
- Two scripts: demonstrate_parser_differences.py and test-all-versions.
-
-Changes:
-
-* This version of Beautiful Soup replaces setup.py and setup.cfg
-  with pyproject.toml. Beautiful Soup now uses tox as its test backend
-  and hatch to do builds.
-
-* The main functional improvement in this version is a nonrecursive tech=
nique
-  for regenerating a tree. This technique is used to avoid situations wh=
ere,
-  in previous versions, doing something to a very deeply nested tree
-  would overflow the Python interpreter stack:
-
-  1. Outputting a tree as a string, e.g. with
-     BeautifulSoup.encode() [bug=3D1471755]
-
-  2. Making copies of trees (copy.copy() and
-     copy.deepcopy() from the Python standard library). [bug=3D1709837]
-
-  3. Pickling a BeautifulSoup object. (Note that pickling a Tag
-     object can still cause an overflow.)
-
-* Making a copy of a BeautifulSoup object no longer parses the
-  document again, which should improve performance significantly.
-
-* When a BeautifulSoup object is unpickled, Beautiful Soup now
-  tries to associate an appropriate TreeBuilder object with it.
-
-* Tag.prettify() will now consistently end prettified markup with
-  a newline.
-
-* Added unit tests for fuzz test cases created by third
-  parties. Some of these tests are skipped since they point
-  to problems outside of Beautiful Soup, but this change
-  puts them all in one convenient place.
-
-* PageElement now implements the known_xml attribute. (This was technica=
lly
-  a bug, but it shouldn't be an issue in normal use.) [bug=3D2007895]
-
-* The demonstrate_parser_differences.py script was still written in
-  Python 2. I've converted it to Python 3, but since no one has
-  mentioned this over the years, it's a sign that no one uses this
-  script and it's not serving its purpose.
-
-=3D 4.12.0 (20230320)
-
-* Introduced the .css property, which centralizes all access to
-  the Soup Sieve API. This allows Beautiful Soup to give direct
-  access to as much of Soup Sieve that makes sense, without cluttering
-  the BeautifulSoup and Tag classes with a lot of new methods.
-
-  This does mean one addition to the BeautifulSoup and Tag classes
-  (the .css property itself), so this might be a breaking change if you
-  happen to use Beautiful Soup to parse XML that includes a tag called
-  <css>. In particular, code like this will stop working in 4.12.0:
-
-    soup.css['id']
-
-  Code like this will work just as before:
-
-    soup.find_one('css')['id']
-
-  The Soup Sieve methods supported through the .css property are
-  select(), select_one(), iselect(), closest(), match(), filter(),
-  escape(), and compile(). The BeautifulSoup and Tag classes still
-  support the select() and select_one() methods; they have not been
-  deprecated, but they have been demoted to convenience methods.
-
-  [bug=3D2003677]
-
-* When the html.parser parser decides it can't parse a document, Beautif=
ul
-  Soup now consistently propagates this fact by raising a
-  ParserRejectedMarkup error. [bug=3D2007343]
-
-* Removed some error checking code from diagnose(), which is redundant w=
ith
-  similar (but more Pythonic) code in the BeautifulSoup constructor.
-  [bug=3D2007344]
-
-* Added intersphinx references to the documentation so that other
-  projects have a target to point to when they reference Beautiful
-  Soup classes. [bug=3D1453370]
-
-=3D 4.11.2 (20230131)
-
-* Fixed test failures caused by nondeterministic behavior of
-  UnicodeDammit's character detection, depending on the platform setup.
-  [bug=3D1973072]
-
-* Fixed another crash when overriding multi_valued_attributes and using =
the
-  html5lib parser. [bug=3D1948488]
-
-* The HTMLFormatter and XMLFormatter constructors no longer return a
-  value. [bug=3D1992693]
-
-* Tag.interesting_string_types is now propagated when a tag is
-  copied. [bug=3D1990400]
-
-* Warnings now do their best to provide an appropriate stacklevel,
-  improving the usefulness of the message. [bug=3D1978744]
-
-* Passing a Tag's .contents into PageElement.extend() now works the
-  same way as passing the Tag itself.
-
-* Soup Sieve tests will be skipped if the library is not installed.
-
-=3D 4.11.1 (20220408)
-
-This release was done to ensure that the unit tests are packaged along
-with the released source. There are no functionality changes in this
-release, but there are a few other packaging changes:
-
-* The Japanese and Korean translations of the documentation are included.
-* The changelog is now packaged as CHANGELOG, and the license file is
-  packaged as LICENSE. NEWS.txt and COPYING.txt are still present,
-  but may be removed in the future.
-* TODO.txt is no longer packaged, since a TODO is not relevant for relea=
sed
-  code.
-
-=3D 4.11.0 (20220407)
-
-* Ported unit tests to use pytest.
-
-* Added special string classes, RubyParenthesisString and RubyTextString=
,
-  to make it possible to treat ruby text specially in get_text() calls.
-  [bug=3D1941980]
-
-* It's now possible to customize the way output is indented by
-  providing a value for the 'indent' argument to the Formatter
-  constructor. The 'indent' argument works very similarly to the
-  argument of the same name in the Python standard library's
-  json.dump() function. [bug=3D1955497]
-
-* If the charset-normalizer Python module
-  (https://pypi.org/project/charset-normalizer/) is installed, Beautiful
-  Soup will use it to detect the character sets of incoming documents.
-  This is also the module used by newer versions of the Requests library.
-  For the sake of backwards compatibility, chardet and cchardet both tak=
e
-  precedence if installed. [bug=3D1955346]
-
-* Added a workaround for an lxml bug
-  (https://bugs.launchpad.net/lxml/+bug/1948551) that causes
-  problems when parsing a Unicode string beginning with BYTE ORDER MARK.
-  [bug=3D1947768]
-
-* Issue a warning when an HTML parser is used to parse a document that
-  looks like XML but not XHTML. [bug=3D1939121]
-
-* Do a better job of keeping track of namespaces as an XML document is
-  parsed, so that CSS selectors that use namespaces will do the right
-  thing more often. [bug=3D1946243]
-
-* Some time ago, the misleadingly named "text" argument to find-type
-  methods was renamed to the more accurate "string." But this supposed
-  "renaming" didn't make it into important places like the method
-  signatures or the docstrings. That's corrected in this
-  version. "text" still works, but will give a DeprecationWarning.
-  [bug=3D1947038]
-
-* Fixed a crash when pickling a BeautifulSoup object that has no
-  tree builder. [bug=3D1934003]
-
-* Fixed a crash when overriding multi_valued_attributes and using the
-  html5lib parser. [bug=3D1948488]
-
-* Standardized the wording of the MarkupResemblesLocatorWarning
-  warnings to omit untrusted input and make the warnings less
-  judgmental about what you ought to be doing. [bug=3D1955450]
-
-* Removed support for the iconv_codec library, which doesn't seem
-  to exist anymore and was never put up on PyPI. (The closest
-  replacement on PyPI, iconv_codecs, is GPL-licensed, so we can't use
-  it--it's also quite old.)
-
-=3D 4.10.0 (20210907)
-
-* This is the first release of Beautiful Soup to only support Python
-  3. I dropped Python 2 support to maintain support for newer versions
-  (58 and up) of setuptools. See:
-  https://github.com/pypa/setuptools/issues/2769 [bug=3D1942919]
-
-* The behavior of methods like .get_text() and .strings now differs
-  depending on the type of tag. The change is visible with HTML tags
-  like <script>, <style>, and <template>. Starting in 4.9.0, methods
-  like get_text() returned no results on such tags, because the
-  contents of those tags are not considered 'text' within the document
-  as a whole.
-
-  But a user who calls script.get_text() is working from a different
-  definition of 'text' than a user who calls div.get_text()--otherwise
-  there would be no need to call script.get_text() at all. In 4.10.0,
-  the contents of (e.g.) a <script> tag are considered 'text' during a
-  get_text() call on the tag itself, but not considered 'text' during
-  a get_text() call on the tag's parent.
-
-  Because of this change, calling get_text() on each child of a tag
-  may now return a different result than calling get_text() on the tag
-  itself. That's because different tags now have different
-  understandings of what counts as 'text'. [bug=3D1906226] [bug=3D186886=
1]
-
-* NavigableString and its subclasses now implement the get_text()
-  method, as well as the properties .strings and
-  .stripped_strings. These methods will either return the string
-  itself, or nothing, so the only reason to use this is when iterating
-  over a list of mixed Tag and NavigableString objects. [bug=3D1904309]
-
-* The 'html5' formatter now treats attributes whose values are the
-  empty string as HTML boolean attributes. Previously (and in other
-  formatters), an attribute value must be set as None to be treated as
-  a boolean attribute. In a future release, I plan to also give this
-  behavior to the 'html' formatter. Patch by Isaac Muse. [bug=3D1915424]
-
-* The 'replace_with()' method now takes a variable number of arguments,
-  and can be used to replace a single element with a sequence of element=
s.
-  Patch by Bill Chandos. [rev=3D605]
-
-* Corrected output when the namespace prefix associated with a
-  namespaced attribute is the empty string, as opposed to
-  None. [bug=3D1915583]
-
-* Performance improvement when processing tags that speeds up overall
-  tree construction by 2%. Patch by Morotti. [bug=3D1899358]
-
-* Corrected the use of special string container classes in cases when a
-  single tag may contain strings with different containers; such as
-  the <template> tag, which may contain both TemplateString objects
-  and Comment objects. [bug=3D1913406]
-
-* The html.parser tree builder can now handle named entities
-  found in the HTML5 spec in much the same way that the html5lib
-  tree builder does. Note that the lxml HTML tree builder doesn't handle
-  named entities this way. [bug=3D1924908]
-
-* Added a second way to pass specify encodings to UnicodeDammit and
-  EncodingDetector, based on the order of precedence defined in the
-  HTML5 spec, starting at:
-  https://html.spec.whatwg.org/multipage/parsing.html#parsing-with-a-kno=
wn-character-encoding
-
-  Encodings in 'known_definite_encodings' are tried first, then
-  byte-order-mark sniffing is run, then encodings in 'user_encodings'
-  are tried. The old argument, 'override_encodings', is now a
-  deprecated alias for 'known_definite_encodings'.
-
-  This changes the default behavior of the html.parser and lxml tree
-  builders, in a way that may slightly improve encoding
-  detection but will probably have no effect. [bug=3D1889014]
-
-* Improve the warning issued when a directory name (as opposed to
-  the name of a regular file) is passed as markup into the BeautifulSoup
-  constructor. [bug=3D1913628]
-
-=3D 4.9.3 (20201003)
-
-This is the final release of Beautiful Soup to support Python
-2. Beautiful Soup's official support for Python 2 ended on 01 January,
-2021. In the Launchpad Git repository, the final revision to support
-Python 2 was revision 70f546b1e689a70e2f103795efce6d261a3dadf7; it is
-tagged as "python2".
-
-* Implemented a significant performance optimization to the process of
-  searching the parse tree. Patch by Morotti. [bug=3D1898212]
-
-=3D 4.9.2 (20200926)
-
-* Fixed a bug that caused too many tags to be popped from the tag
-  stack during tree building, when encountering a closing tag that had
-  no matching opening tag. [bug=3D1880420]
-
-* Fixed a bug that inconsistently moved elements over when passing
-  a Tag, rather than a list, into Tag.extend(). [bug=3D1885710]
-
-* Specify the soupsieve dependency in a way that complies with
-  PEP 508. Patch by Mike Nerone. [bug=3D1893696]
-
-* Change the signatures for BeautifulSoup.insert_before and insert_after
-  (which are not implemented) to match PageElement.insert_before and
-  insert_after, quieting warnings in some IDEs. [bug=3D1897120]
-
-=3D 4.9.1 (20200517)
-
-* Added a keyword argument 'on_duplicate_attribute' to the
-  BeautifulSoupHTMLParser constructor (used by the html.parser tree
-  builder) which lets you customize the handling of markup that
-  contains the same attribute more than once, as in:
-  <a href=3D"url1" href=3D"url2"> [bug=3D1878209]
-
-* Added a distinct subclass, GuessedAtParserWarning, for the warning
-  issued when BeautifulSoup is instantiated without a parser being
-  specified. [bug=3D1873787]
-
-* Added a distinct subclass, MarkupResemblesLocatorWarning, for the
-  warning issued when BeautifulSoup is instantiated with 'markup' that
-  actually seems to be a URL or the path to a file on
-  disk. [bug=3D1873787]
-
-* The new NavigableString subclasses (Stylesheet, Script, and
-  TemplateString) can now be imported directly from the bs4 package.
-
-* If you encode a document with a Python-specific encoding like
-  'unicode_escape', that encoding is no longer mentioned in the final
-  XML or HTML document. Instead, encoding information is omitted or
-  left blank. [bug=3D1874955]
-
-* Fixed test failures when run against soupselect 2.0. Patch by Tom=C3=A1=
=C5=A1
-  Chv=C3=A1tal. [bug=3D1872279]
-
-=3D 4.9.0 (20200405)
-
-* Added PageElement.decomposed, a new property which lets you
-  check whether you've already called decompose() on a Tag or
-  NavigableString.
-
-* Embedded CSS and Javascript is now stored in distinct Stylesheet and
-  Script tags, which are ignored by methods like get_text() since most
-  people don't consider this sort of content to be 'text'. This
-  feature is not supported by the html5lib treebuilder. [bug=3D1868861]
-
-* Added a Russian translation by 'authoress' to the repository.
-
-* Fixed an unhandled exception when formatting a Tag that had been
-  decomposed.[bug=3D1857767]
-
-* Fixed a bug that happened when passing a Unicode filename containing
-  non-ASCII characters as markup into Beautiful Soup, on a system that
-  allows Unicode filenames. [bug=3D1866717]
-
-* Added a performance optimization to PageElement.extract(). Patch by
-  Arthur Darcet.
-
-=3D 4.8.2 (20191224)
-
-* Added Python docstrings to all public methods of the most commonly
-  used classes.
-
-* Added a Chinese translation by Deron Wang and a Brazilian Portuguese
-  translation by Cezar Peixeiro to the repository.
-
-* Fixed two deprecation warnings. Patches by Colin
-  Watson and Nicholas Neumann. [bug=3D1847592] [bug=3D1855301]
-
-* The html.parser tree builder now correctly handles DOCTYPEs that are
-  not uppercase. [bug=3D1848401]
-
-* PageElement.select() now returns a ResultSet rather than a regular
-  list, making it consistent with methods like find_all().
-
-=3D 4.8.1 (20191006)
-
-* When the html.parser or html5lib parsers are in use, Beautiful Soup
-  will, by default, record the position in the original document where
-  each tag was encountered. This includes line number (Tag.sourceline)
-  and position within a line (Tag.sourcepos).  Based on code by Chris
-  Mayo. [bug=3D1742921]
-
-* When instantiating a BeautifulSoup object, it's now possible to
-   provide a dictionary ('element_classes') of the classes you'd like to=
 be
-   instantiated instead of Tag, NavigableString, etc.
-
-* Fixed the definition of the default XML namespace when using
-   lxml 4.4. Patch by Isaac Muse. [bug=3D1840141]
-
-* Fixed a crash when pretty-printing tags that were not created
-   during initial parsing. [bug=3D1838903]
-
-* Copying a Tag preserves information that was originally obtained from
-   the TreeBuilder used to build the original Tag. [bug=3D1838903]
-
-* Raise an explanatory exception when the underlying parser
-   completely rejects the incoming markup. [bug=3D1838877]
-
-* Avoid a crash when trying to detect the declared encoding of a
-   Unicode document. [bug=3D1838877]
-
-* Avoid a crash when unpickling certain parse trees generated
-   using html5lib on Python 3. [bug=3D1843545]
-
-=3D 4.8.0 (20190720, "One Small Soup")
-
-This release focuses on making it easier to customize Beautiful Soup's
-input mechanism (the TreeBuilder) and output mechanism (the Formatter).
-
-* You can customize the TreeBuilder object by passing keyword
-  arguments into the BeautifulSoup constructor. Those keyword
-  arguments will be passed along into the TreeBuilder constructor.
-
-  The main reason to do this right now is to change how which
-  attributes are treated as multi-valued attributes (the way 'class'
-  is treated by default). You can do this with the
-  'multi_valued_attributes' argument. [bug=3D1832978]
-
-* The role of Formatter objects has been greatly expanded. The Formatter
-  class now controls the following:
-
-  - The function to call to perform entity substitution. (This was
-    previously Formatter's only job.)
-  - Which tags should be treated as containing CDATA and have their
-    contents exempt from entity substitution.
-  - The order in which a tag's attributes are output. [bug=3D1812422]
-  - Whether or not to put a '/' inside a void element, e.g. '<br/>' vs '=
<br>'
-
-  All preexisting code should work as before.
-
-* Added a new method to the API, Tag.smooth(), which consolidates
-  multiple adjacent NavigableString elements. [bug=3D1697296]
-
-* &apos; (which is valid in XML, XHTML, and HTML 5, but not HTML 4) is a=
lways
-  recognized as a named entity and converted to a single quote. [bug=3D1=
818721]
-
-=3D 4.7.1 (20190106)
-
-* Fixed a significant performance problem introduced in 4.7.0. [bug=3D18=
10617]
-
-* Fixed an incorrectly raised exception when inserting a tag before or
-  after an identical tag. [bug=3D1810692]
-
-* Beautiful Soup will no longer try to keep track of namespaces that
-  are not defined with a prefix; this can confuse soupselect. [bug=3D181=
0680]
-
-* Tried even harder to avoid the deprecation warning originally fixed in
-   4.6.1. [bug=3D1778909]
-
-=3D 4.7.0 (20181231)
-
-* Beautiful Soup's CSS Selector implementation has been replaced by a
-  dependency on Isaac Muse's SoupSieve project (the soupsieve package
-  on PyPI). The good news is that SoupSieve has a much more robust and
-  complete implementation of CSS selectors, resolving a large number
-  of longstanding issues. The bad news is that from this point onward,
-  SoupSieve must be installed if you want to use the select() method.
-
-  You don't have to change anything lf you installed Beautiful Soup
-  through pip (SoupSieve will be automatically installed when you
-  upgrade Beautiful Soup) or if you don't use CSS selectors from
-  within Beautiful Soup.
-
-  SoupSieve documentation: https://facelessuser.github.io/soupsieve/
-
-* Added the PageElement.extend() method, which works like list.append().
-   [bug=3D1514970]
-
-* PageElement.insert_before() and insert_after() now take a variable
-   number of arguments. [bug=3D1514970]
-
-* Fix a number of problems with the tree builder that caused
-  trees that were superficially okay, but which fell apart when bits
-  were extracted. Patch by Isaac Muse. [bug=3D1782928,1809910]
-
-* Fixed a problem with the tree builder in which elements that
-  contained no content (such as empty comments and all-whitespace
-  elements) were not being treated as part of the tree. Patch by Isaac
-  Muse. [bug=3D1798699]
-
-* Fixed a problem with multi-valued attributes where the value
-  contained whitespace. Thanks to Jens Svalgaard for the
-  fix. [bug=3D1787453]
-
-* Clarified ambiguous license statements in the source code. Beautiful
-  Soup is released under the MIT license, and has been since 4.4.0.
-
-* This file has been renamed from NEWS.txt to CHANGELOG.
-
-=3D 4.6.3 (20180812)
-
-* Exactly the same as 4.6.2. Re-released to make the README file
-  render properly on PyPI.
-
-=3D 4.6.2 (20180812)
-
-* Fix an exception when a custom formatter was asked to format a void
-  element. [bug=3D1784408]
-
-=3D 4.6.1 (20180728)
-
-* Stop data loss when encountering an empty numeric entity, and
-  possibly in other cases.  Thanks to tos.kamiya for the fix. [bug=3D169=
8503]
-
-* Preserve XML namespaces introduced inside an XML document, not just
-   the ones introduced at the top level. [bug=3D1718787]
-
-* Added a new formatter, "html5", which represents void elements
-   as "<element>" rather than "<element/>".  [bug=3D1716272]
-
-* Fixed a problem where the html.parser tree builder interpreted
-  a string like "&foo " as the character entity "&foo;"  [bug=3D1728706]
-
-* Correctly handle invalid HTML numeric character entities like &#147;
-  which reference code points that are not Unicode code points. Note
-  that this is only fixed when Beautiful Soup is used with the
-  html.parser parser -- html5lib already worked and I couldn't fix it
-  with lxml.  [bug=3D1782933]
-
-* Improved the warning given when no parser is specified. [bug=3D1780571=
]
-
-* When markup contains duplicate elements, a select() call that
-  includes multiple match clauses will match all relevant
-  elements. [bug=3D1770596]
-
-* Fixed code that was causing deprecation warnings in recent Python 3
-  versions. Includes a patch from Ville Skytt=C3=A4. [bug=3D1778909] [bu=
g=3D1689496]
-
-* Fixed a Windows crash in diagnose() when checking whether a long
-  markup string is a filename. [bug=3D1737121]
-
-* Stopped HTMLParser from raising an exception in very rare cases of
-  bad markup. [bug=3D1708831]
-
-* Fixed a bug where find_all() was not working when asked to find a
-  tag with a namespaced name in an XML document that was parsed as
-  HTML. [bug=3D1723783]
-
-* You can get finer control over formatting by subclassing
-  bs4.element.Formatter and passing a Formatter instance into (e.g.)
-  encode(). [bug=3D1716272]
-
-* You can pass a dictionary of `attrs` into
-  BeautifulSoup.new_tag. This makes it possible to create a tag with
-  an attribute like 'name' that would otherwise be masked by another
-  argument of new_tag. [bug=3D1779276]
-
-* Clarified the deprecation warning when accessing tag.fooTag, to cover
-  the possibility that you might really have been looking for a tag
-  called 'fooTag'.
-
-=3D 4.6.0 (20170507) =3D
-
-* Added the `Tag.get_attribute_list` method, which acts like `Tag.get` f=
or
-  getting the value of an attribute, but which always returns a list,
-  whether or not the attribute is a multi-value attribute. [bug=3D167858=
9]
-
-* It's now possible to use a tag's namespace prefix when searching,
-  e.g. soup.find('namespace:tag') [bug=3D1655332]
-
-* Improved the handling of empty-element tags like <br> when using the
-  html.parser parser. [bug=3D1676935]
-
-* HTML parsers treat all HTML4 and HTML5 empty element tags (aka void
-  element tags) correctly. [bug=3D1656909]
-
-* Namespace prefix is preserved when an XML tag is copied. Thanks
-  to Vikas for a patch and test. [bug=3D1685172]
-
-=3D 4.5.3 (20170102) =3D
-
-* Fixed foster parenting when html5lib is the tree builder. Thanks to
-  Geoffrey Sneddon for a patch and test.
- =20
-* Fixed yet another problem that caused the html5lib tree builder to
-  create a disconnected parse tree. [bug=3D1629825]
-
-=3D 4.5.2 (20170102) =3D
-
-* Apart from the version number, this release is identical to
-  4.5.3. Due to user error, it could not be completely uploaded to
-  PyPI. Use 4.5.3 instead.
-
-=3D 4.5.1 (20160802) =3D
-
-* Fixed a crash when passing Unicode markup that contained a
-  processing instruction into the lxml HTML parser on Python
-  3. [bug=3D1608048]
-
-=3D 4.5.0 (20160719) =3D
-
-* Beautiful Soup is no longer compatible with Python 2.6. This
-  actually happened a few releases ago, but it's now official.
-
-* Beautiful Soup will now work with versions of html5lib greater than
-  0.99999999. [bug=3D1603299]
-
-* If a search against each individual value of a multi-valued
-  attribute fails, the search will be run one final time against the
-  complete attribute value considered as a single string. That is, if
-  a tag has class=3D"foo bar" and neither "foo" nor "bar" matches, but
-  "foo bar" does, the tag is now considered a match.
-
-  This happened in previous versions, but only when the value being
-  searched for was a string. Now it also works when that value is
-  a regular expression, a list of strings, etc. [bug=3D1476868]
-
-* Fixed a bug that deranged the tree when a whitespace element was
-  reparented into a tag that contained an identical whitespace
-  element. [bug=3D1505351]
-
-* Added support for CSS selector values that contain quoted spaces,
-  such as tag[style=3D"display: foo"]. [bug=3D1540588]
-
-* Corrected handling of XML processing instructions. [bug=3D1504393]
-
-* Corrected an encoding error that happened when a BeautifulSoup
-  object was copied. [bug=3D1554439]
-
-* The contents of <textarea> tags will no longer be modified when the
-  tree is prettified. [bug=3D1555829]
-
-* When a BeautifulSoup object is pickled but its tree builder cannot
-  be pickled, its .builder attribute is set to None instead of being
-  destroyed. This avoids a performance problem once the object is
-  unpickled. [bug=3D1523629]
-
-* Specify the file and line number when warning about a
-  BeautifulSoup object being instantiated without a parser being
-  specified. [bug=3D1574647]
-
-* The `limit` argument to `select()` now works correctly, though it's
-  not implemented very efficiently. [bug=3D1520530]
-
-* Fixed a Python 3 ByteWarning when a URL was passed in as though it
-  were markup. Thanks to James Salter for a patch and
-  test. [bug=3D1533762]
-
-* We don't run the check for a filename passed in as markup if the
-  'filename' contains a less-than character; the less-than character
-  indicates it's most likely a very small document. [bug=3D1577864]
-
-=3D 4.4.1 (20150928) =3D
-
-* Fixed a bug that deranged the tree when part of it was
-  removed. Thanks to Eric Weiser for the patch and John Wiseman for a
-  test. [bug=3D1481520]
-
-* Fixed a parse bug with the html5lib tree-builder. Thanks to Roel
-  Kramer for the patch. [bug=3D1483781]
-
-* Improved the implementation of CSS selector grouping. Thanks to
-  Orangain for the patch. [bug=3D1484543]
-
-* Fixed the test_detect_utf8 test so that it works when chardet is
-  installed. [bug=3D1471359]
-
-* Corrected the output of Declaration objects. [bug=3D1477847]
-
-
-=3D 4.4.0 (20150703) =3D
-
-Especially important changes:
-
-* Added a warning when you instantiate a BeautifulSoup object without
-  explicitly naming a parser. [bug=3D1398866]
-
-* __repr__ now returns an ASCII bytestring in Python 2, and a Unicode
-  string in Python 3, instead of a UTF8-encoded bytestring in both
-  versions. In Python 3, __str__ now returns a Unicode string instead
-  of a bytestring. [bug=3D1420131]
-
-* The `text` argument to the find_* methods is now called `string`,
-  which is more accurate. `text` still works, but `string` is the
-  argument described in the documentation. `text` may eventually
-  change its meaning, but not for a very long time. [bug=3D1366856]
-
-* Changed the way soup objects work under copy.copy(). Copying a
-  NavigableString or a Tag will give you a new NavigableString that's
-  equal to the old one but not connected to the parse tree. Patch by
-  Martijn Peters. [bug=3D1307490]
-
-* Started using a standard MIT license. [bug=3D1294662]
-
-* Added a Chinese translation of the documentation by Delong .w.
-
-New features:
-
-* Introduced the select_one() method, which uses a CSS selector but
-  only returns the first match, instead of a list of
-  matches. [bug=3D1349367]
-
-* You can now create a Tag object without specifying a
-  TreeBuilder. Patch by Martijn Pieters. [bug=3D1307471]
-
-* You can now create a NavigableString or a subclass just by invoking
-  the constructor. [bug=3D1294315]
-
-* Added an `exclude_encodings` argument to UnicodeDammit and to the
-  Beautiful Soup constructor, which lets you prohibit the detection of
-  an encoding that you know is wrong. [bug=3D1469408]
-
-* The select() method now supports selector grouping. Patch by
-  Francisco Canas [bug=3D1191917]
-
-Bug fixes:
-
-* Fixed yet another problem that caused the html5lib tree builder to
-  create a disconnected parse tree. [bug=3D1237763]
-
-* Force object_was_parsed() to keep the tree intact even when an element
-  from later in the document is moved into place. [bug=3D1430633]
-
-* Fixed yet another bug that caused a disconnected tree when html5lib
-  copied an element from one part of the tree to another. [bug=3D1270611=
]
-
-* Fixed a bug where Element.extract() could create an infinite loop in
-  the remaining tree.
-
-* The select() method can now find tags whose names contain
-  dashes. Patch by Francisco Canas. [bug=3D1276211]
-
-* The select() method can now find tags with attributes whose names
-  contain dashes. Patch by Marek Kapolka. [bug=3D1304007]
-
-* Improved the lxml tree builder's handling of processing
-  instructions. [bug=3D1294645]
-
-* Restored the helpful syntax error that happens when you try to
-  import the Python 2 edition of Beautiful Soup under Python
-  3. [bug=3D1213387]
-
-* In Python 3.4 and above, set the new convert_charrefs argument to
-  the html.parser constructor to avoid a warning and future
-  failures. Patch by Stefano Revera. [bug=3D1375721]
-
-* The warning when you pass in a filename or URL as markup will now be
-  displayed correctly even if the filename or URL is a Unicode
-  string. [bug=3D1268888]
-
-* If the initial <html> tag contains a CDATA list attribute such as
-  'class', the html5lib tree builder will now turn its value into a
-  list, as it would with any other tag. [bug=3D1296481]
-
-* Fixed an import error in Python 3.5 caused by the removal of the
-  HTMLParseError class. [bug=3D1420063]
-
-* Improved docstring for encode_contents() and
-  decode_contents(). [bug=3D1441543]
-
-* Fixed a crash in Unicode, Dammit's encoding detector when the name
-  of the encoding itself contained invalid bytes. [bug=3D1360913]
-
-* Improved the exception raised when you call .unwrap() or
-  .replace_with() on an element that's not attached to a tree.
-
-* Raise a NotImplementedError whenever an unsupported CSS pseudoclass
-  is used in select(). Previously some cases did not result in a
-  NotImplementedError.
-
-* It's now possible to pickle a BeautifulSoup object no matter which
-  tree builder was used to create it. However, the only tree builder
-  that survives the pickling process is the HTMLParserTreeBuilder
-  ('html.parser'). If you unpickle a BeautifulSoup object created with
-  some other tree builder, soup.builder will be None. [bug=3D1231545]
-
-=3D 4.3.2 (20131002) =3D
-
-* Fixed a bug in which short Unicode input was improperly encoded to
-  ASCII when checking whether or not it was the name of a file on
-  disk. [bug=3D1227016]
-
-* Fixed a crash when a short input contains data not valid in
-  filenames. [bug=3D1232604]
-
-* Fixed a bug that caused Unicode data put into UnicodeDammit to
-  return None instead of the original data. [bug=3D1214983]
-
-* Combined two tests to stop a spurious test failure when tests are
-  run by nosetests. [bug=3D1212445]
-
-=3D 4.3.1 (20130815) =3D
-
-* Fixed yet another problem with the html5lib tree builder, caused by
-  html5lib's tendency to rearrange the tree during
-  parsing. [bug=3D1189267]
-
-* Fixed a bug that caused the optimized version of find_all() to
-  return nothing. [bug=3D1212655]
-
-=3D 4.3.0 (20130812) =3D
-
-* Instead of converting incoming data to Unicode and feeding it to the
-  lxml tree builder in chunks, Beautiful Soup now makes successive
-  guesses at the encoding of the incoming data, and tells lxml to
-  parse the data as that encoding. Giving lxml more control over the
-  parsing process improves performance and avoids a number of bugs and
-  issues with the lxml parser which had previously required elaborate
-  workarounds:
-
-  - An issue in which lxml refuses to parse Unicode strings on some
-    systems. [bug=3D1180527]
-
-  - A returning bug that truncated documents longer than a (very
-    small) size. [bug=3D963880]
-
-  - A returning bug in which extra spaces were added to a document if
-    the document defined a charset other than UTF-8. [bug=3D972466]
-
-  This required a major overhaul of the tree builder architecture. If
-  you wrote your own tree builder and didn't tell me, you'll need to
-  modify your prepare_markup() method.
-
-* The UnicodeDammit code that makes guesses at encodings has been
-  split into its own class, EncodingDetector. A lot of apparently
-  redundant code has been removed from Unicode, Dammit, and some
-  undocumented features have also been removed.
-
-* Beautiful Soup will issue a warning if instead of markup you pass it
-  a URL or the name of a file on disk (a common beginner's mistake).
-
-* A number of optimizations improve the performance of the lxml tree
-  builder by about 33%, the html.parser tree builder by about 20%, and
-  the html5lib tree builder by about 15%.
-
-* All find_all calls should now return a ResultSet object. Patch by
-  Aaron DeVore. [bug=3D1194034]
-
-=3D 4.2.1 (20130531) =3D
-
-* The default XML formatter will now replace ampersands even if they
-  appear to be part of entities. That is, "&lt;" will become
-  "&amp;lt;". The old code was left over from Beautiful Soup 3, which
-  didn't always turn entities into Unicode characters.
-
-  If you really want the old behavior (maybe because you add new
-  strings to the tree, those strings include entities, and you want
-  the formatter to leave them alone on output), it can be found in
-  EntitySubstitution.substitute_xml_containing_entities(). [bug=3D118218=
3]
-
-* Gave new_string() the ability to create subclasses of
-  NavigableString. [bug=3D1181986]
-
-* Fixed another bug by which the html5lib tree builder could create a
-  disconnected tree. [bug=3D1182089]
-
-* The .previous_element of a BeautifulSoup object is now always None,
-  not the last element to be parsed. [bug=3D1182089]
-
-* Fixed test failures when lxml is not installed. [bug=3D1181589]
-
-* html5lib now supports Python 3. Fixed some Python 2-specific
-  code in the html5lib test suite. [bug=3D1181624]
-
-* The html.parser treebuilder can now handle numeric attributes in
-  text when the hexidecimal name of the attribute starts with a
-  capital X. Patch by Tim Shirley. [bug=3D1186242]
-
-=3D 4.2.0 (20130514) =3D
-
-* The Tag.select() method now supports a much wider variety of CSS
-  selectors.
-
- - Added support for the adjacent sibling combinator (+) and the
-   general sibling combinator (~). Tests by "liquider". [bug=3D1082144]
-
- - The combinators (>, +, and ~) can now combine with any supported
-   selector, not just one that selects based on tag name.
-
- - Added limited support for the "nth-of-type" pseudo-class. Code
-   by Sven Slootweg. [bug=3D1109952]
-
-* The BeautifulSoup class is now aliased to "_s" and "_soup", making
-  it quicker to type the import statement in an interactive session:
-
-  from bs4 import _s
-   or
-  from bs4 import _soup
-
-  The alias may change in the future, so don't use this in code you're
-  going to run more than once.
-
-* Added the 'diagnose' submodule, which includes several useful
-  functions for reporting problems and doing tech support.
-
-  - diagnose(data) tries the given markup on every installed parser,
-    reporting exceptions and displaying successes. If a parser is not
-    installed, diagnose() mentions this fact.
-
-  - lxml_trace(data, html=3DTrue) runs the given markup through lxml's
-    XML parser or HTML parser, and prints out the parser events as
-    they happen. This helps you quickly determine whether a given
-    problem occurs in lxml code or Beautiful Soup code.
-
-  - htmlparser_trace(data) is the same thing, but for Python's
-    built-in HTMLParser class.
-
-* In an HTML document, the contents of a <script> or <style> tag will
-  no longer undergo entity substitution by default. XML documents work
-  the same way they did before. [bug=3D1085953]
-
-* Methods like get_text() and properties like .strings now only give
-  you strings that are visible in the document--no comments or
-  processing commands. [bug=3D1050164]
-
-* The prettify() method now leaves the contents of <pre> tags
-  alone. [bug=3D1095654]
-
-* Fix a bug in the html5lib treebuilder which sometimes created
-  disconnected trees. [bug=3D1039527]
-
-* Fix a bug in the lxml treebuilder which crashed when a tag included
-  an attribute from the predefined "xml:" namespace. [bug=3D1065617]
-
-* Fix a bug by which keyword arguments to find_parent() were not
-  being passed on. [bug=3D1126734]
-
-* Stop a crash when unwisely messing with a tag that's been
-  decomposed. [bug=3D1097699]
-
-* Now that lxml's segfault on invalid doctype has been fixed, fixed a
-  corresponding problem on the Beautiful Soup end that was previously
-  invisible. [bug=3D984936]
-
-* Fixed an exception when an overspecified CSS selector didn't match
-  anything. Code by Stefaan Lippens. [bug=3D1168167]
-
-=3D 4.1.3 (20120820) =3D
-
-* Skipped a test under Python 2.6 and Python 3.1 to avoid a spurious
-  test failure caused by the lousy HTMLParser in those
-  versions. [bug=3D1038503]
-
-* Raise a more specific error (FeatureNotFound) when a requested
-  parser or parser feature is not installed. Raise NotImplementedError
-  instead of ValueError when the user calls insert_before() or
-  insert_after() on the BeautifulSoup object itself. Patch by Aaron
-  Devore. [bug=3D1038301]
-
-=3D 4.1.2 (20120817) =3D
-
-* As per PEP-8, allow searching by CSS class using the 'class_'
-  keyword argument. [bug=3D1037624]
-
-* Display namespace prefixes for namespaced attribute names, instead of
-  the fully-qualified names given by the lxml parser. [bug=3D1037597]
-
-* Fixed a crash on encoding when an attribute name contained
-  non-ASCII characters.
-
-* When sniffing encodings, if the cchardet library is installed,
-  Beautiful Soup uses it instead of chardet. cchardet is much
-  faster. [bug=3D1020748]
-
-* Use logging.warning() instead of warning.warn() to notify the user
-  that characters were replaced with REPLACEMENT
-  CHARACTER. [bug=3D1013862]
-
-=3D 4.1.1 (20120703) =3D
-
-* Fixed an html5lib tree builder crash which happened when html5lib
-  moved a tag with a multivalued attribute from one part of the tree
-  to another. [bug=3D1019603]
-
-* Correctly display closing tags with an XML namespace declared. Patch
-  by Andreas Kostyrka. [bug=3D1019635]
-
-* Fixed a typo that made parsing significantly slower than it should
-  have been, and also waited too long to close tags with XML
-  namespaces. [bug=3D1020268]
-
-* get_text() now returns an empty Unicode string if there is no text,
-  rather than an empty bytestring. [bug=3D1020387]
-
-=3D 4.1.0 (20120529) =3D
-
-* Added experimental support for fixing Windows-1252 characters
-  embedded in UTF-8 documents. (UnicodeDammit.detwingle())
-
-* Fixed the handling of &quot; with the built-in parser. [bug=3D993871]
-
-* Comments, processing instructions, document type declarations, and
-  markup declarations are now treated as preformatted strings, the way
-  CData blocks are. [bug=3D1001025]
-
-* Fixed a bug with the lxml treebuilder that prevented the user from
-  adding attributes to a tag that didn't originally have
-  attributes. [bug=3D1002378] Thanks to Oliver Beattie for the patch.
-
-* Fixed some edge-case bugs having to do with inserting an element
-  into a tag it's already inside, and replacing one of a tag's
-  children with another. [bug=3D997529]
-
-* Added the ability to search for attribute values specified in UTF-8. [=
bug=3D1003974]
-
-  This caused a major refactoring of the search code. All the tests
-  pass, but it's possible that some searches will behave differently.
-
-=3D 4.0.5 (20120427) =3D
-
-* Added a new method, wrap(), which wraps an element in a tag.
-
-* Renamed replace_with_children() to unwrap(), which is easier to
-  understand and also the jQuery name of the function.
-
-* Made encoding substitution in <meta> tags completely transparent (no
-  more %SOUP-ENCODING%).
-
-* Fixed a bug in decoding data that contained a byte-order mark, such
-  as data encoded in UTF-16LE. [bug=3D988980]
-
-* Fixed a bug that made the HTMLParser treebuilder generate XML
-  definitions ending with two question marks instead of
-  one. [bug=3D984258]
-
-* Upon document generation, CData objects are no longer run through
-  the formatter. [bug=3D988905]
-
-* The test suite now passes when lxml is not installed, whether or not
-  html5lib is installed. [bug=3D987004]
-
-* Print a warning on HTMLParseErrors to let people know they should
-  install a better parser library.
-
-=3D 4.0.4 (20120416) =3D
-
-* Fixed a bug that sometimes created disconnected trees.
-
-* Fixed a bug with the string setter that moved a string around the
-  tree instead of copying it. [bug=3D983050]
-
-* Attribute values are now run through the provided output formatter.
-  Previously they were always run through the 'minimal' formatter. In
-  the future I may make it possible to specify different formatters
-  for attribute values and strings, but for now, consistent behavior
-  is better than inconsistent behavior. [bug=3D980237]
-
-* Added the missing renderContents method from Beautiful Soup 3. Also
-  added an encode_contents() method to go along with decode_contents().
-
-* Give a more useful error when the user tries to run the Python 2
-  version of BS under Python 3.
-
-* UnicodeDammit can now convert Microsoft smart quotes to ASCII with
-  UnicodeDammit(markup, smart_quotes_to=3D"ascii").
-
-=3D 4.0.3 (20120403) =3D
-
-* Fixed a typo that caused some versions of Python 3 to convert the
-  Beautiful Soup codebase incorrectly.
-
-* Got rid of the 4.0.2 workaround for HTML documents--it was
-  unnecessary and the workaround was triggering a (possibly different,
-  but related) bug in lxml. [bug=3D972466]
-
-=3D 4.0.2 (20120326) =3D
-
-* Worked around a possible bug in lxml that prevents non-tiny XML
-  documents from being parsed. [bug=3D963880, bug=3D963936]
-
-* Fixed a bug where specifying `text` while also searching for a tag
-  only worked if `text` wanted an exact string match. [bug=3D955942]
-
-=3D 4.0.1 (20120314) =3D
-
-* This is the first official release of Beautiful Soup 4. There is no
-  4.0.0 release, to eliminate any possibility that packaging software
-  might treat "4.0.0" as being an earlier version than "4.0.0b10".
-
-* Brought BS up to date with the latest release of soupselect, adding
-  CSS selector support for direct descendant matches and multiple CSS
-  class matches.
-
-=3D 4.0.0b10 (20120302) =3D
-
-* Added support for simple CSS selectors, taken from the soupselect proj=
ect.
-
-* Fixed a crash when using html5lib. [bug=3D943246]
-
-* In HTML5-style <meta charset=3D"foo"> tags, the value of the "charset"
-  attribute is now replaced with the appropriate encoding on
-  output. [bug=3D942714]
-
-* Fixed a bug that caused calling a tag to sometimes call find_all()
-  with the wrong arguments. [bug=3D944426]
-
-* For backwards compatibility, brought back the BeautifulStoneSoup
-  class as a deprecated wrapper around BeautifulSoup.
-
-=3D 4.0.0b9 (20120228) =3D
-
-* Fixed the string representation of DOCTYPEs that have both a public
-  ID and a system ID.
-
-* Fixed the generated XML declaration.
-
-* Renamed Tag.nsprefix to Tag.prefix, for consistency with
-  NamespacedAttribute.
-
-* Fixed a test failure that occurred on Python 3.x when chardet was
-  installed.
-
-* Made prettify() return Unicode by default, so it will look nice on
-  Python 3 when passed into print().
-
-=3D 4.0.0b8 (20120224) =3D
-
-* All tree builders now preserve namespace information in the
-  documents they parse. If you use the html5lib parser or lxml's XML
-  parser, you can access the namespace URL for a tag as tag.namespace.
-
-  However, there is no special support for namespace-oriented
-  searching or tree manipulation. When you search the tree, you need
-  to use namespace prefixes exactly as they're used in the original
-  document.
-
-* The string representation of a DOCTYPE always ends in a newline.
-
-* Issue a warning if the user tries to use a SoupStrainer in
-  conjunction with the html5lib tree builder, which doesn't support
-  them.
-
-=3D 4.0.0b7 (20120223) =3D
-
-* Upon decoding to string, any characters that can't be represented in
-  your chosen encoding will be converted into numeric XML entity
-  references.
-
-* Issue a warning if characters were replaced with REPLACEMENT
-  CHARACTER during Unicode conversion.
-
-* Restored compatibility with Python 2.6.
-
-* The install process no longer installs docs or auxiliary text files.
-
-* It's now possible to deepcopy a BeautifulSoup object created with
-  Python's built-in HTML parser.
-
-* About 100 unit tests that "test" the behavior of various parsers on
-  invalid markup have been removed. Legitimate changes to those
-  parsers caused these tests to fail, indicating that perhaps
-  Beautiful Soup should not test the behavior of foreign
-  libraries.
-
-  The problematic unit tests have been reformulated as informational
-  comparisons generated by the script
-  scripts/demonstrate_parser_differences.py.
-
-  This makes Beautiful Soup compatible with html5lib version 0.95 and
-  future versions of HTMLParser.
-
-=3D 4.0.0b6 (20120216) =3D
-
-* Multi-valued attributes like "class" always have a list of values,
-  even if there's only one value in the list.
-
-* Added a number of multi-valued attributes defined in HTML5.
-
-* Stopped generating a space before the slash that closes an
-  empty-element tag. This may come back if I add a special XHTML mode
-  (http://www.w3.org/TR/xhtml1/#C_2), but right now it's pretty
-  useless.
-
-* Passing text along with tag-specific arguments to a find* method:
-
-   find("a", text=3D"Click here")
-
-  will find tags that contain the given text as their
-  .string. Previously, the tag-specific arguments were ignored and
-  only strings were searched.
-
-* Fixed a bug that caused the html5lib tree builder to build a
-  partially disconnected tree. Generally cleaned up the html5lib tree
-  builder.
-
-* If you restrict a multi-valued attribute like "class" to a string
-  that contains spaces, Beautiful Soup will only consider it a match
-  if the values correspond to that specific string.
-
-=3D 4.0.0b5 (20120209) =3D
-
-* Rationalized Beautiful Soup's treatment of CSS class. A tag
-  belonging to multiple CSS classes is treated as having a list of
-  values for the 'class' attribute. Searching for a CSS class will
-  match *any* of the CSS classes.
-
-  This actually affects all attributes that the HTML standard defines
-  as taking multiple values (class, rel, rev, archive, accept-charset,
-  and headers), but 'class' is by far the most common. [bug=3D41034]
-
-* If you pass anything other than a dictionary as the second argument
-  to one of the find* methods, it'll assume you want to use that
-  object to search against a tag's CSS classes. Previously this only
-  worked if you passed in a string.
-
-* Fixed a bug that caused a crash when you passed a dictionary as an
-  attribute value (possibly because you mistyped "attrs"). [bug=3D842419=
]
-
-* Unicode, Dammit now detects the encoding in HTML 5-style <meta> tags
-  like <meta charset=3D"utf-8" />. [bug=3D837268]
-
-* If Unicode, Dammit can't figure out a consistent encoding for a
-  page, it will try each of its guesses again, with errors=3D"replace"
-  instead of errors=3D"strict". This may mean that some data gets
-  replaced with REPLACEMENT CHARACTER, but at least most of it will
-  get turned into Unicode. [bug=3D754903]
-
-* Patched over a bug in html5lib (?) that was crashing Beautiful Soup
-  on certain kinds of markup. [bug=3D838800]
-
-* Fixed a bug that wrecked the tree if you replaced an element with an
-  empty string. [bug=3D728697]
-
-* Improved Unicode, Dammit's behavior when you give it Unicode to
-  begin with.
-
-=3D 4.0.0b4 (20120208) =3D
-
-* Added BeautifulSoup.new_string() to go along with BeautifulSoup.new_ta=
g()
-
-* BeautifulSoup.new_tag() will follow the rules of whatever
-  tree-builder was used to create the original BeautifulSoup object. A
-  new <p> tag will look like "<p />" if the soup object was created to
-  parse XML, but it will look like "<p></p>" if the soup object was
-  created to parse HTML.
-
-* We pass in strict=3DFalse to html.parser on Python 3, greatly
-  improving html.parser's ability to handle bad HTML.
-
-* We also monkeypatch a serious bug in html.parser that made
-  strict=3DFalse disastrous on Python 3.2.2.
-
-* Replaced the "substitute_html_entities" argument with the
-  more general "formatter" argument.
-
-* Bare ampersands and angle brackets are always converted to XML
-  entities unless the user prevents it.
-
-* Added PageElement.insert_before() and PageElement.insert_after(),
-  which let you put an element into the parse tree with respect to
-  some other element.
-
-* Raise an exception when the user tries to do something nonsensical
-  like insert a tag into itself.
-
-
-=3D 4.0.0b3 (20120203) =3D
-
-Beautiful Soup 4 is a nearly-complete rewrite that removes Beautiful
-Soup's custom HTML parser in favor of a system that lets you write a
-little glue code and plug in any HTML or XML parser you want.
-
-Beautiful Soup 4.0 comes with glue code for four parsers:
-
- * Python's standard HTMLParser (html.parser in Python 3)
- * lxml's HTML and XML parsers
- * html5lib's HTML parser
-
-HTMLParser is the default, but I recommend you install lxml if you
-can.
-
-For complete documentation, see the Sphinx documentation in
-bs4/doc/source/. What follows is a summary of the changes from
-Beautiful Soup 3.
-
-=3D=3D=3D The module name has changed =3D=3D=3D
-
-Previously you imported the BeautifulSoup class from a module also
-called BeautifulSoup. To save keystrokes and make it clear which
-version of the API is in use, the module is now called 'bs4':
-
-    >>> from bs4 import BeautifulSoup
-
-=3D=3D=3D It works with Python 3 =3D=3D=3D
-
-Beautiful Soup 3.1.0 worked with Python 3, but the parser it used was
-so bad that it barely worked at all. Beautiful Soup 4 works with
-Python 3, and since its parser is pluggable, you don't sacrifice
-quality.
-
-Special thanks to Thomas Kluyver and Ezio Melotti for getting Python 3
-support to the finish line. Ezio Melotti is also to thank for greatly
-improving the HTML parser that comes with Python 3.2.
-
-=3D=3D=3D CDATA sections are normal text, if they're understood at all. =
=3D=3D=3D
-
-Currently, the lxml and html5lib HTML parsers ignore CDATA sections in
-markup:
-
- <p><![CDATA[foo]]></p> =3D> <p></p>
-
-A future version of html5lib will turn CDATA sections into text nodes,
-but only within tags like <svg> and <math>:
-
- <svg><![CDATA[foo]]></svg> =3D> <p>foo</p>
-
-The default XML parser (which uses lxml behind the scenes) turns CDATA
-sections into ordinary text elements:
-
- <p><![CDATA[foo]]></p> =3D> <p>foo</p>
-
-In theory it's possible to preserve the CDATA sections when using the
-XML parser, but I don't see how to get it to work in practice.
-
-=3D=3D=3D Miscellaneous other stuff =3D=3D=3D
-
-If the BeautifulSoup instance has .is_xml set to True, an appropriate
-XML declaration will be emitted when the tree is transformed into a
-string:
-
-    <?xml version=3D"1.0" encoding=3D"utf-8">
-    <markup>
-     ...
-    </markup>
-
-The ['lxml', 'xml'] tree builder sets .is_xml to True; the other tree
-builders set it to False. If you want to parse XHTML with an HTML
-parser, you can set it manually.
-
-
-=3D 3.2.0 =3D
-
-The 3.1 series wasn't very useful, so I renamed the 3.0 series to 3.2
-to make it obvious which one you should use.
-
-=3D 3.1.0 =3D
-
-A hybrid version that supports 2.4 and can be automatically converted
-to run under Python 3.0. There are three backwards-incompatible
-changes you should be aware of, but no new features or deliberate
-behavior changes.
-
-1. str() may no longer do what you want. This is because the meaning
-of str() inverts between Python 2 and 3; in Python 2 it gives you a
-byte string, in Python 3 it gives you a Unicode string.
-
-The effect of this is that you can't pass an encoding to .__str__
-anymore. Use encode() to get a string and decode() to get Unicode, and
-you'll be ready (well, readier) for Python 3.
-
-2. Beautiful Soup is now based on HTMLParser rather than SGMLParser,
-which is gone in Python 3. There's some bad HTML that SGMLParser
-handled but HTMLParser doesn't, usually to do with attribute values
-that aren't closed or have brackets inside them:
-
-  <a href=3D"foo</a>, </a><a href=3D"bar">baz</a>
-  <a b=3D"<a>">', '<a b=3D"&lt;a&gt;"></a><a>"></a>
-
-A later version of Beautiful Soup will allow you to plug in different
-parsers to make tradeoffs between speed and the ability to handle bad
-HTML.
-
-3. In Python 3 (but not Python 2), HTMLParser converts entities within
-attributes to the corresponding Unicode characters. In Python 2 it's
-possible to parse this string and leave the &eacute; intact.
-
- <a href=3D"http://crummy.com?sacr&eacute;&bleu">
-
-In Python 3, the &eacute; is always converted to \xe9 during
-parsing.
-
-
-=3D 3.0.7a =3D
-
-Added an import that makes BS work in Python 2.3.
-
-
-=3D 3.0.7 =3D
-
-Fixed a UnicodeDecodeError when unpickling documents that contain
-non-ASCII characters.
-
-Fixed a TypeError that occurred in some circumstances when a tag
-contained no text.
-
-Jump through hoops to avoid the use of chardet, which can be extremely
-slow in some circumstances. UTF-8 documents should never trigger the
-use of chardet.
-
-Whitespace is preserved inside <pre> and <textarea> tags that contain
-nothing but whitespace.
-
-Beautiful Soup can now parse a doctype that's scoped to an XML namespace.
-
-
-=3D 3.0.6 =3D
-
-Got rid of a very old debug line that prevented chardet from working.
-
-Added a Tag.decompose() method that completely disconnects a tree or a
-subset of a tree, breaking it up into bite-sized pieces that are
-easy for the garbage collecter to collect.
-
-Tag.extract() now returns the tag that was extracted.
-
-Tag.findNext() now does something with the keyword arguments you pass
-it instead of dropping them on the floor.
-
-Fixed a Unicode conversion bug.
-
-Fixed a bug that garbled some <meta> tags when rewriting them.
-
-
-=3D 3.0.5 =3D
-
-Soup objects can now be pickled, and copied with copy.deepcopy.
-
-Tag.append now works properly on existing BS objects. (It wasn't
-originally intended for outside use, but it can be now.) (Giles
-Radford)
-
-Passing in a nonexistent encoding will no longer crash the parser on
-Python 2.4 (John Nagle).
-
-Fixed an underlying bug in SGMLParser that thinks ASCII has 255
-characters instead of 127 (John Nagle).
-
-Entities are converted more consistently to Unicode characters.
-
-Entity references in attribute values are now converted to Unicode
-characters when appropriate. Numeric entities are always converted,
-because SGMLParser always converts them outside of attribute values.
-
-ALL_ENTITIES happens to just be the XHTML entities, so I renamed it to
-XHTML_ENTITIES.
-
-The regular expression for bare ampersands was too loose. In some
-cases ampersands were not being escaped. (Sam Ruby?)
-
-Non-breaking spaces and other special Unicode space characters are no
-longer folded to ASCII spaces. (Robert Leftwich)
-
-Information inside a TEXTAREA tag is now parsed literally, not as HTML
-tags. TEXTAREA now works exactly the same way as SCRIPT. (Zephyr Fang)
-
-=3D 3.0.4 =3D
-
-Fixed a bug that crashed Unicode conversion in some cases.
-
-Fixed a bug that prevented UnicodeDammit from being used as a
-general-purpose data scrubber.
-
-Fixed some unit test failures when running against Python 2.5.
-
-When considering whether to convert smart quotes, UnicodeDammit now
-looks at the original encoding in a case-insensitive way.
-
-=3D 3.0.3 (20060606) =3D
-
-Beautiful Soup is now usable as a way to clean up invalid XML/HTML (be
-sure to pass in an appropriate value for convertEntities, or XML/HTML
-entities might stick around that aren't valid in HTML/XML). The result
-may not validate, but it should be good enough to not choke a
-real-world XML parser. Specifically, the output of a properly
-constructed soup object should always be valid as part of an XML
-document, but parts may be missing if they were missing in the
-original. As always, if the input is valid XML, the output will also
-be valid.
-
-=3D 3.0.2 (20060602) =3D
-
-Previously, Beautiful Soup correctly handled attribute values that
-contained embedded quotes (sometimes by escaping), but not other kinds
-of XML character. Now, it correctly handles or escapes all special XML
-characters in attribute values.
-
-I aliased methods to the 2.x names (fetch, find, findText, etc.) for
-backwards compatibility purposes. Those names are deprecated and if I
-ever do a 4.0 I will remove them. I will, I tell you!
-
-Fixed a bug where the findAll method wasn't passing along any keyword
-arguments.
-
-When run from the command line, Beautiful Soup now acts as an HTML
-pretty-printer, not an XML pretty-printer.
-
-=3D 3.0.1 (20060530) =3D
-
-Reintroduced the "fetch by CSS class" shortcut. I thought keyword
-arguments would replace it, but they don't. You can't call soup('a',
-class=3D'foo') because class is a Python keyword.
-
-If Beautiful Soup encounters a meta tag that declares the encoding,
-but a SoupStrainer tells it not to parse that tag, Beautiful Soup will
-no longer try to rewrite the meta tag to mention the new
-encoding. Basically, this makes SoupStrainers work in real-world
-applications instead of crashing the parser.
-
-=3D 3.0.0 "Who would not give all else for two p" (20060528) =3D
-
-This release is not backward-compatible with previous releases. If
-you've got code written with a previous version of the library, go
-ahead and keep using it, unless one of the features mentioned here
-really makes your life easier. Since the library is self-contained,
-you can include an old copy of the library in your old applications,
-and use the new version for everything else.
-
-The documentation has been rewritten and greatly expanded with many
-more examples.
-
-Beautiful Soup autodetects the encoding of a document (or uses the one
-you specify), and converts it from its native encoding to
-Unicode. Internally, it only deals with Unicode strings. When you
-print out the document, it converts to UTF-8 (or another encoding you
-specify). [Doc reference]
-
-It's now easy to make large-scale changes to the parse tree without
-screwing up the navigation members. The methods are extract,
-replaceWith, and insert. [Doc reference. See also Improving Memory
-Usage with extract]
-
-Passing True in as an attribute value gives you tags that have any
-value for that attribute. You don't have to create a regular
-expression. Passing None for an attribute value gives you tags that
-don't have that attribute at all.
-
-Tag objects now know whether or not they're self-closing. This avoids
-the problem where Beautiful Soup thought that tags like <BR /> were
-self-closing even in XML documents. You can customize the self-closing
-tags for a parser object by passing them in as a list of
-selfClosingTags: you don't have to subclass anymore.
-
-There's a new built-in parser, MinimalSoup, which has most of
-BeautifulSoup's HTML-specific rules, but no tag nesting rules. [Doc
-reference]
-
-You can use a SoupStrainer to tell Beautiful Soup to parse only part
-of a document. This saves time and memory, often making Beautiful Soup
-about as fast as a custom-built SGMLParser subclass. [Doc reference,
-SoupStrainer reference]
-
-You can (usually) use keyword arguments instead of passing a
-dictionary of attributes to a search method. That is, you can replace
-soup(args=3D{"id" : "5"}) with soup(id=3D"5"). You can still use args if
-(for instance) you need to find an attribute whose name clashes with
-the name of an argument to findAll. [Doc reference: **kwargs attrs]
-
-The method names have changed to the better method names used in
-Rubyful Soup. Instead of find methods and fetch methods, there are
-only find methods. Instead of a scheme where you can't remember which
-method finds one element and which one finds them all, we have find
-and findAll. In general, if the method name mentions All or a plural
-noun (eg. findNextSiblings), then it finds many elements
-method. Otherwise, it only finds one element. [Doc reference]
-
-Some of the argument names have been renamed for clarity. For instance
-avoidParserProblems is now parserMassage.
-
-Beautiful Soup no longer implements a feed method. You need to pass a
-string or a filehandle into the soup constructor, not with feed after
-the soup has been created. There is still a feed method, but it's the
-feed method implemented by SGMLParser and calling it will bypass
-Beautiful Soup and cause problems.
-
-The NavigableText class has been renamed to NavigableString. There is
-no NavigableUnicodeString anymore, because every string inside a
-Beautiful Soup parse tree is a Unicode string.
-
-findText and fetchText are gone. Just pass a text argument into find
-or findAll.
-
-Null was more trouble than it was worth, so I got rid of it. Anything
-that used to return Null now returns None.
-
-Special XML constructs like comments and CDATA now have their own
-NavigableString subclasses, instead of being treated as oddly-formed
-data. If you parse a document that contains CDATA and write it back
-out, the CDATA will still be there.
-
-When you're parsing a document, you can get Beautiful Soup to convert
-XML or HTML entities into the corresponding Unicode characters. [Doc
-reference]
-
-=3D 2.1.1 (20050918) =3D
-
-Fixed a serious performance bug in BeautifulStoneSoup which was
-causing parsing to be incredibly slow.
-
-Corrected several entities that were previously being incorrectly
-translated from Microsoft smart-quote-like characters.
-
-Fixed a bug that was breaking text fetch.
-
-Fixed a bug that crashed the parser when text chunks that look like
-HTML tag names showed up within a SCRIPT tag.
-
-THEAD, TBODY, and TFOOT tags are now nestable within TABLE
-tags. Nested tables should parse more sensibly now.
-
-BASE is now considered a self-closing tag.
-
-=3D 2.1.0 "Game, or any other dish?" (20050504) =3D
-
-Added a wide variety of new search methods which, given a starting
-point inside the tree, follow a particular navigation member (like
-nextSibling) over and over again, looking for Tag and NavigableText
-objects that match certain criteria. The new methods are findNext,
-fetchNext, findPrevious, fetchPrevious, findNextSibling,
-fetchNextSiblings, findPreviousSibling, fetchPreviousSiblings,
-findParent, and fetchParents. All of these use the same basic code
-used by first and fetch, so you can pass your weird ways of matching
-things into these methods.
-
-The fetch method and its derivatives now accept a limit argument.
-
-You can now pass keyword arguments when calling a Tag object as though
-it were a method.
-
-Fixed a bug that caused all hand-created tags to share a single set of
-attributes.
-
-=3D 2.0.3 (20050501) =3D
-
-Fixed Python 2.2 support for iterators.
-
-Fixed a bug that gave the wrong representation to tags within quote
-tags like <script>.
-
-Took some code from Mark Pilgrim that treats CDATA declarations as
-data instead of ignoring them.
-
-Beautiful Soup's setup.py will now do an install even if the unit
-tests fail. It won't build a source distribution if the unit tests
-fail, so I can't release a new version unless they pass.
-
-=3D 2.0.2 (20050416) =3D
-
-Added the unit tests in a separate module, and packaged it with
-distutils.
-
-Fixed a bug that sometimes caused renderContents() to return a Unicode
-string even if there was no Unicode in the original string.
-
-Added the done() method, which closes all of the parser's open
-tags. It gets called automatically when you pass in some text to the
-constructor of a parser class; otherwise you must call it yourself.
-
-Reinstated some backwards compatibility with 1.x versions: referencing
-the string member of a NavigableText object returns the NavigableText
-object instead of throwing an error.
-
-=3D 2.0.1 (20050412) =3D
-
-Fixed a bug that caused bad results when you tried to reference a tag
-name shorter than 3 characters as a member of a Tag, eg. tag.table.td.
-
-Made sure all Tags have the 'hidden' attribute so that an attempt to
-access tag.hidden doesn't spawn an attempt to find a tag named
-'hidden'.
-
-Fixed a bug in the comparison operator.
-
-=3D 2.0.0 "Who cares for fish?" (20050410)
-
-Beautiful Soup version 1 was very useful but also pretty stupid. I
-originally wrote it without noticing any of the problems inherent in
-trying to build a parse tree out of ambiguous HTML tags. This version
-solves all of those problems to my satisfaction. It also adds many new
-clever things to make up for the removal of the stupid things.
-
-=3D=3D Parsing =3D=3D
-
-The parser logic has been greatly improved, and the BeautifulSoup
-class should much more reliably yield a parse tree that looks like
-what the page author intended. For a particular class of odd edge
-cases that now causes problems, there is a new class,
-ICantBelieveItsBeautifulSoup.
-
-By default, Beautiful Soup now performs some cleanup operations on
-text before parsing it. This is to avoid common problems with bad
-definitions and self-closing tags that crash SGMLParser. You can
-provide your own set of cleanup operations, or turn it off
-altogether. The cleanup operations include fixing self-closing tags
-that don't close, and replacing Microsoft smart quotes and similar
-characters with their HTML entity equivalents.
-
-You can now get a pretty-print version of parsed HTML to get a visual
-picture of how Beautiful Soup parses it, with the Tag.prettify()
-method.
-
-=3D=3D Strings and Unicode =3D=3D
-
-There are separate NavigableText subclasses for ASCII and Unicode
-strings. These classes directly subclass the corresponding base data
-types. This means you can treat NavigableText objects as strings
-instead of having to call methods on them to get the strings.
-
-str() on a Tag always returns a string, and unicode() always returns
-Unicode. Previously it was inconsistent.
-
-=3D=3D Tree traversal =3D=3D
-
-In a first() or fetch() call, the tag name or the desired value of an
-attribute can now be any of the following:
-
- * A string (matches that specific tag or that specific attribute value)
- * A list of strings (matches any tag or attribute value in the list)
- * A compiled regular expression object (matches any tag or attribute
-   value that matches the regular expression)
- * A callable object that takes the Tag object or attribute value as a
-   string. It returns None/false/empty string if the given string
-   doesn't match, and any other value if it does.
-
-This is much easier to use than SQL-style wildcards (see, regular
-expressions are good for something). Because of this, I took out
-SQL-style wildcards. I'll put them back if someone complains, but
-their removal simplifies the code a lot.
-
-You can use fetch() and first() to search for text in the parse tree,
-not just tags. There are new alias methods fetchText() and firstText()
-designed for this purpose. As with searching for tags, you can pass in
-a string, a regular expression object, or a method to match your text.
-
-If you pass in something besides a map to the attrs argument of
-fetch() or first(), Beautiful Soup will assume you want to match that
-thing against the "class" attribute. When you're scraping
-well-structured HTML, this makes your code a lot cleaner.
-
-1.x and 2.x both let you call a Tag object as a shorthand for
-fetch(). For instance, foo("bar") is a shorthand for
-foo.fetch("bar"). In 2.x, you can also access a specially-named member
-of a Tag object as a shorthand for first(). For instance, foo.barTag
-is a shorthand for foo.first("bar"). By chaining these shortcuts you
-traverse a tree in very little code: for header in
-soup.bodyTag.pTag.tableTag('th'):
-
-If an element relationship (like parent or next) doesn't apply to a
-tag, it'll now show up Null instead of None. first() will also return
-Null if you ask it for a nonexistent tag. Null is an object that's
-just like None, except you can do whatever you want to it and it'll
-give you Null instead of throwing an error.
-
-This lets you do tree traversals like soup.htmlTag.headTag.titleTag
-without having to worry if the intermediate stages are actually
-there. Previously, if there was no 'head' tag in the document, headTag
-in that instance would have been None, and accessing its 'titleTag'
-member would have thrown an AttributeError. Now, you can get what you
-want when it exists, and get Null when it doesn't, without having to
-do a lot of conditionals checking to see if every stage is None.
-
-There are two new relations between page elements: previousSibling and
-nextSibling. They reference the previous and next element at the same
-level of the parse tree. For instance, if you have HTML like this:
-
-  <p><ul><li>Foo<br /><li>Bar</ul>
-
-The first 'li' tag has a previousSibling of Null and its nextSibling
-is the second 'li' tag. The second 'li' tag has a nextSibling of Null
-and its previousSibling is the first 'li' tag. The previousSibling of
-the 'ul' tag is the first 'p' tag. The nextSibling of 'Foo' is the
-'br' tag.
-
-I took out the ability to use fetch() to find tags that have a
-specific list of contents. See, I can't even explain it well. It was
-really difficult to use, I never used it, and I don't think anyone
-else ever used it. To the extent anyone did, they can probably use
-fetchText() instead. If it turns out someone needs it I'll think of
-another solution.
-
-=3D=3D Tree manipulation =3D=3D
-
-You can add new attributes to a tag, and delete attributes from a
-tag. In 1.x you could only change a tag's existing attributes.
-
-=3D=3D Porting Considerations =3D=3D
-
-There are three changes in 2.0 that break old code:
-
-In the post-1.2 release you could pass in a function into fetch(). The
-function took a string, the tag name. In 2.0, the function takes the
-actual Tag object.
-
-It's no longer to pass in SQL-style wildcards to fetch(). Use a
-regular expression instead.
-
-The different parsing algorithm means the parse tree may not be shaped
-like you expect. This will only actually affect you if your code uses
-one of the affected parts. I haven't run into this problem yet while
-porting my code.
-
-=3D Between 1.2 and 2.0 =3D
-
-This is the release to get if you want Python 1.5 compatibility.
-
-The desired value of an attribute can now be any of the following:
-
- * A string
- * A string with SQL-style wildcards
- * A compiled RE object
- * A callable that returns None/false/empty string if the given value
-   doesn't match, and any other value otherwise.
-
-This is much easier to use than SQL-style wildcards (see, regular
-expressions are good for something). Because of this, I no longer
-recommend you use SQL-style wildcards. They may go away in a future
-release to clean up the code.
-
-Made Beautiful Soup handle processing instructions as text instead of
-ignoring them.
-
-Applied patch from Richie Hindle (richie at entrian dot com) that
-makes tag.string a shorthand for tag.contents[0].string when the tag
-has only one string-owning child.
-
-Added still more nestable tags. The nestable tags thing won't work in
-a lot of cases and needs to be rethought.
-
-Fixed an edge case where searching for "%foo" would match any string
-shorter than "foo".
-
-=3D 1.2 "Who for such dainties would not stoop?" (20040708) =3D
-
-Applied patch from Ben Last (ben at benlast dot com) that made
-Tag.renderContents() correctly handle Unicode.
-
-Made BeautifulStoneSoup even dumber by making it not implicitly close
-a tag when another tag of the same type is encountered; only when an
-actual closing tag is encountered. This change courtesy of Fuzzy (mike
-at pcblokes dot com). BeautifulSoup still works as before.
-
-=3D 1.1 "Swimming in a hot tureen" =3D
-
-Added more 'nestable' tags. Changed popping semantics so that when a
-nestable tag is encountered, tags are popped up to the previously
-encountered nestable tag (of whatever kind). I will revert this if
-enough people complain, but it should make more people's lives easier
-than harder. This enhancement was suggested by Anthony Baxter (anthony
-at interlink dot com dot au).
-
-=3D 1.0 "So rich and green" (20040420) =3D
-
-Initial release.
diff --git a/lib/bb/_vendor/bs4/__init__.py b/lib/bb/_vendor/bs4/__init__=
.py
index 725203d94..58079b9e3 100644
--- a/lib/bb/_vendor/bs4/__init__.py
+++ b/lib/bb/_vendor/bs4/__init__.py
@@ -7,44 +7,74 @@ Beautiful Soup uses a pluggable XML or HTML parser to p=
arse a
 provides methods and Pythonic idioms that make it easy to navigate,
 search, and modify the parse tree.
=20
-Beautiful Soup works with Python 3.6 and up. It works better if lxml
-and/or html5lib is installed.
+Beautiful Soup works with Python 3.7 and up. It works better if lxml
+and/or html5lib is installed, but they are not required.
=20
 For more than you ever wanted to know about Beautiful Soup, see the
 documentation: http://www.crummy.com/software/BeautifulSoup/bs4/doc/
 """
=20
 __author__ =3D "Leonard Richardson (leonardr@segfault.org)"
-__version__ =3D "4.12.3"
-__copyright__ =3D "Copyright (c) 2004-2024 Leonard Richardson"
+__version__ =3D "4.15.0"
+__copyright__ =3D "Copyright (c) 2004-2026 Leonard Richardson"
 # Use of this source code is governed by the MIT license.
 __license__ =3D "MIT"
=20
-__all__ =3D ['BeautifulSoup']
+__all__ =3D [
+    "AttributeResemblesVariableWarning",
+    "BeautifulSoup",
+    "Comment",
+    "Declaration",
+    "ProcessingInstruction",
+    "ResultSet",
+    "CSS",
+    "Script",
+    "Stylesheet",
+    "Tag",
+    "TemplateString",
+    "ElementFilter",
+    "UnicodeDammit",
+    "CData",
+    "Doctype",
+
+    # Exceptions
+    "FeatureNotFound",
+    "ParserRejectedMarkup",
+    "StopParsing",
+
+    # Warnings
+    "AttributeResemblesVariableWarning",
+    "GuessedAtParserWarning",
+    "MarkupResemblesLocatorWarning",
+    "UnusualUsageWarning",
+    "XMLParsedAsHTMLWarning",
+]
=20
 from collections import Counter
-import os
-import re
+import io
 import sys
-import traceback
 import warnings
=20
 # The very first thing we do is give a useful error if someone is
 # running this code under Python 2.
 if sys.version_info.major < 3:
-    raise ImportError('You are trying to use a Python 3-specific version=
 of Beautiful Soup under Python 2. This will not work. The final version =
of Beautiful Soup to support Python 2 was 4.9.3.')
+    raise ImportError(
+        "You are trying to use a Python 3-specific version of Beautiful =
Soup under Python 2. This will not work. The final version of Beautiful S=
oup to support Python 2 was 4.9.3."
+    )
=20
 from .builder import (
     builder_registry,
-    ParserRejectedMarkup,
-    XMLParsedAsHTMLWarning,
-    HTMLParserTreeBuilder
+    TreeBuilder,
 )
+from .builder._htmlparser import HTMLParserTreeBuilder
 from .dammit import UnicodeDammit
+from .css import CSS
+from ._deprecation import (
+    _deprecated,
+)
 from .element import (
     CData,
     Comment,
-    CSS,
     DEFAULT_OUTPUT_ENCODING,
     Declaration,
     Doctype,
@@ -55,24 +85,53 @@ from .element import (
     ResultSet,
     Script,
     Stylesheet,
-    SoupStrainer,
     Tag,
     TemplateString,
-    )
+)
+from .formatter import Formatter
+from .filter import (
+    ElementFilter,
+    SoupStrainer,
+)
+from typing import (
+    Any,
+    cast,
+    Counter as CounterType,
+    Dict,
+    Iterator,
+    List,
+    Sequence,
+    Sized,
+    Optional,
+    Type,
+    Union,
+)
=20
-# Define some custom warnings.
-class GuessedAtParserWarning(UserWarning):
-    """The warning issued when BeautifulSoup has to guess what parser to
-    use -- probably because no parser was specified in the constructor.
-    """
+from bb._vendor.bs4._typing import (
+    _Encoding,
+    _Encodings,
+    _IncomingMarkup,
+    _InsertableElement,
+    _RawAttributeValue,
+    _RawAttributeValues,
+    _RawMarkup,
+)
+
+# Import all warnings and exceptions into the main package.
+from bb._vendor.bs4.exceptions import (
+    FeatureNotFound,
+    ParserRejectedMarkup,
+    StopParsing,
+)
+from bb._vendor.bs4._warnings import (
+    AttributeResemblesVariableWarning,
+    GuessedAtParserWarning,
+    MarkupResemblesLocatorWarning,
+    UnusualUsageWarning,
+    XMLParsedAsHTMLWarning,
+)
=20
-class MarkupResemblesLocatorWarning(UserWarning):
-    """The warning issued when BeautifulSoup is given 'markup' that
-    actually looks like a resource locator -- a URL or a path to a file
-    on disk.
-    """
=20
-  =20
 class BeautifulSoup(Tag):
     """A data structure representing a parsed HTML or XML document.
=20
@@ -104,24 +163,62 @@ class BeautifulSoup(Tag):
     handle_endtag.
     """
=20
-    # Since BeautifulSoup subclasses Tag, it's possible to treat it as
-    # a Tag with a .name. This name makes it clear the BeautifulSoup
-    # object isn't a real markup tag.
-    ROOT_TAG_NAME =3D '[document]'
-
-    # If the end-user gives no indication which tree builder they
-    # want, look for one with these features.
-    DEFAULT_BUILDER_FEATURES =3D ['html', 'fast']
-
-    # A string containing all ASCII whitespace characters, used in
-    # endData() to detect data chunks that seem 'empty'.
-    ASCII_SPACES =3D '\x20\x0a\x09\x0c\x0d'
-
-    NO_PARSER_SPECIFIED_WARNING =3D "No parser was explicitly specified,=
 so I'm using the best available %(markup_type)s parser for this system (=
\"%(parser)s\"). This usually isn't a problem, but if you run this code o=
n another system, or in a different virtual environment, it may use a dif=
ferent parser and behave differently.\n\nThe code that caused this warnin=
g is on line %(line_number)s of the file %(filename)s. To get rid of this=
 warning, pass the additional argument 'features=3D\"%(parser)s\"' to the=
 BeautifulSoup constructor.\n"
-  =20
-    def __init__(self, markup=3D"", features=3DNone, builder=3DNone,
-                 parse_only=3DNone, from_encoding=3DNone, exclude_encodi=
ngs=3DNone,
-                 element_classes=3DNone, **kwargs):
+    #: Since `BeautifulSoup` subclasses `Tag`, it's possible to treat it=
 as
+    #: a `Tag` with a `Tag.name`. Hoever, this name makes it clear the
+    #: `BeautifulSoup` object isn't a real markup tag.
+    ROOT_TAG_NAME: str =3D "[document]"
+
+    #: If the end-user gives no indication which tree builder they
+    #: want, look for one with these features.
+    DEFAULT_BUILDER_FEATURES: Sequence[str] =3D ["html", "fast"]
+
+    #: A string containing all ASCII whitespace characters, used in
+    #: during parsing to detect data chunks that seem 'empty'.
+    ASCII_SPACES: str =3D "\x20\x0a\x09\x0c\x0d"
+
+    # FUTURE PYTHON:
+    element_classes: Dict[Type[PageElement], Type[PageElement]]  #: :met=
a private:
+    builder: TreeBuilder  #: :meta private:
+    is_xml: bool
+    known_xml: Optional[bool]
+    parse_only: Optional[SoupStrainer]  #: :meta private:
+
+    # These members are only used while parsing markup.
+    markup: Optional[_RawMarkup]  #: :meta private:
+    current_data: List[str]  #: :meta private:
+    currentTag: Optional[Tag]  #: :meta private:
+    tagStack: List[Tag]  #: :meta private:
+    open_tag_counter: CounterType[str]  #: :meta private:
+    preserve_whitespace_tag_stack: List[Tag]  #: :meta private:
+    string_container_stack: List[Tag]  #: :meta private:
+    _most_recent_element: Optional[PageElement]  #: :meta private:
+
+    #: Beautiful Soup's best guess as to the character encoding of the
+    #: original document.
+    original_encoding: Optional[_Encoding]
+
+    #: The character encoding, if any, that was explicitly defined
+    #: in the original document. This may or may not match
+    #: `BeautifulSoup.original_encoding`.
+    declared_html_encoding: Optional[_Encoding]
+
+    #: This is True if the markup that was parsed contains
+    #: U+FFFD REPLACEMENT_CHARACTER characters which were not present
+    #: in the original markup. These mark character sequences that
+    #: could not be represented in Unicode.
+    contains_replacement_characters: bool
+
+    def __init__(
+        self,
+        markup: _IncomingMarkup =3D "",
+        features: Optional[Union[str, Sequence[str]]] =3D None,
+        builder: Optional[Union[TreeBuilder, Type[TreeBuilder]]] =3D Non=
e,
+        parse_only: Optional[SoupStrainer] =3D None,
+        from_encoding: Optional[_Encoding] =3D None,
+        exclude_encodings: Optional[_Encodings] =3D None,
+        element_classes: Optional[Dict[Type[PageElement], Type[PageEleme=
nt]]] =3D None,
+        **kwargs: Any,
+    ):
         """Constructor.
=20
         :param markup: A string or a file-like object representing
@@ -165,67 +262,85 @@ class BeautifulSoup(Tag):
          Beautiful Soup 3. None of these arguments do anything in
          Beautiful Soup 4; they will result in a warning and then be
          ignored.
-        =20
+
          Apart from this, any keyword arguments passed into the
          BeautifulSoup constructor are propagated to the TreeBuilder
          constructor. This makes it possible to configure a
          TreeBuilder by passing in arguments, not just by saying which
          one to use.
         """
-        if 'convertEntities' in kwargs:
-            del kwargs['convertEntities']
+        if "convertEntities" in kwargs:
+            del kwargs["convertEntities"]
             warnings.warn(
                 "BS4 does not respect the convertEntities argument to th=
e "
                 "BeautifulSoup constructor. Entities are always converte=
d "
-                "to Unicode characters.")
+                "to Unicode characters."
+            )
=20
-        if 'markupMassage' in kwargs:
-            del kwargs['markupMassage']
+        if "markupMassage" in kwargs:
+            del kwargs["markupMassage"]
             warnings.warn(
                 "BS4 does not respect the markupMassage argument to the =
"
                 "BeautifulSoup constructor. The tree builder is responsi=
ble "
-                "for any necessary markup massage.")
+                "for any necessary markup massage."
+            )
=20
-        if 'smartQuotesTo' in kwargs:
-            del kwargs['smartQuotesTo']
+        if "smartQuotesTo" in kwargs:
+            del kwargs["smartQuotesTo"]
             warnings.warn(
                 "BS4 does not respect the smartQuotesTo argument to the =
"
                 "BeautifulSoup constructor. Smart quotes are always conv=
erted "
-                "to Unicode characters.")
+                "to Unicode characters."
+            )
=20
-        if 'selfClosingTags' in kwargs:
-            del kwargs['selfClosingTags']
+        if "selfClosingTags" in kwargs:
+            del kwargs["selfClosingTags"]
             warnings.warn(
-                "BS4 does not respect the selfClosingTags argument to th=
e "
+                "Beautiful Soup 4 does not respect the selfClosingTags a=
rgument to the "
                 "BeautifulSoup constructor. The tree builder is responsi=
ble "
-                "for understanding self-closing tags.")
+                "for understanding self-closing tags."
+            )
=20
-        if 'isHTML' in kwargs:
-            del kwargs['isHTML']
+        if "isHTML" in kwargs:
+            del kwargs["isHTML"]
             warnings.warn(
-                "BS4 does not respect the isHTML argument to the "
+                "Beautiful Soup 4 does not respect the isHTML argument t=
o the "
                 "BeautifulSoup constructor. Suggest you use "
                 "features=3D'lxml' for HTML and features=3D'lxml-xml' fo=
r "
-                "XML.")
+                "XML."
+            )
=20
-        def deprecated_argument(old_name, new_name):
+        def deprecated_argument(old_name: str, new_name: str) -> Optiona=
l[Any]:
             if old_name in kwargs:
                 warnings.warn(
                     'The "%s" argument to the BeautifulSoup constructor =
'
-                    'has been renamed to "%s."' % (old_name, new_name),
-                    DeprecationWarning, stacklevel=3D3
+                    'was renamed to "%s" in Beautiful Soup 4.0.0'
+                    % (old_name, new_name),
+                    DeprecationWarning,
+                    stacklevel=3D3,
                 )
                 return kwargs.pop(old_name)
             return None
=20
-        parse_only =3D parse_only or deprecated_argument(
-            "parseOnlyThese", "parse_only")
+        parse_only =3D parse_only or deprecated_argument("parseOnlyThese=
", "parse_only")
+        if parse_only is not None:
+            # Issue a warning if we can tell in advance that
+            # parse_only will exclude the entire tree.
+            if parse_only.excludes_everything:
+                warnings.warn(
+                    f"The given value for parse_only will exclude everyt=
hing: {parse_only}",
+                    UserWarning,
+                    stacklevel=3D3,
+                )
=20
         from_encoding =3D from_encoding or deprecated_argument(
-            "fromEncoding", "from_encoding")
+            "fromEncoding", "from_encoding"
+        )
=20
         if from_encoding and isinstance(markup, str):
-            warnings.warn("You provided Unicode markup but also provided=
 a value for from_encoding. Your from_encoding will be ignored.")
+            warnings.warn(
+                "You provided Unicode markup but also provided a value f=
or from_encoding. Your from_encoding will be ignored."
+            )
             from_encoding =3D None
=20
         self.element_classes =3D element_classes or dict()
@@ -235,7 +350,8 @@ class BeautifulSoup(Tag):
         # specify a parser' warning.
         original_builder =3D builder
         original_features =3D features
-           =20
+
+        builder_class: Optional[Type[TreeBuilder]] =3D None
         if isinstance(builder, type):
             # A builder class was passed in; it needs to be instantiated.
             builder_class =3D builder
@@ -245,22 +361,32 @@ class BeautifulSoup(Tag):
                 features =3D [features]
             if features is None or len(features) =3D=3D 0:
                 features =3D self.DEFAULT_BUILDER_FEATURES
-            builder_class =3D builder_registry.lookup(*features)
-            if builder_class is None:
+            possible_builder_class =3D builder_registry.lookup(*features=
)
+            if possible_builder_class is None:
                 raise FeatureNotFound(
                     "Couldn't find a tree builder with the features you =
"
                     "requested: %s. Do you need to install a parser libr=
ary?"
-                    % ",".join(features))
+                    % ",".join(features)
+                )
+            builder_class =3D possible_builder_class
=20
         # At this point either we have a TreeBuilder instance in
         # builder, or we have a builder_class that we can instantiate
         # with the remaining **kwargs.
         if builder is None:
+            assert builder_class is not None
             builder =3D builder_class(**kwargs)
-            if not original_builder and not (
-                    original_features =3D=3D builder.NAME or
-                    original_features in builder.ALTERNATE_NAMES
-            ) and markup:
+            if (
+                not original_builder
+                and not (
+                    original_features =3D=3D builder.NAME
+                    or (
+                        isinstance(original_features, str)
+                        and original_features in builder.ALTERNATE_NAMES
+                    )
+                )
+                and markup
+            ):
                 # The user did not tell us which TreeBuilder to use,
                 # and we had to guess. Issue a warning.
                 if builder.is_xml:
@@ -281,8 +407,8 @@ class BeautifulSoup(Tag):
                     line_number =3D caller.f_lineno
                 else:
                     globals =3D sys.__dict__
-                    line_number=3D 1                   =20
-                filename =3D globals.get('__file__')
+                    line_number =3D 1
+                filename =3D globals.get("__file__")
                 if filename:
                     fnl =3D filename.lower()
                     if fnl.endswith((".pyc", ".pyo")):
@@ -294,41 +420,56 @@ class BeautifulSoup(Tag):
                         filename=3Dfilename,
                         line_number=3Dline_number,
                         parser=3Dbuilder.NAME,
-                        markup_type=3Dmarkup_type
+                        markup_type=3Dmarkup_type,
                     )
                     warnings.warn(
-                        self.NO_PARSER_SPECIFIED_WARNING % values,
-                        GuessedAtParserWarning, stacklevel=3D2
+                        GuessedAtParserWarning.MESSAGE % values,
+                        GuessedAtParserWarning,
+                        stacklevel=3D2,
                     )
         else:
             if kwargs:
-                warnings.warn("Keyword arguments to the BeautifulSoup co=
nstructor will be ignored. These would normally be passed into the TreeBu=
ilder constructor, but a TreeBuilder instance was passed in as `builder`.=
")
-                   =20
+                warnings.warn(
+                    "Keyword arguments to the BeautifulSoup constructor =
will be ignored. These would normally be passed into the TreeBuilder cons=
tructor, but a TreeBuilder instance was passed in as `builder`."
+                )
+
         self.builder =3D builder
         self.is_xml =3D builder.is_xml
         self.known_xml =3D self.is_xml
         self._namespaces =3D dict()
         self.parse_only =3D parse_only
=20
-        if hasattr(markup, 'read'):        # It's a file-type object.
-            markup =3D markup.read()
-        elif len(markup) <=3D 256 and (
-                (isinstance(markup, bytes) and not b'<' in markup)
-                or (isinstance(markup, str) and not '<' in markup)
+        if hasattr(markup, "read"):  # It's a file-type object.
+            markup =3D cast(io.IOBase, markup).read()
+        elif not isinstance(markup, (bytes, str)) and not hasattr(markup=
, "__len__"):
+            raise TypeError(
+                f"Incoming markup is of an invalid type: {markup!r}. Mar=
kup must be a string, a bytestring, or an open filehandle."
+            )
+        elif isinstance(markup, Sized) and len(markup) <=3D 256 and (
+            (isinstance(markup, bytes) and b"<" not in markup and b"\n" =
not in markup)
+            or (isinstance(markup, str) and "<" not in markup and "\n" n=
ot in markup)
         ):
             # Issue warnings for a couple beginner problems
             # involving passing non-markup to Beautiful Soup.
             # Beautiful Soup will still parse the input as markup,
             # since that is sometimes the intended behavior.
             if not self._markup_is_url(markup):
-                self._markup_resembles_filename(markup)               =20
+                self._markup_resembles_filename(markup)
+
+        # At this point we know markup is a string or bytestring.  If
+        # it was a file-type object, we've read from it.
+        markup =3D cast(_RawMarkup, markup)
=20
         rejections =3D []
         success =3D False
-        for (self.markup, self.original_encoding, self.declared_html_enc=
oding,
-         self.contains_replacement_characters) in (
-             self.builder.prepare_markup(
-                 markup, from_encoding, exclude_encodings=3Dexclude_enco=
dings)):
+        for (
+            self.markup,
+            self.original_encoding,
+            self.declared_html_encoding,
+            self.contains_replacement_characters,
+        ) in self.builder.prepare_markup(
+            markup, from_encoding, exclude_encodings=3Dexclude_encodings
+        ):
             self.reset()
             self.builder.initialize_soup(self)
             try:
@@ -342,7 +483,8 @@ class BeautifulSoup(Tag):
         if not success:
             other_exceptions =3D [str(e) for e in rejections]
             raise ParserRejectedMarkup(
-                "The markup you provided was rejected by the parser. Try=
ing a different parser or a different encoding may help.\n\nOriginal exce=
ption(s) from parser:\n " + "\n ".join(other_exceptions)
+                "The markup you provided was rejected by the parser. Try=
ing a different parser or a different encoding may help.\n\nOriginal exce=
ption(s) from parser:\n "
+                + "\n ".join(other_exceptions)
             )
=20
         # Clear out the markup and remove the builder's circular
@@ -350,7 +492,7 @@ class BeautifulSoup(Tag):
         self.markup =3D None
         self.builder.soup =3D None
=20
-    def _clone(self):
+    def copy_self(self) -> "BeautifulSoup":
         """Create a new BeautifulSoup object with the same TreeBuilder,
         but not associated with any markup.
=20
@@ -362,24 +504,24 @@ class BeautifulSoup(Tag):
         # since we won't be parsing it again.
         clone.original_encoding =3D self.original_encoding
         return clone
-       =20
-    def __getstate__(self):
+
+    def __getstate__(self) -> Dict[str, Any]:
         # Frequently a tree builder can't be pickled.
         d =3D dict(self.__dict__)
-        if 'builder' in d and d['builder'] is not None and not self.buil=
der.picklable:
-            d['builder'] =3D type(self.builder)
+        if "builder" in d and d["builder"] is not None and not self.buil=
der.picklable:
+            d["builder"] =3D type(self.builder)
         # Store the contents as a Unicode string.
-        d['contents'] =3D []
-        d['markup'] =3D self.decode()
+        d["contents"] =3D []
+        d["markup"] =3D self.decode()
=20
         # If _most_recent_element is present, it's a Tag object left
         # over from initial parse. It might not be picklable and we
         # don't need it.
-        if '_most_recent_element' in d:
-            del d['_most_recent_element']
+        if "_most_recent_element" in d:
+            del d["_most_recent_element"]
         return d
=20
-    def __setstate__(self, state):
+    def __setstate__(self, state: Dict[str, Any]) -> None:
         # If necessary, restore the TreeBuilder by looking it up.
         self.__dict__ =3D state
         if isinstance(self.builder, type):
@@ -391,102 +533,150 @@ class BeautifulSoup(Tag):
         self.builder.soup =3D self
         self.reset()
         self._feed()
-        return state
=20
-   =20
+    @property
+    def _is_root(self):
+        """Yes, a BeautifulSoup object is the root of its parse tree. Us=
ed by the _root_object internal property."""
+        return True
+
     @classmethod
-    def _decode_markup(cls, markup):
-        """Ensure `markup` is bytes so it's safe to send into warnings.w=
arn.
+    @_deprecated(
+        replaced_by=3D"nothing (private method, will be removed)", versi=
on=3D"4.13.0"
+    )
+    def _decode_markup(cls, markup: _RawMarkup) -> str:
+        """Ensure `markup` is Unicode so it's safe to send into warnings=
.warn.
=20
-        TODO: warnings.warn had this problem back in 2010 but it might n=
ot
-        anymore.
+        warnings.warn had this problem back in 2010 but fortunately
+        not anymore. This has not been used for a long time; I just
+        noticed that fact while working on 4.13.0.
         """
         if isinstance(markup, bytes):
-            decoded =3D markup.decode('utf-8', 'replace')
+            decoded =3D markup.decode("utf-8", "replace")
         else:
             decoded =3D markup
         return decoded
=20
     @classmethod
-    def _markup_is_url(cls, markup):
+    def _markup_is_url(cls, markup: _RawMarkup) -> bool:
         """Error-handling method to raise a warning if incoming markup l=
ooks
         like a URL.
=20
-        :param markup: A string.
-        :return: Whether or not the markup resembles a URL
-            closely enough to justify a warning.
+        :param markup: A string of markup.
+        :return: Whether or not the markup resembled a URL
+            closely enough to justify issuing a warning.
         """
+        problem: bool =3D False
         if isinstance(markup, bytes):
-            space =3D b' '
-            cant_start_with =3D (b"http:", b"https:")
+            problem =3D (
+                any(markup.startswith(prefix) for prefix in (b"http:", b=
"https:"))
+                and b" " not in markup
+            )
         elif isinstance(markup, str):
-            space =3D ' '
-            cant_start_with =3D ("http:", "https:")
+            problem =3D (
+                any(markup.startswith(prefix) for prefix in ("http:", "h=
ttps:"))
+                and " " not in markup
+            )
         else:
             return False
=20
-        if any(markup.startswith(prefix) for prefix in cant_start_with):
-            if not space in markup:
-                warnings.warn(
-                    'The input looks more like a URL than markup. You ma=
y want to use'
-                    ' an HTTP client like requests to get the document b=
ehind'
-                    ' the URL, and feed that document to Beautiful Soup.=
',
-                    MarkupResemblesLocatorWarning,
-                    stacklevel=3D3
-                )
-                return True
-        return False
+        if not problem:
+            return False
+        warnings.warn(
+            MarkupResemblesLocatorWarning.URL_MESSAGE % dict(what=3D"URL=
"),
+            MarkupResemblesLocatorWarning,
+            stacklevel=3D3,
+        )
+        return True
=20
     @classmethod
-    def _markup_resembles_filename(cls, markup):
-        """Error-handling method to raise a warning if incoming markup
+    def _markup_resembles_filename(cls, markup: _RawMarkup) -> bool:
+        """Error-handling method to issue a warning if incoming markup
         resembles a filename.
=20
-        :param markup: A bytestring or string.
-        :return: Whether or not the markup resembles a filename
-            closely enough to justify a warning.
+        :param markup: A string of markup.
+        :return: Whether or not the markup resembled a filename
+            closely enough to justify issuing a warning.
         """
-        path_characters =3D '/\\'
-        extensions =3D ['.html', '.htm', '.xml', '.xhtml', '.txt']
-        if isinstance(markup, bytes):
-            path_characters =3D path_characters.encode("utf8")
-            extensions =3D [x.encode('utf8') for x in extensions]
+        markup_b: bytes
+
+        # We're only checking ASCII characters, so rather than write
+        # the same tests twice, convert Unicode to a bytestring and
+        # operate on the bytestring.
+        if isinstance(markup, str):
+            markup_b =3D markup.encode("utf8")
+        else:
+            markup_b =3D markup
+
+        # Step 1: does it end with a common textual file extension?
         filelike =3D False
-        if any(x in markup for x in path_characters):
+        lower =3D markup_b.lower()
+        extensions =3D [b".html", b".htm", b".xml", b".xhtml", b".txt"]
+        if any(lower.endswith(ext) for ext in extensions):
             filelike =3D True
-        else:
-            lower =3D markup.lower()
-            if any(lower.endswith(ext) for ext in extensions):
-                filelike =3D True
-        if filelike:
-            warnings.warn(
-                'The input looks more like a filename than markup. You m=
ay'
-                ' want to open this file and pass the filehandle into'
-                ' Beautiful Soup.',
-                MarkupResemblesLocatorWarning, stacklevel=3D3
-            )
-            return True
-        return False
-   =20
-    def _feed(self):
+        if not filelike:
+            return False
+
+        # Step 2: it _might_ be a file, but there are a few things
+        # we can look for that aren't very common in filenames.
+
+        # Characters that have special meaning to Unix shells. (< was
+        # excluded before this method was called.)
+        #
+        # Many of these are also reserved characters that cannot
+        # appear in Windows filenames.
+        for byte in markup_b:
+            if byte in b"?*#&;>$|":
+                return False
+
+        # Two consecutive forward slashes (as seen in a URL) or two
+        # consecutive spaces (as seen in fixed-width data).
+        #
+        # (Paths to Windows network shares contain consecutive
+        #  backslashes, so checking that doesn't seem as helpful.)
+        if b"//" in markup_b:
+            return False
+        if b"  " in markup_b:
+            return False
+
+        # A colon in any position other than position 1 (e.g. after a
+        # Windows drive letter).
+        if markup_b.startswith(b":"):
+            return False
+        colon_i =3D markup_b.rfind(b":")
+        if colon_i not in (-1, 1):
+            return False
+
+        # Step 3: If it survived all of those checks, it's similar
+        # enough to a file to justify issuing a warning.
+        warnings.warn(
+            MarkupResemblesLocatorWarning.FILENAME_MESSAGE % dict(what=3D=
"filename"),
+            MarkupResemblesLocatorWarning,
+            stacklevel=3D3,
+        )
+        return True
+
+    def _feed(self) -> None:
         """Internal method that parses previously set markup, creating a=
 large
         number of Tag and NavigableString objects.
         """
         # Convert the document to Unicode.
         self.builder.reset()
=20
-        self.builder.feed(self.markup)
+        if self.markup is not None:
+            self.builder.feed(self.markup)
         # Close out any unfinished strings and close all the open tags.
         self.endData()
-        while self.currentTag.name !=3D self.ROOT_TAG_NAME:
+        while (
+            self.currentTag is not None and self.currentTag.name !=3D se=
lf.ROOT_TAG_NAME
+        ):
             self.popTag()
=20
-    def reset(self):
+    def reset(self) -> None:
         """Reset this object to a state as though it had never parsed an=
y
         markup.
         """
         Tag.__init__(self, self, self.builder, self.ROOT_TAG_NAME)
-        self.hidden =3D 1
+        self.hidden =3D True
         self.builder.reset()
         self.current_data =3D []
         self.currentTag =3D None
@@ -497,35 +687,71 @@ class BeautifulSoup(Tag):
         self._most_recent_element =3D None
         self.pushTag(self)
=20
-    def new_tag(self, name, namespace=3DNone, nsprefix=3DNone, attrs=3D{=
},
-                sourceline=3DNone, sourcepos=3DNone, **kwattrs):
+    def new_tag(
+        self,
+        name: str,
+        namespace: Optional[str] =3D None,
+        nsprefix: Optional[str] =3D None,
+        attrs: Optional[_RawAttributeValues] =3D None,
+        sourceline: Optional[int] =3D None,
+        sourcepos: Optional[int] =3D None,
+        string: Optional[str] =3D None,
+        **kwattrs: _RawAttributeValue,
+    ) -> Tag:
         """Create a new Tag associated with this BeautifulSoup object.
=20
         :param name: The name of the new Tag.
         :param namespace: The URI of the new Tag's XML namespace, if any.
         :param prefix: The prefix for the new Tag's XML namespace, if an=
y.
         :param attrs: A dictionary of this Tag's attribute values; can
-            be used instead of `kwattrs` for attributes like 'class'
+            be used instead of ``kwattrs`` for attributes like 'class'
             that are reserved words in Python.
         :param sourceline: The line number where this tag was
             (purportedly) found in its source document.
-        :param sourcepos: The character position within `sourceline` whe=
re this
+        :param sourcepos: The character position within ``sourceline`` w=
here this
             tag was (purportedly) found.
+        :param string: String content for the new Tag, if any.
         :param kwattrs: Keyword arguments for the new Tag's attribute va=
lues.
=20
         """
-        kwattrs.update(attrs)
-        return self.element_classes.get(Tag, Tag)(
-            None, self.builder, name, namespace, nsprefix, kwattrs,
-            sourceline=3Dsourceline, sourcepos=3Dsourcepos
+        attr_container =3D self.builder.attribute_dict_class(**kwattrs)
+        if attrs is not None:
+            attr_container.update(attrs)
+        tag_class =3D self.element_classes.get(Tag, Tag)
+
+        # Assume that this is either Tag or a subclass of Tag. If not,
+        # the user brought type-unsafety upon themselves.
+        tag_class =3D cast(Type[Tag], tag_class)
+        tag =3D tag_class(
+            None,
+            self.builder,
+            name,
+            namespace,
+            nsprefix,
+            attr_container,
+            sourceline=3Dsourceline,
+            sourcepos=3Dsourcepos,
         )
=20
-    def string_container(self, base_class=3DNone):
+        if string is not None:
+            tag.string =3D string
+        return tag
+
+    def string_container(
+        self, base_class: Optional[Type[NavigableString]] =3D None
+    ) -> Type[NavigableString]:
+        """Find the class that should be instantiated to hold a given ki=
nd of
+        string.
+
+        This may be a built-in Beautiful Soup class or a custom class pa=
ssed
+        in to the BeautifulSoup constructor.
+        """
         container =3D base_class or NavigableString
-       =20
-        # There may be a general override of NavigableString.
-        container =3D self.element_classes.get(
-            container, container
+
+        # The user may want us to use some other class (hopefully a
+        # custom subclass) instead of the one we'd use normally.
+        container =3D cast(
+            Type[NavigableString], self.element_classes.get(container, c=
ontainer)
         )
=20
         # On top of that, we may be inside a tag that needs a special
@@ -535,43 +761,65 @@ class BeautifulSoup(Tag):
                 self.string_container_stack[-1].name, container
             )
         return container
-       =20
-    def new_string(self, s, subclass=3DNone):
-        """Create a new NavigableString associated with this BeautifulSo=
up
+
+    def new_string(
+        self, s: str, subclass: Optional[Type[NavigableString]] =3D None
+    ) -> NavigableString:
+        """Create a new `NavigableString` associated with this `Beautifu=
lSoup`
         object.
+
+        :param s: The string content of the `NavigableString`
+        :param subclass: The subclass of `NavigableString`, if any, to
+               use. If a document is being processed, an appropriate
+               subclass for the current location in the document will
+               be determined automatically.
         """
         container =3D self.string_container(subclass)
         return container(s)
=20
-    def insert_before(self, *args):
+    def insert_before(self, *args: _InsertableElement) -> List[PageEleme=
nt]:
         """This method is part of the PageElement API, but `BeautifulSou=
p` doesn't implement
         it because there is nothing before or after it in the parse tree.
         """
-        raise NotImplementedError("BeautifulSoup objects don't support i=
nsert_before().")
+        raise NotImplementedError(
+            "BeautifulSoup objects don't support insert_before()."
+        )
=20
-    def insert_after(self, *args):
+    def insert_after(self, *args: _InsertableElement) -> List[PageElemen=
t]:
         """This method is part of the PageElement API, but `BeautifulSou=
p` doesn't implement
         it because there is nothing before or after it in the parse tree.
         """
         raise NotImplementedError("BeautifulSoup objects don't support i=
nsert_after().")
=20
-    def popTag(self):
-        """Internal method called by _popToTag when a tag is closed."""
+    def popTag(self) -> Optional[Tag]:
+        """Internal method called by _popToTag when a tag is closed.
+
+        :meta private:
+        """
+        if not self.tagStack:
+            # Nothing to pop. This shouldn't happen.
+            return None
         tag =3D self.tagStack.pop()
         if tag.name in self.open_tag_counter:
             self.open_tag_counter[tag.name] -=3D 1
-        if self.preserve_whitespace_tag_stack and tag =3D=3D self.preser=
ve_whitespace_tag_stack[-1]:
+        if (
+            self.preserve_whitespace_tag_stack
+            and tag =3D=3D self.preserve_whitespace_tag_stack[-1]
+        ):
             self.preserve_whitespace_tag_stack.pop()
         if self.string_container_stack and tag =3D=3D self.string_contai=
ner_stack[-1]:
             self.string_container_stack.pop()
-        #print("Pop", tag.name)
+        # print("Pop", tag.name)
         if self.tagStack:
             self.currentTag =3D self.tagStack[-1]
         return self.currentTag
=20
-    def pushTag(self, tag):
-        """Internal method called by handle_starttag when a tag is opene=
d."""
-        #print("Push", tag.name)
+    def pushTag(self, tag: Tag) -> None:
+        """Internal method called by handle_starttag when a tag is opene=
d.
+
+        :meta private:
+        """
+        # print("Push", tag.name)
         if self.currentTag is not None:
             self.currentTag.contents.append(tag)
         self.tagStack.append(tag)
@@ -583,12 +831,17 @@ class BeautifulSoup(Tag):
         if tag.name in self.builder.string_containers:
             self.string_container_stack.append(tag)
=20
-    def endData(self, containerClass=3DNone):
+    def endData(self, containerClass: Optional[Type[NavigableString]] =3D=
 None) -> None:
         """Method called by the TreeBuilder when the end of a data segme=
nt
         occurs.
-        """      =20
+
+        :param containerClass: The class to use when incorporating the
+        data segment into the parse tree.
+
+        :meta private:
+        """
         if self.current_data:
-            current_data =3D ''.join(self.current_data)
+            current_data =3D "".join(self.current_data)
             # If whitespace is not preserved, and this string contains
             # nothing but ASCII spaces, replace it with a single space
             # or newline.
@@ -599,28 +852,41 @@ class BeautifulSoup(Tag):
                         strippable =3D False
                         break
                 if strippable:
-                    if '\n' in current_data:
-                        current_data =3D '\n'
+                    if "\n" in current_data:
+                        current_data =3D "\n"
                     else:
-                        current_data =3D ' '
+                        current_data =3D " "
=20
             # Reset the data collector.
             self.current_data =3D []
=20
             # Should we add this string to the tree at all?
-            if self.parse_only and len(self.tagStack) <=3D 1 and \
-                   (not self.parse_only.text or \
-                    not self.parse_only.search(current_data)):
+            if (
+                self.parse_only
+                and len(self.tagStack) <=3D 1
+                and (not self.parse_only.allow_string_creation(current_d=
ata))
+            ):
                 return
=20
             containerClass =3D self.string_container(containerClass)
             o =3D containerClass(current_data)
             self.object_was_parsed(o)
=20
-    def object_was_parsed(self, o, parent=3DNone, most_recent_element=3D=
None):
-        """Method called by the TreeBuilder to integrate an object into =
the parse tree."""
+    def object_was_parsed(
+        self,
+        o: PageElement,
+        parent: Optional[Tag] =3D None,
+        most_recent_element: Optional[PageElement] =3D None,
+    ) -> None:
+        """Method called by the TreeBuilder to integrate an object into =
the
+        parse tree.
+
+        :meta private:
+        """
         if parent is None:
             parent =3D self.currentTag
+        assert parent is not None
+        previous_element: Optional[PageElement]
         if most_recent_element is not None:
             previous_element =3D most_recent_element
         else:
@@ -645,12 +911,12 @@ class BeautifulSoup(Tag):
         if fix:
             self._linkage_fixer(parent)
=20
-    def _linkage_fixer(self, el):
+    def _linkage_fixer(self, el: Tag) -> None:
         """Make sure linkage of this fragment is sound."""
=20
         first =3D el.contents[0]
         child =3D el.contents[-1]
-        descendant =3D child
+        descendant: PageElement =3D child
=20
         if child is first and el.parent is not None:
             # Parent should be linked to first child
@@ -668,14 +934,18 @@ class BeautifulSoup(Tag):
=20
         # This index is a tag, dig deeper for a "last descendant"
         if isinstance(child, Tag) and child.contents:
-            descendant =3D child._last_descendant(False)
+            # _last_decendant is typed as returning Optional[PageElement=
],
+            # but the value can't be None here, because el is a Tag
+            # which we know has contents.
+            descendant =3D cast(PageElement, child._last_descendant(Fals=
e))
=20
         # As the final step, link last descendant. It should be linked
         # to the parent's next sibling (if found), else walk up the chai=
n
         # and find a parent with a sibling. It should have no next sibli=
ng.
         descendant.next_element =3D None
         descendant.next_sibling =3D None
-        target =3D el
+
+        target: Optional[Tag] =3D el
         while True:
             if target is None:
                 break
@@ -685,7 +955,9 @@ class BeautifulSoup(Tag):
                 break
             target =3D target.parent
=20
-    def _popToTag(self, name, nsprefix=3DNone, inclusivePop=3DTrue):
+    def _popToTag(
+        self, name: str, nsprefix: Optional[str] =3D None, inclusivePop:=
 bool =3D True
+    ) -> Optional[Tag]:
         """Pops the tag stack up to and including the most recent
         instance of the given tag.
=20
@@ -698,11 +970,12 @@ class BeautifulSoup(Tag):
           to but *not* including the most recent instqance of the
           given tag.
=20
+        :meta private:
         """
-        #print("Popping to %s" % name)
+        # print("Popping to %s" % name)
         if name =3D=3D self.ROOT_TAG_NAME:
             # The BeautifulSoup object itself can never be popped.
-            return
+            return None
=20
         most_recently_popped =3D None
=20
@@ -711,7 +984,7 @@ class BeautifulSoup(Tag):
             if not self.open_tag_counter.get(name):
                 break
             t =3D self.tagStack[i]
-            if (name =3D=3D t.name and nsprefix =3D=3D t.prefix):
+            if name =3D=3D t.name and nsprefix =3D=3D t.prefix:
                 if inclusivePop:
                     most_recently_popped =3D self.popTag()
                 break
@@ -719,38 +992,63 @@ class BeautifulSoup(Tag):
=20
         return most_recently_popped
=20
-    def handle_starttag(self, name, namespace, nsprefix, attrs, sourceli=
ne=3DNone,
-                        sourcepos=3DNone, namespaces=3DNone):
+    def handle_starttag(
+        self,
+        name: str,
+        namespace: Optional[str],
+        nsprefix: Optional[str],
+        attrs: _RawAttributeValues,
+        sourceline: Optional[int] =3D None,
+        sourcepos: Optional[int] =3D None,
+        namespaces: Optional[Dict[str, str]] =3D None,
+    ) -> Optional[Tag]:
         """Called by the tree builder when a new tag is encountered.
=20
         :param name: Name of the tag.
         :param nsprefix: Namespace prefix for the tag.
-        :param attrs: A dictionary of attribute values.
+        :param attrs: A dictionary of attribute values. Note that
+           attribute values are expected to be simple strings; processin=
g
+           of multi-valued attributes such as "class" comes later.
         :param sourceline: The line number where this tag was found in i=
ts
             source document.
         :param sourcepos: The character position within `sourceline` whe=
re this
             tag was found.
-        :param namespaces: A dictionary of all namespace prefix mappings=
=20
+        :param namespaces: A dictionary of all namespace prefix mappings
             currently in scope in the document.
=20
         If this method returns None, the tag was rejected by an active
-        SoupStrainer. You should proceed as if the tag had not occurred
+        `ElementFilter`. You should proceed as if the tag had not occurr=
ed
         in the document. For instance, if this was a self-closing tag,
         don't call handle_endtag.
+
+        :meta private:
         """
         # print("Start tag %s: %s" % (name, attrs))
         self.endData()
=20
-        if (self.parse_only and len(self.tagStack) <=3D 1
-            and (self.parse_only.text
-                 or not self.parse_only.search_tag(name, attrs))):
+        if (
+            self.parse_only
+            and len(self.tagStack) <=3D 1
+            and not self.parse_only.allow_tag_creation(nsprefix, name, a=
ttrs)
+        ):
             return None
=20
-        tag =3D self.element_classes.get(Tag, Tag)(
-            self, self.builder, name, namespace, nsprefix, attrs,
-            self.currentTag, self._most_recent_element,
-            sourceline=3Dsourceline, sourcepos=3Dsourcepos,
-            namespaces=3Dnamespaces
+        tag_class =3D self.element_classes.get(Tag, Tag)
+        # Assume that this is either Tag or a subclass of Tag. If not,
+        # the user brought type-unsafety upon themselves.
+        tag_class =3D cast(Type[Tag], tag_class)
+        tag =3D tag_class(
+            self,
+            self.builder,
+            name,
+            namespace,
+            nsprefix,
+            attrs,
+            self.currentTag,
+            self._most_recent_element,
+            sourceline=3Dsourceline,
+            sourcepos=3Dsourcepos,
+            namespaces=3Dnamespaces,
         )
         if tag is None:
             return tag
@@ -760,80 +1058,120 @@ class BeautifulSoup(Tag):
         self.pushTag(tag)
         return tag
=20
-    def handle_endtag(self, name, nsprefix=3DNone):
+    def handle_endtag(self, name: str, nsprefix: Optional[str] =3D None)=
 -> None:
         """Called by the tree builder when an ending tag is encountered.
=20
         :param name: Name of the tag.
         :param nsprefix: Namespace prefix for the tag.
+
+        :meta private:
         """
-        #print("End tag: " + name)
+        # print("End tag: " + name)
         self.endData()
         self._popToTag(name, nsprefix)
-       =20
-    def handle_data(self, data):
-        """Called by the tree builder when a chunk of textual data is en=
countered."""
+
+    def handle_data(self, data: str) -> None:
+        """Called by the tree builder when a chunk of textual data is
+        encountered.
+
+        :meta private:
+        """
         self.current_data.append(data)
-      =20
-    def decode(self, pretty_print=3DFalse,
-               eventual_encoding=3DDEFAULT_OUTPUT_ENCODING,
-               formatter=3D"minimal", iterator=3DNone):
-        """Returns a string or Unicode representation of the parse tree
-            as an HTML or XML document.
-
-        :param pretty_print: If this is True, indentation will be used t=
o
-            make the document more readable.
+
+    def decode(
+        self,
+        indent_level: Optional[int] =3D None,
+        eventual_encoding: _Encoding =3D DEFAULT_OUTPUT_ENCODING,
+        formatter: Union[Formatter, str] =3D "minimal",
+        iterator: Optional[Iterator[PageElement]] =3D None,
+        **kwargs: Any,
+    ) -> str:
+        """Returns a string representation of the parse tree
+            as a full HTML or XML document.
+
+        :param indent_level: Each line of the rendering will be
+           indented this many levels. (The ``formatter`` decides what a
+           'level' means, in terms of spaces or other characters
+           output.) This is used internally in recursive calls while
+           pretty-printing.
         :param eventual_encoding: The encoding of the final document.
             If this is None, the document will be a Unicode string.
+        :param formatter: Either a `Formatter` object, or a string namin=
g one of
+            the standard formatters.
+        :param iterator: The iterator to use when navigating over the
+            parse tree. This is only used by `Tag.decode_contents` and
+            you probably won't need to use it.
         """
         if self.is_xml:
             # Print the XML declaration
-            encoding_part =3D ''
+            encoding_part =3D ""
+            declared_encoding: Optional[str] =3D eventual_encoding
             if eventual_encoding in PYTHON_SPECIFIC_ENCODINGS:
                 # This is a special Python encoding; it can't actually
                 # go into an XML document because it means nothing
                 # outside of Python.
-                eventual_encoding =3D None
-            if eventual_encoding !=3D None:
-                encoding_part =3D ' encoding=3D"%s"' % eventual_encoding
+                declared_encoding =3D None
+            if declared_encoding is not None:
+                encoding_part =3D ' encoding=3D"%s"' % declared_encoding
             prefix =3D '<?xml version=3D"1.0"%s?>\n' % encoding_part
         else:
-            prefix =3D ''
-        if not pretty_print:
-            indent_level =3D None
+            prefix =3D ""
+
+        # Prior to 4.13.0, the first argument to this method was a
+        # bool called pretty_print, which gave the method a different
+        # signature from its superclass implementation, Tag.decode.
+        #
+        # The signatures of the two methods now match, but just in
+        # case someone is still passing a boolean in as the first
+        # argument to this method (or a keyword argument with the old
+        # name), we can handle it and put out a DeprecationWarning.
+        warning: Optional[str] =3D None
+        pretty_print: Optional[bool] =3D None
+        if isinstance(indent_level, bool):
+            if indent_level is True:
+                indent_level =3D 0
+            elif indent_level is False:
+                indent_level =3D None
+            warning =3D f"As of 4.13.0, the first argument to BeautifulS=
oup.decode has been changed from bool to int, to match Tag.decode. Pass i=
n a value of {indent_level} instead."
         else:
-            indent_level =3D 0
+            pretty_print =3D kwargs.pop("pretty_print", None)
+            assert not kwargs
+            if pretty_print is not None:
+                if pretty_print is True:
+                    indent_level =3D 0
+                elif pretty_print is False:
+                    indent_level =3D None
+                warning =3D f"As of 4.13.0, the pretty_print argument to=
 BeautifulSoup.decode has been removed, to match Tag.decode. Pass in a va=
lue of indent_level=3D{indent_level} instead."
+
+        if warning:
+            warnings.warn(warning, DeprecationWarning, stacklevel=3D2)
+        elif indent_level is False or pretty_print is False:
+            indent_level =3D None
         return prefix + super(BeautifulSoup, self).decode(
-            indent_level, eventual_encoding, formatter, iterator)
+            indent_level, eventual_encoding, formatter, iterator
+        )
+
=20
 # Aliases to make it easier to get started quickly, e.g. 'from bs4 impor=
t _soup'
 _s =3D BeautifulSoup
 _soup =3D BeautifulSoup
=20
+
 class BeautifulStoneSoup(BeautifulSoup):
     """Deprecated interface to an XML parser."""
=20
-    def __init__(self, *args, **kwargs):
-        kwargs['features'] =3D 'xml'
+    def __init__(self, *args: Any, **kwargs: Any):
+        kwargs["features"] =3D "xml"
         warnings.warn(
-            'The BeautifulStoneSoup class is deprecated. Instead of usin=
g '
+            "The BeautifulStoneSoup class was deprecated in version 4.0.=
0. Instead of using "
             'it, pass features=3D"xml" into the BeautifulSoup constructo=
r.',
-            DeprecationWarning, stacklevel=3D2
+            DeprecationWarning,
+            stacklevel=3D2,
         )
         super(BeautifulStoneSoup, self).__init__(*args, **kwargs)
=20
=20
-class StopParsing(Exception):
-    """Exception raised by a TreeBuilder if it's unable to continue pars=
ing."""
-    pass
-
-class FeatureNotFound(ValueError):
-    """Exception raised by the BeautifulSoup constructor if no parser wi=
th the
-    requested features is found.
-    """
-    pass
-
-
-#If this file is run as a script, act as an HTML pretty-printer.
-if __name__ =3D=3D '__main__':
+# If this file is run as a script, act as an HTML pretty-printer.
+if __name__ =3D=3D "__main__":
     soup =3D BeautifulSoup(sys.stdin)
     print((soup.prettify()))
diff --git a/lib/bb/_vendor/bs4/_deprecation.py b/lib/bb/_vendor/bs4/_dep=
recation.py
new file mode 100644
index 000000000..a7b5685b8
--- /dev/null
+++ b/lib/bb/_vendor/bs4/_deprecation.py
@@ -0,0 +1,80 @@
+"""Helper functions for deprecation.
+
+This interface is itself unstable and may change without warning. Do
+not use these functions yourself, even as a joke. The underscores are
+there for a reason. No support will be given.
+
+In particular, most of this will go away without warning once
+Beautiful Soup drops support for Python 3.11, since Python 3.12
+defines a `@typing.deprecated()
+decorator. <https://peps.python.org/pep-0702/>`_
+"""
+
+import functools
+import warnings
+
+from typing import (
+    Any,
+    Callable,
+)
+
+
+def _deprecated_alias(old_name: str, new_name: str, version: str):
+    """Alias one attribute name to another for backward compatibility
+
+    :meta private:
+    """
+
+    @property # type:ignore
+    def alias(self) -> Any:
+        ":meta private:"
+        warnings.warn(
+            f"Access to deprecated property {old_name}. (Replaced by {ne=
w_name}) -- Deprecated since version {version}.",
+            DeprecationWarning,
+            stacklevel=3D2,
+        )
+        return getattr(self, new_name)
+
+    @alias.setter
+    def alias(self, value: str) -> None:
+        ":meta private:"
+        warnings.warn(
+            f"Write to deprecated property {old_name}. (Replaced by {new=
_name}) -- Deprecated since version {version}.",
+            DeprecationWarning,
+            stacklevel=3D2,
+        )
+        return setattr(self, new_name, value)
+
+    return alias
+
+
+def _deprecated_function_alias(
+    old_name: str, new_name: str, version: str
+) -> Callable[[Any], Any]:
+    def alias(self, *args: Any, **kwargs: Any) -> Any:
+        ":meta private:"
+        warnings.warn(
+            f"Call to deprecated method {old_name}. (Replaced by {new_na=
me}) -- Deprecated since version {version}.",
+            DeprecationWarning,
+            stacklevel=3D2,
+        )
+        return getattr(self, new_name)(*args, **kwargs)
+
+    return alias
+
+
+def _deprecated(replaced_by: str, version: str) -> Callable:
+    def deprecate(func: Callable) -> Callable:
+        @functools.wraps(func)
+        def with_warning(*args: Any, **kwargs: Any) -> Any:
+            ":meta private:"
+            warnings.warn(
+                f"Call to deprecated method {func.__name__}. (Replaced b=
y {replaced_by}) -- Deprecated since version {version}.",
+                DeprecationWarning,
+                stacklevel=3D2,
+            )
+            return func(*args, **kwargs)
+
+        return with_warning
+
+    return deprecate
diff --git a/lib/bb/_vendor/bs4/_typing.py b/lib/bb/_vendor/bs4/_typing.p=
y
new file mode 100644
index 000000000..f3965ccbe
--- /dev/null
+++ b/lib/bb/_vendor/bs4/_typing.py
@@ -0,0 +1,205 @@
+# Custom type aliases used throughout Beautiful Soup to improve readabil=
ity.
+
+# Notes on improvements to the type system in newer versions of Python
+# that can be used once Beautiful Soup drops support for older
+# versions:
+#
+# * ClassVar can be put on class variables now.
+# * In 3.10, x|y is an accepted shorthand for Union[x,y].
+# * In 3.10, TypeAlias gains capabilities that can be used to
+#   improve the tree matching types (I don't remember what, exactly).
+# * In 3.9 it's possible to specialize the re.Match type,
+#   e.g. re.Match[str]. In 3.8 there's a typing.re namespace for this,
+#   but it's removed in 3.12, so to support the widest possible set of
+#   versions I'm not using it.
+
+from typing_extensions import (
+    runtime_checkable,
+    Protocol,
+    TypeAlias,
+)
+from typing import (
+    Any,
+    Callable,
+    Dict,
+    IO,
+    Iterable,
+    Mapping,
+    Optional,
+    Pattern,
+    TYPE_CHECKING,
+    Union,
+)
+
+if TYPE_CHECKING:
+    from bb._vendor.bs4.element import (
+        AttributeValueList,
+        NamespacedAttribute,
+        NavigableString,
+        PageElement,
+        ResultSet,
+        Tag,
+    )
+
+
+@runtime_checkable
+class _RegularExpressionProtocol(Protocol):
+    """A protocol object which can accept either Python's built-in
+    `re.Pattern` objects, or the similar ``Regex`` objects defined by th=
e
+    third-party ``regex`` package.
+    """
+
+    def search(
+        self, string: str, pos: int =3D ..., endpos: int =3D ...
+    ) -> Optional[Any]: ...
+
+    @property
+    def pattern(self) -> str: ...
+
+
+# Aliases for markup in various stages of processing.
+#
+#: The rawest form of markup: either a string, bytestring, or an open fi=
lehandle.
+_IncomingMarkup: TypeAlias =3D Union[str, bytes, IO[str], IO[bytes]]
+
+#: Markup that is in memory but has (potentially) yet to be converted
+#: to Unicode.
+_RawMarkup: TypeAlias =3D Union[str, bytes]
+
+# Aliases for character encodings
+#
+
+#: A data encoding.
+_Encoding: TypeAlias =3D str
+
+#: One or more data encodings.
+_Encodings: TypeAlias =3D Iterable[_Encoding]
+
+# Aliases for XML namespaces
+#
+
+#: The prefix for an XML namespace.
+_NamespacePrefix: TypeAlias =3D str
+
+#: The URL of an XML namespace
+_NamespaceURL: TypeAlias =3D str
+
+#: A mapping of prefixes to namespace URLs.
+_NamespaceMapping: TypeAlias =3D Dict[_NamespacePrefix, _NamespaceURL]
+
+#: A mapping of namespace URLs to prefixes
+_InvertedNamespaceMapping: TypeAlias =3D Dict[_NamespaceURL, _NamespaceP=
refix]
+
+# Aliases for the attribute values associated with HTML/XML tags.
+#
+
+#: The value associated with an HTML or XML attribute. This is the
+#: relatively unprocessed value Beautiful Soup expects to come from a
+#: `TreeBuilder`.
+_RawAttributeValue: TypeAlias =3D str
+
+#: A dictionary of names to `_RawAttributeValue` objects. This is how
+#: Beautiful Soup expects a `TreeBuilder` to represent a tag's
+#: attribute values.
+_RawAttributeValues: TypeAlias =3D (
+    "Mapping[Union[str, NamespacedAttribute], _RawAttributeValue]"
+)
+
+#: An attribute value in its final form, as stored in the
+# `Tag` class, after it has been processed and (in some cases)
+# split into a list of strings.
+_AttributeValue: TypeAlias =3D Union[str, "AttributeValueList"]
+
+#: A dictionary of names to :py:data:`_AttributeValue` objects. This is =
what
+#: a tag's attributes look like after processing.
+_AttributeValues: TypeAlias =3D Dict[str, _AttributeValue]
+
+#: The methods that deal with turning :py:data:`_RawAttributeValue` into
+#: :py:data:`_AttributeValue` may be called several times, even after th=
e values
+#: are already processed (e.g. when cloning a tag), so they need to
+#: be able to acommodate both possibilities.
+_RawOrProcessedAttributeValues: TypeAlias =3D Union[_RawAttributeValues,=
 _AttributeValues]
+
+#: A number of tree manipulation methods can take either a `PageElement`=
 or a
+#: normal Python string (which will be converted to a `NavigableString`).
+_InsertableElement: TypeAlias =3D Union["PageElement", str]
+
+# Aliases to represent the many possibilities for matching bits of a
+# parse tree.
+#
+# This is very complicated because we're applying a formal type system
+# to some very DWIM code. The types we end up with will be the types
+# of the arguments to the SoupStrainer constructor and (more
+# familiarly to Beautiful Soup users) the find* methods.
+
+#: A function that takes a PageElement and returns a yes-or-no answer.
+_PageElementMatchFunction: TypeAlias =3D Callable[["PageElement"], bool]
+
+#: A function that takes the raw parsed ingredients of a markup tag
+#: and returns a yes-or-no answer.
+#  Not necessary at the moment.
+# _AllowTagCreationFunction:TypeAlias =3D Callable[[Optional[str], str, =
Optional[_RawAttributeValues]], bool]
+
+#: A function that takes the raw parsed ingredients of a markup string n=
ode
+#: and returns a yes-or-no answer.
+#  Not necessary at the moment.
+# _AllowStringCreationFunction:TypeAlias =3D Callable[[Optional[str]], b=
ool]
+
+#: A function that takes a `Tag` and returns a yes-or-no answer.
+#: A `TagNameMatchRule` expects this kind of function, if you're
+#: going to pass it a function.
+_TagMatchFunction: TypeAlias =3D Callable[["Tag"], bool]
+
+#: A function that takes a string (or None) and returns a yes-or-no
+#: answer. An `AttributeValueMatchRule` expects this kind of function, i=
f
+#: you're going to pass it a function.
+_NullableStringMatchFunction: TypeAlias =3D Callable[[Optional[str]], bo=
ol]
+
+#: A function that takes a string and returns a yes-or-no answer.  A
+# `StringMatchRule` expects this kind of function, if you're going to
+# pass it a function.
+_StringMatchFunction: TypeAlias =3D Callable[[str], bool]
+
+#: Either a tag name, an attribute value or a string can be matched
+#: against a string, bytestring, regular expression, or a boolean.
+_BaseStrainable: TypeAlias =3D Union[str, bytes, Pattern[str], bool]
+
+#: A tag can be matched either with the `_BaseStrainable` options, or
+#: using a function that takes the `Tag` as its sole argument.
+_BaseStrainableElement: TypeAlias =3D Union[_BaseStrainable, _TagMatchFu=
nction]
+
+#: A tag's attribute value can be matched either with the
+#: `_BaseStrainable` options, or using a function that takes that
+#: value as its sole argument.
+_BaseStrainableAttribute: TypeAlias =3D Union[_BaseStrainable, _Nullable=
StringMatchFunction]
+
+#: A tag can be matched using either a single criterion or a list of
+#: criteria.
+_StrainableElement: TypeAlias =3D Union[
+    _BaseStrainableElement, Iterable[_BaseStrainableElement]
+]
+
+#: An attribute value can be matched using either a single criterion
+#: or a list of criteria.
+_StrainableAttribute: TypeAlias =3D Union[
+    _BaseStrainableAttribute, Iterable[_BaseStrainableAttribute]
+]
+
+#: An string can be matched using the same techniques as
+#: an attribute value.
+_StrainableString: TypeAlias =3D _StrainableAttribute
+
+#: A dictionary may be used to match against multiple attribute vlaues a=
t once.
+_StrainableAttributes: TypeAlias =3D Dict[str, _StrainableAttribute]
+
+#: Many Beautiful soup methods return a PageElement or an ResultSet of
+#: PageElements. A PageElement is either a Tag or a NavigableString.
+#: These convenience aliases make it easier for IDE users to see which m=
ethods
+#: are available on the objects they're dealing with.
+_OneElement: TypeAlias =3D Union["PageElement", "Tag", "NavigableString"=
]
+_AtMostOneElement: TypeAlias =3D Optional[_OneElement]
+_AtMostOneTag: TypeAlias =3D Optional["Tag"]
+_AtMostOneNavigableString: TypeAlias =3D Optional["NavigableString"]
+_QueryResults: TypeAlias =3D "ResultSet[_OneElement]"
+_SomeTags: TypeAlias =3D "ResultSet[Tag]"
+_SomeNavigableStrings: TypeAlias =3D "ResultSet[NavigableString]"
diff --git a/lib/bb/_vendor/bs4/_warnings.py b/lib/bb/_vendor/bs4/_warnin=
gs.py
new file mode 100644
index 000000000..890417058
--- /dev/null
+++ b/lib/bb/_vendor/bs4/_warnings.py
@@ -0,0 +1,98 @@
+"""Define some custom warnings."""
+
+
+class GuessedAtParserWarning(UserWarning):
+    """The warning issued when BeautifulSoup has to guess what parser to
+    use -- probably because no parser was specified in the constructor.
+    """
+
+    MESSAGE: str =3D """No parser was explicitly specified, so I'm using=
 the best available %(markup_type)s parser for this system ("%(parser)s")=
. This usually isn't a problem, but if you run this code on another syste=
m, or in a different virtual environment, it may use a different parser a=
nd behave differently.
+
+The code that caused this warning is on line %(line_number)s of the file=
 %(filename)s. To get rid of this warning, pass the additional argument '=
features=3D"%(parser)s"' to the BeautifulSoup constructor.
+"""
+
+
+class UnusualUsageWarning(UserWarning):
+    """A superclass for warnings issued when Beautiful Soup sees
+    something that is typically the result of a mistake in the calling
+    code, but might be intentional on the part of the user. If it is
+    in fact intentional, you can filter the individual warning class
+    to get rid of the warning. If you don't like Beautiful Soup
+    second-guessing what you are doing, you can filter the
+    UnusualUsageWarningclass itself and get rid of these entirely.
+    """
+
+
+class MarkupResemblesLocatorWarning(UnusualUsageWarning):
+    """The warning issued when BeautifulSoup is given 'markup' that
+    actually looks like a resource locator -- a URL or a path to a file
+    on disk.
+    """
+
+    #: :meta private:
+    GENERIC_MESSAGE: str =3D """
+
+However, if you want to parse some data that happens to look like a %(wh=
at)s, then nothing has gone wrong: you are using Beautiful Soup correctly=
, and this warning is spurious and can be filtered. To make this warning =
go away, run this code before calling the BeautifulSoup constructor:
+
+    from bb._vendor.bs4 import MarkupResemblesLocatorWarning
+    import warnings
+
+    warnings.filterwarnings("ignore", category=3DMarkupResemblesLocatorW=
arning)
+    """
+
+    URL_MESSAGE: str =3D (
+        """The input passed in on this line looks more like a URL than H=
TML or XML.
+
+If you meant to use Beautiful Soup to parse the web page found at a cert=
ain URL, then something has gone wrong. You should use an Python package =
like 'requests' to fetch the content behind the URL. Once you have the co=
ntent as a string, you can feed that string into Beautiful Soup."""
+        + GENERIC_MESSAGE
+    )
+
+    FILENAME_MESSAGE: str =3D (
+        """The input passed in on this line looks more like a filename t=
han HTML or XML.
+
+If you meant to use Beautiful Soup to parse the contents of a file on di=
sk, then something has gone wrong. You should open the file first, using =
code like this:
+
+    filehandle =3D open(your filename)
+
+You can then feed the open filehandle into Beautiful Soup instead of usi=
ng the filename."""
+        + GENERIC_MESSAGE
+    )
+
+
+class AttributeResemblesVariableWarning(UnusualUsageWarning, SyntaxWarni=
ng):
+    """The warning issued when Beautiful Soup suspects a provided
+    attribute name may actually be the misspelled name of a Beautiful
+    Soup variable. Generally speaking, this is only used in cases like
+    "_class" where it's very unlikely the user would be referencing an
+    XML attribute with that name.
+    """
+
+    MESSAGE: str =3D """%(original)r is an unusual attribute name and is=
 a common misspelling for %(autocorrect)r.
+
+If you meant %(autocorrect)r, change your code to use it, and this warni=
ng will go away.
+
+If you really did mean to check the %(original)r attribute, this warning=
 is spurious and can be filtered. To make it go away, run this code befor=
e creating your BeautifulSoup object:
+
+    from bb._vendor.bs4 import AttributeResemblesVariableWarning
+    import warnings
+
+    warnings.filterwarnings("ignore", category=3DAttributeResemblesVaria=
bleWarning)
+"""
+
+
+class XMLParsedAsHTMLWarning(UnusualUsageWarning):
+    """The warning issued when an HTML parser is used to parse
+    XML that is not (as far as we can tell) XHTML.
+    """
+
+    MESSAGE: str =3D """It looks like you're using an HTML parser to par=
se an XML document.
+
+Assuming this really is an XML document, what you're doing might work, b=
ut you should know that using an XML parser will be more reliable. To par=
se this document as XML, make sure you have the Python package 'lxml' ins=
talled, and pass the keyword argument `features=3D"xml"` into the Beautif=
ulSoup constructor.
+
+If you want or need to use an HTML parser on this document, you can make=
 this warning go away by filtering it. To do that, run this code before c=
alling the BeautifulSoup constructor:
+
+    from bb._vendor.bs4 import XMLParsedAsHTMLWarning
+    import warnings
+
+    warnings.filterwarnings("ignore", category=3DXMLParsedAsHTMLWarning)
+"""
diff --git a/lib/bb/_vendor/bs4/builder/__init__.py b/lib/bb/_vendor/bs4/=
builder/__init__.py
index d60a9a672..c9d5786da 100644
--- a/lib/bb/_vendor/bs4/builder/__init__.py
+++ b/lib/bb/_vendor/bs4/builder/__init__.py
@@ -1,12 +1,29 @@
+from __future__ import annotations
+
 # Use of this source code is governed by the MIT license.
 __license__ =3D "MIT"
=20
 from collections import defaultdict
-import itertools
 import re
+from types import ModuleType
+from typing import (
+    Any,
+    cast,
+    Dict,
+    Iterable,
+    List,
+    Optional,
+    Pattern,
+    Set,
+    Tuple,
+    Type,
+    TYPE_CHECKING,
+)
 import warnings
 import sys
-from ..element import (
+from bb._vendor.bs4.element import (
+    AttributeDict,
+    AttributeValueList,
     CharsetMetaAttributeValue,
     ContentMetaAttributeValue,
     RubyParenthesisString,
@@ -14,51 +31,81 @@ from ..element import (
     Stylesheet,
     Script,
     TemplateString,
-    nonwhitespace_re
+    nonwhitespace_re,
+)
+
+# Exceptions were moved to their own module in 4.13. Import here for
+# backwards compatibility.
+from bb._vendor.bs4.exceptions import ParserRejectedMarkup
+
+from bb._vendor.bs4._typing import (
+    _AttributeValues,
+    _RawAttributeValue,
 )
=20
+from bb._vendor.bs4._warnings import XMLParsedAsHTMLWarning
+
+if TYPE_CHECKING:
+    from bb._vendor.bs4 import BeautifulSoup
+    from bb._vendor.bs4.element import (
+        NavigableString,
+        Tag,
+    )
+    from bb._vendor.bs4._typing import (
+        _AttributeValue,
+        _Encoding,
+        _Encodings,
+        _RawOrProcessedAttributeValues,
+        _RawMarkup,
+    )
+
 __all__ =3D [
-    'HTMLTreeBuilder',
-    'SAXTreeBuilder',
-    'TreeBuilder',
-    'TreeBuilderRegistry',
-    ]
+    "HTMLTreeBuilder",
+    "SAXTreeBuilder",
+    "TreeBuilder",
+    "TreeBuilderRegistry",
+]
=20
 # Some useful features for a TreeBuilder to have.
-FAST =3D 'fast'
-PERMISSIVE =3D 'permissive'
-STRICT =3D 'strict'
-XML =3D 'xml'
-HTML =3D 'html'
-HTML_5 =3D 'html5'
-
-class XMLParsedAsHTMLWarning(UserWarning):
-    """The warning issued when an HTML parser is used to parse
-    XML that is not XHTML.
-    """
-    MESSAGE =3D """It looks like you're parsing an XML document using an=
 HTML parser. If this really is an HTML document (maybe it's XHTML?), you=
 can ignore or filter this warning. If it's XML, you should know that usi=
ng an XML parser will be more reliable. To parse this document as XML, ma=
ke sure you have the lxml package installed, and pass the keyword argumen=
t `features=3D"xml"` into the BeautifulSoup constructor."""
+FAST =3D "fast"
+PERMISSIVE =3D "permissive"
+STRICT =3D "strict"
+XML =3D "xml"
+HTML =3D "html"
+HTML_5 =3D "html5"
+
+__all__ =3D [
+    "TreeBuilderRegistry",
+    "TreeBuilder",
+    "HTMLTreeBuilder",
+    "DetectsXMLParsedAsHTML",
=20
+    "ParserRejectedMarkup", # backwards compatibility only as of 4.13.0
+]
=20
 class TreeBuilderRegistry(object):
     """A way of looking up TreeBuilder subclasses by their name or by de=
sired
     features.
     """
-   =20
-    def __init__(self):
+
+    builders_for_feature: Dict[str, List[Type[TreeBuilder]]]
+    builders: List[Type[TreeBuilder]]
+
+    def __init__(self) -> None:
         self.builders_for_feature =3D defaultdict(list)
         self.builders =3D []
=20
-    def register(self, treebuilder_class):
+    def register(self, treebuilder_class: type[TreeBuilder]) -> None:
         """Register a treebuilder based on its advertised features.
=20
-        :param treebuilder_class: A subclass of Treebuilder. its .featur=
es
-           attribute should list its features.
+        :param treebuilder_class: A subclass of `TreeBuilder`. its
+           `TreeBuilder.features` attribute should list its features.
         """
         for feature in treebuilder_class.features:
             self.builders_for_feature[feature].insert(0, treebuilder_cla=
ss)
         self.builders.insert(0, treebuilder_class)
=20
-    def lookup(self, *features):
+    def lookup(self, *features: str) -> Optional[Type[TreeBuilder]]:
         """Look up a TreeBuilder subclass with the desired features.
=20
         :param features: A list of features to look for. If none are
@@ -78,100 +125,92 @@ class TreeBuilderRegistry(object):
=20
         # Go down the list of features in order, and eliminate any build=
ers
         # that don't match every feature.
-        features =3D list(features)
-        features.reverse()
+        feature_list =3D list(features)
+        feature_list.reverse()
         candidates =3D None
         candidate_set =3D None
-        while len(features) > 0:
-            feature =3D features.pop()
+        while len(feature_list) > 0:
+            feature =3D feature_list.pop()
             we_have_the_feature =3D self.builders_for_feature.get(featur=
e, [])
             if len(we_have_the_feature) > 0:
                 if candidates is None:
                     candidates =3D we_have_the_feature
                     candidate_set =3D set(candidates)
-                else:
+                elif candidate_set is not None:
                     # Eliminate any candidates that don't have this feat=
ure.
-                    candidate_set =3D candidate_set.intersection(
-                        set(we_have_the_feature))
+                    candidate_set =3D candidate_set.intersection(set(we_=
have_the_feature))
=20
         # The only valid candidates are the ones in candidate_set.
         # Go through the original list of candidates and pick the first =
one
         # that's in candidate_set.
-        if candidate_set is None:
+        if candidate_set is None or candidates is None:
             return None
         for candidate in candidates:
             if candidate in candidate_set:
                 return candidate
         return None
=20
-# The BeautifulSoup class will take feature lists from developers and us=
e them
-# to look up builders in this registry.
-builder_registry =3D TreeBuilderRegistry()
+
+#: The `BeautifulSoup` constructor will take a list of features
+#: and use it to look up `TreeBuilder` classes in this registry.
+builder_registry: TreeBuilderRegistry =3D TreeBuilderRegistry()
+
=20
 class TreeBuilder(object):
-    """Turn a textual document into a Beautiful Soup object tree."""
-
-    NAME =3D "[Unknown tree builder]"
-    ALTERNATE_NAMES =3D []
-    features =3D []
-
-    is_xml =3D False
-    picklable =3D False
-    empty_element_tags =3D None # A tag will be considered an empty-elem=
ent
-                              # tag when and only when it has no content=
s.
-   =20
-    # A value for these tag/attribute combinations is a space- or
-    # comma-separated list of CDATA, rather than a single CDATA.
-    DEFAULT_CDATA_LIST_ATTRIBUTES =3D defaultdict(list)
-
-    # Whitespace should be preserved inside these tags.
-    DEFAULT_PRESERVE_WHITESPACE_TAGS =3D set()
-
-    # The textual contents of tags with these names should be
-    # instantiated with some class other than NavigableString.
-    DEFAULT_STRING_CONTAINERS =3D {}
-   =20
-    USE_DEFAULT =3D object()
-
-    # Most parsers don't keep track of line numbers.
-    TRACKS_LINE_NUMBERS =3D False
-   =20
-    def __init__(self, multi_valued_attributes=3DUSE_DEFAULT,
-                 preserve_whitespace_tags=3DUSE_DEFAULT,
-                 store_line_numbers=3DUSE_DEFAULT,
-                 string_containers=3DUSE_DEFAULT,
+    """Turn a textual document into a Beautiful Soup object tree.
+
+    This is an abstract superclass which smooths out the behavior of
+    different parser libraries into a single, unified interface.
+
+    :param multi_valued_attributes: If this is set to None, the
+     TreeBuilder will not turn any values for attributes like
+     'class' into lists. Setting this to a dictionary will
+     customize this behavior; look at :py:attr:`bs4.builder.HTMLTreeBuil=
der.DEFAULT_CDATA_LIST_ATTRIBUTES`
+     for an example.
+
+     Internally, these are called "CDATA list attributes", but that
+     probably doesn't make sense to an end-user, so the argument name
+     is ``multi_valued_attributes``.
+
+    :param preserve_whitespace_tags: A set of tags to treat
+     the way <pre> tags are treated in HTML. Tags in this set
+     are immune from pretty-printing; their contents will always be
+     output as-is.
+
+    :param string_containers: A dictionary mapping tag names to
+     the classes that should be instantiated to contain the textual
+     contents of those tags. The default is to use NavigableString
+     for every tag, no matter what the name. You can override the
+     default by changing :py:attr:`DEFAULT_STRING_CONTAINERS`.
+
+    :param store_line_numbers: If the parser keeps track of the line
+     numbers and positions of the original markup, that information
+     will, by default, be stored in each corresponding
+     :py:class:`bs4.element.Tag` object. You can turn this off by
+     passing store_line_numbers=3DFalse; then Tag.sourcepos and
+     Tag.sourceline will always be None. If the parser you're using
+     doesn't keep track of this information, then store_line_numbers
+     is irrelevant.
+
+    :param attribute_dict_class: The value of a multi-valued attribute
+      (such as HTML's 'class') willl be stored in an instance of this
+      class.  The default is Beautiful Soup's built-in
+      `AttributeValueList`, which is a normal Python list, and you
+      will probably never need to change it.
+    """
+
+    USE_DEFAULT: Any =3D object()  #: :meta private:
+
+    def __init__(
+        self,
+        multi_valued_attributes: Dict[str, Set[str]] =3D USE_DEFAULT,
+        preserve_whitespace_tags: Set[str] =3D USE_DEFAULT,
+        store_line_numbers: bool =3D USE_DEFAULT,
+        string_containers: Dict[str, Type[NavigableString]] =3D USE_DEFA=
ULT,
+        empty_element_tags: Set[str] =3D USE_DEFAULT,
+        attribute_dict_class: Type[AttributeDict] =3D AttributeDict,
+        attribute_value_list_class: Type[AttributeValueList] =3D Attribu=
teValueList,
     ):
-        """Constructor.
-
-        :param multi_valued_attributes: If this is set to None, the
-         TreeBuilder will not turn any values for attributes like
-         'class' into lists. Setting this to a dictionary will
-         customize this behavior; look at DEFAULT_CDATA_LIST_ATTRIBUTES
-         for an example.
-
-         Internally, these are called "CDATA list attributes", but that
-         probably doesn't make sense to an end-user, so the argument nam=
e
-         is `multi_valued_attributes`.
-
-        :param preserve_whitespace_tags: A list of tags to treat
-         the way <pre> tags are treated in HTML. Tags in this list
-         are immune from pretty-printing; their contents will always be
-         output as-is.
-
-        :param string_containers: A dictionary mapping tag names to
-        the classes that should be instantiated to contain the textual
-        contents of those tags. The default is to use NavigableString
-        for every tag, no matter what the name. You can override the
-        default by changing DEFAULT_STRING_CONTAINERS.
-
-        :param store_line_numbers: If the parser keeps track of the
-         line numbers and positions of the original markup, that
-         information will, by default, be stored in each corresponding
-         `Tag` object. You can turn this off by passing
-         store_line_numbers=3DFalse. If the parser you're using doesn't=20
-         keep track of this information, then setting store_line_numbers=
=3DTrue
-         will do nothing.
-        """
         self.soup =3D None
         if multi_valued_attributes is self.USE_DEFAULT:
             multi_valued_attributes =3D self.DEFAULT_CDATA_LIST_ATTRIBUT=
ES
@@ -179,22 +218,68 @@ class TreeBuilder(object):
         if preserve_whitespace_tags is self.USE_DEFAULT:
             preserve_whitespace_tags =3D self.DEFAULT_PRESERVE_WHITESPAC=
E_TAGS
         self.preserve_whitespace_tags =3D preserve_whitespace_tags
+        if empty_element_tags is self.USE_DEFAULT:
+            self.empty_element_tags =3D self.DEFAULT_EMPTY_ELEMENT_TAGS
+        else:
+            self.empty_element_tags =3D empty_element_tags
+        # TODO: store_line_numbers is probably irrelevant now that
+        # the behavior of sourceline and sourcepos has been made consist=
ent
+        # everywhere.
         if store_line_numbers =3D=3D self.USE_DEFAULT:
             store_line_numbers =3D self.TRACKS_LINE_NUMBERS
-        self.store_line_numbers =3D store_line_numbers=20
+        self.store_line_numbers =3D store_line_numbers
         if string_containers =3D=3D self.USE_DEFAULT:
             string_containers =3D self.DEFAULT_STRING_CONTAINERS
         self.string_containers =3D string_containers
-       =20
-    def initialize_soup(self, soup):
+        self.attribute_dict_class =3D attribute_dict_class
+        self.attribute_value_list_class =3D attribute_value_list_class
+
+    NAME: str =3D "[Unknown tree builder]"
+    ALTERNATE_NAMES: Iterable[str] =3D []
+    features: Iterable[str] =3D []
+
+    is_xml: bool =3D False
+    picklable: bool =3D False
+
+    soup: Optional[BeautifulSoup]  #: :meta private:
+
+    #: A tag will be considered an empty-element
+    #: tag when and only when it has no contents.
+    empty_element_tags: Optional[Set[str]] =3D None  #: :meta private:
+    cdata_list_attributes: Dict[str, Set[str]]  #: :meta private:
+    preserve_whitespace_tags: Set[str]  #: :meta private:
+    string_containers: Dict[str, Type[NavigableString]]  #: :meta privat=
e:
+    tracks_line_numbers: bool  #: :meta private:
+
+    #: A value for these tag/attribute combinations is a space- or
+    #: comma-separated list of CDATA, rather than a single CDATA.
+    DEFAULT_CDATA_LIST_ATTRIBUTES: Dict[str, Set[str]] =3D defaultdict(s=
et)
+
+    #: Whitespace should be preserved inside these tags.
+    DEFAULT_PRESERVE_WHITESPACE_TAGS: Set[str] =3D set()
+
+    #: The textual contents of tags with these names should be
+    #: instantiated with some class other than `bs4.element.NavigableStr=
ing`.
+    DEFAULT_STRING_CONTAINERS: Dict[str, Type[bs4.element.NavigableStrin=
g]] =3D {} # type:ignore
+
+    #: By default, tags are treated as empty-element tags if they have
+    #: no contents--that is, using XML rules. HTMLTreeBuilder
+    #: defines a different set of DEFAULT_EMPTY_ELEMENT_TAGS based on th=
e
+    #: HTML 4 and HTML5 standards.
+    DEFAULT_EMPTY_ELEMENT_TAGS: Optional[Set[str]] =3D None
+
+    #: Most parsers don't keep track of line numbers.
+    TRACKS_LINE_NUMBERS: bool =3D False
+
+    def initialize_soup(self, soup: BeautifulSoup) -> None:
         """The BeautifulSoup object has been initialized and is now
         being associated with the TreeBuilder.
=20
         :param soup: A BeautifulSoup object.
         """
         self.soup =3D soup
-       =20
-    def reset(self):
+
+    def reset(self) -> None:
         """Do any work necessary to reset the underlying parser
         for a new document.
=20
@@ -202,7 +287,7 @@ class TreeBuilder(object):
         """
         pass
=20
-    def can_be_empty_element(self, tag_name):
+    def can_be_empty_element(self, tag_name: str) -> bool:
         """Might a tag with this name be an empty-element tag?
=20
         The final markup may or may not actually present this tag as
@@ -224,47 +309,48 @@ class TreeBuilder(object):
         if self.empty_element_tags is None:
             return True
         return tag_name in self.empty_element_tags
-   =20
-    def feed(self, markup):
-        """Run some incoming markup through some parsing process,
-        populating the `BeautifulSoup` object in self.soup.
-
-        This method is not implemented in TreeBuilder; it must be
-        implemented in subclasses.
=20
-        :return: None.
-        """
+    def feed(self, markup: _RawMarkup) -> None:
+        """Run incoming markup through some parsing process."""
         raise NotImplementedError()
=20
-    def prepare_markup(self, markup, user_specified_encoding=3DNone,
-                       document_declared_encoding=3DNone, exclude_encodi=
ngs=3DNone):
+    def prepare_markup(
+        self,
+        markup: _RawMarkup,
+        user_specified_encoding: Optional[_Encoding] =3D None,
+        document_declared_encoding: Optional[_Encoding] =3D None,
+        exclude_encodings: Optional[_Encodings] =3D None,
+    ) -> Iterable[Tuple[_RawMarkup, Optional[_Encoding], Optional[_Encod=
ing], bool]]:
         """Run any preliminary steps necessary to make incoming markup
         acceptable to the parser.
=20
-        :param markup: Some markup -- probably a bytestring.
-        :param user_specified_encoding: The user asked to try this encod=
ing.
+        :param markup: The markup that's about to be parsed.
+        :param user_specified_encoding: The user asked to try this encod=
ing
+           to convert the markup into a Unicode string.
         :param document_declared_encoding: The markup itself claims to b=
e
             in this encoding. NOTE: This argument is not used by the
             calling code and can probably be removed.
-        :param exclude_encodings: The user asked _not_ to try any of
+        :param exclude_encodings: The user asked *not* to try any of
             these encodings.
=20
-        :yield: A series of 4-tuples:
-         (markup, encoding, declared encoding,
-          has undergone character replacement)
+        :yield: A series of 4-tuples: (markup, encoding, declared encodi=
ng,
+            has undergone character replacement)
=20
-         Each 4-tuple represents a strategy for converting the
-         document to Unicode and parsing it. Each strategy will be tried=
=20
-         in turn.
+            Each 4-tuple represents a strategy that the parser can try
+            to convert the document to Unicode and parse it. Each
+            strategy will be tried in turn.
=20
          By default, the only strategy is to parse the markup
          as-is. See `LXMLTreeBuilderForXML` and
          `HTMLParserTreeBuilder` for implementations that take into
          account the quirks of particular parsers.
+
+        :meta private:
+
         """
         yield markup, None, None, False
=20
-    def test_fragment_to_document(self, fragment):
+    def test_fragment_to_document(self, fragment: str) -> str:
         """Wrap an HTML fragment to make it look like a document.
=20
         Different parsers do this differently. For instance, lxml
@@ -273,26 +359,29 @@ class TreeBuilder(object):
         which run HTML fragments through the parser and compare the
         results against other HTML fragments.
=20
-        This method should not be used outside of tests.
+        This method should not be used outside of unit tests.
=20
-        :param fragment: A string -- fragment of HTML.
-        :return: A string -- a full HTML document.
+        :param fragment: A fragment of HTML.
+        :return: A full HTML document.
+        :meta private:
         """
         return fragment
=20
-    def set_up_substitutions(self, tag):
-        """Set up any substitutions that will need to be performed on=20
+    def set_up_substitutions(self, tag: Tag) -> bool:
+        """Set up any substitutions that will need to be performed on
         a `Tag` when it's output as a string.
=20
         By default, this does nothing. See `HTMLTreeBuilder` for a
         case where this is used.
=20
-        :param tag: A `Tag`
         :return: Whether or not a substitution was performed.
+        :meta private:
         """
         return False
=20
-    def _replace_cdata_list_attribute_values(self, tag_name, attrs):
+    def _replace_cdata_list_attribute_values(
+        self, tag_name: str, attrs: _RawOrProcessedAttributeValues
+    ) -> _AttributeValues:
         """When an attribute value is associated with a tag that can
         have multiple values for that attribute, convert the string
         value to a list of strings.
@@ -304,153 +393,247 @@ class TreeBuilder(object):
         :param tag_name: The name of a tag.
         :param attrs: A dictionary containing the tag's attributes.
            Any appropriate attribute values will be modified in place.
+        :return: The modified dictionary that was originally passed in.
         """
-        if not attrs:
-            return attrs
-        if self.cdata_list_attributes:
-            universal =3D self.cdata_list_attributes.get('*', [])
-            tag_specific =3D self.cdata_list_attributes.get(
-                tag_name.lower(), None)
-            for attr in list(attrs.keys()):
-                if attr in universal or (tag_specific and attr in tag_sp=
ecific):
-                    # We have a "class"-type attribute whose string
-                    # value is a whitespace-separated list of
-                    # values. Split it into a list.
-                    value =3D attrs[attr]
-                    if isinstance(value, str):
-                        values =3D nonwhitespace_re.findall(value)
-                    else:
-                        # html5lib sometimes calls setAttributes twice
-                        # for the same tag when rearranging the parse
-                        # tree. On the second call the attribute value
-                        # here is already a list.  If this happens,
-                        # leave the value alone rather than trying to
-                        # split it again.
-                        values =3D value
-                    attrs[attr] =3D values
-        return attrs
-   =20
+
+        # First, cast the attrs dict to _AttributeValues. This might
+        # not be accurate yet, but it will be by the time this method
+        # returns.
+        modified_attrs =3D cast(_AttributeValues, attrs)
+        if not modified_attrs or not self.cdata_list_attributes:
+            # Nothing to do.
+            return modified_attrs
+
+        # There is at least a possibility that we need to modify one of
+        # the attribute values.
+        universal: Set[str] =3D self.cdata_list_attributes.get("*", set(=
))
+        tag_specific =3D self.cdata_list_attributes.get(tag_name.lower()=
, None)
+        for attr in list(modified_attrs.keys()):
+            modified_value: _AttributeValue
+            if attr in universal or (tag_specific and attr in tag_specif=
ic):
+                # We have a "class"-type attribute whose string
+                # value is a whitespace-separated list of
+                # values. Split it into a list.
+                original_value: _AttributeValue =3D modified_attrs[attr]
+                if isinstance(original_value, _RawAttributeValue):
+                    # This is a _RawAttributeValue (a string) that
+                    # needs to be split and converted to a
+                    # AttributeValueList so it can be an
+                    # _AttributeValue.
+                    modified_value =3D self.attribute_value_list_class(
+                        nonwhitespace_re.findall(original_value)
+                    )
+                else:
+                    # html5lib calls setAttributes twice for the
+                    # same tag when rearranging the parse tree. On
+                    # the second call the attribute value here is
+                    # already a list. This can also happen when a
+                    # Tag object is cloned. If this happens, leave
+                    # the value alone rather than trying to split
+                    # it again.
+                    modified_value =3D original_value
+                modified_attrs[attr] =3D modified_value
+        return modified_attrs
+
+
 class SAXTreeBuilder(TreeBuilder):
     """A Beautiful Soup treebuilder that listens for SAX events.
=20
-    This is not currently used for anything, but it demonstrates
-    how a simple TreeBuilder would work.
+    This is not currently used for anything, and it will be removed
+    soon. It was a good idea, but it wasn't properly integrated into the
+    rest of Beautiful Soup, so there have been long stretches where it
+    hasn't worked properly.
     """
=20
-    def feed(self, markup):
+    def __init__(self, *args: Any, **kwargs: Any) -> None:
+        warnings.warn(
+            "The SAXTreeBuilder class was deprecated in 4.13.0 and will =
be removed soon thereafter. It is completely untested and probably doesn'=
t work; do not use it.",
+            DeprecationWarning,
+            stacklevel=3D2,
+        )
+        super(SAXTreeBuilder, self).__init__(*args, **kwargs)
+
+    def feed(self, markup: _RawMarkup) -> None:
         raise NotImplementedError()
=20
-    def close(self):
+    def close(self) -> None:
         pass
=20
-    def startElement(self, name, attrs):
-        attrs =3D dict((key[1], value) for key, value in list(attrs.item=
s()))
-        #print("Start %s, %r" % (name, attrs))
-        self.soup.handle_starttag(name, attrs)
+    def startElement(self, name: str, attrs: Dict[str, str]) -> None:
+        attrs =3D AttributeDict((key[1], value) for key, value in list(a=
ttrs.items()))
+        # print("Start %s, %r" % (name, attrs))
+        assert self.soup is not None
+        self.soup.handle_starttag(name, None, None, attrs)
=20
-    def endElement(self, name):
-        #print("End %s" % name)
+    def endElement(self, name: str) -> None:
+        # print("End %s" % name)
+        assert self.soup is not None
         self.soup.handle_endtag(name)
=20
-    def startElementNS(self, nsTuple, nodeName, attrs):
+    def startElementNS(
+        self, nsTuple: Tuple[str, str], nodeName: str, attrs: Dict[str, =
str]
+    ) -> None:
         # Throw away (ns, nodeName) for now.
         self.startElement(nodeName, attrs)
=20
-    def endElementNS(self, nsTuple, nodeName):
+    def endElementNS(self, nsTuple: Tuple[str, str], nodeName: str) -> N=
one:
         # Throw away (ns, nodeName) for now.
         self.endElement(nodeName)
-        #handler.endElementNS((ns, node.nodeName), node.nodeName)
+        # handler.endElementNS((ns, node.nodeName), node.nodeName)
=20
-    def startPrefixMapping(self, prefix, nodeValue):
+    def startPrefixMapping(self, prefix: str, nodeValue: str) -> None:
         # Ignore the prefix for now.
         pass
=20
-    def endPrefixMapping(self, prefix):
+    def endPrefixMapping(self, prefix: str) -> None:
         # Ignore the prefix for now.
         # handler.endPrefixMapping(prefix)
         pass
=20
-    def characters(self, content):
+    def characters(self, content: str) -> None:
+        assert self.soup is not None
         self.soup.handle_data(content)
=20
-    def startDocument(self):
+    def startDocument(self) -> None:
         pass
=20
-    def endDocument(self):
+    def endDocument(self) -> None:
         pass
=20
=20
 class HTMLTreeBuilder(TreeBuilder):
-    """This TreeBuilder knows facts about HTML.
-
-    Such as which tags are empty-element tags.
+    """This TreeBuilder knows facts about HTML, such as which tags are t=
reated
+    specially by the HTML standard.
     """
=20
-    empty_element_tags =3D set([
-        # These are from HTML5.
-        'area', 'base', 'br', 'col', 'embed', 'hr', 'img', 'input', 'key=
gen', 'link', 'menuitem', 'meta', 'param', 'source', 'track', 'wbr',
-       =20
-        # These are from earlier versions of HTML and are removed in HTM=
L5.
-        'basefont', 'bgsound', 'command', 'frame', 'image', 'isindex', '=
nextid', 'spacer'
-    ])
-
-    # The HTML standard defines these as block-level elements. Beautiful
-    # Soup does not treat these elements differently from other elements=
,
-    # but it may do so eventually, and this information is available if
-    # you need to use it.
-    block_elements =3D set(["address", "article", "aside", "blockquote",=
 "canvas", "dd", "div", "dl", "dt", "fieldset", "figcaption", "figure", "=
footer", "form", "h1", "h2", "h3", "h4", "h5", "h6", "header", "hr", "li"=
, "main", "nav", "noscript", "ol", "output", "p", "pre", "section", "tabl=
e", "tfoot", "ul", "video"])
-
-    # These HTML tags need special treatment so they can be
-    # represented by a string class other than NavigableString.
-    #
-    # For some of these tags, it's because the HTML standard defines
-    # an unusual content model for them. I made this list by going
-    # through the HTML spec
-    # (https://html.spec.whatwg.org/#metadata-content) and looking for
-    # "metadata content" elements that can contain strings.
-    #
-    # The Ruby tags (<rt> and <rp>) are here despite being normal
-    # "phrasing content" tags, because the content they contain is
-    # qualitatively different from other text in the document, and it
-    # can be useful to be able to distinguish it.
-    #
-    # TODO: Arguably <noscript> could go here but it seems
-    # qualitatively different from the other tags.
-    DEFAULT_STRING_CONTAINERS =3D {
-        'rt' : RubyTextString,
-        'rp' : RubyParenthesisString,
-        'style': Stylesheet,
-        'script': Script,
-        'template': TemplateString,
-    }   =20
-   =20
-    # The HTML standard defines these attributes as containing a
-    # space-separated list of values, not a single value. That is,
-    # class=3D"foo bar" means that the 'class' attribute has two values,
-    # 'foo' and 'bar', not the single value 'foo bar'.  When we
-    # encounter one of these attributes, we will parse its value into
-    # a list of values if possible. Upon output, the list will be
-    # converted back into a string.
-    DEFAULT_CDATA_LIST_ATTRIBUTES =3D {
-        "*" : ['class', 'accesskey', 'dropzone'],
-        "a" : ['rel', 'rev'],
-        "link" :  ['rel', 'rev'],
-        "td" : ["headers"],
-        "th" : ["headers"],
-        "td" : ["headers"],
-        "form" : ["accept-charset"],
-        "object" : ["archive"],
-
+    #: Some HTML tags are defined as having no contents. Beautiful Soup
+    #: treats these specially.
+    DEFAULT_EMPTY_ELEMENT_TAGS: Optional[Set[str]] =3D set(
+        [
+            # These are from HTML5.
+            "area",
+            "base",
+            "br",
+            "col",
+            "embed",
+            "hr",
+            "img",
+            "input",
+            "keygen",
+            "link",
+            "menuitem",
+            "meta",
+            "param",
+            "source",
+            "track",
+            "wbr",
+            # These are from earlier versions of HTML and are removed in=
 HTML5.
+            "basefont",
+            "bgsound",
+            "command",
+            "frame",
+            "image",
+            "isindex",
+            "nextid",
+            "spacer",
+        ]
+    )
+
+    #: The HTML standard defines these tags as block-level elements. Bea=
utiful
+    #: Soup does not treat these elements differently from other element=
s,
+    #: but it may do so eventually, and this information is available if
+    #: you need to use it.
+    DEFAULT_BLOCK_ELEMENTS: Set[str] =3D set(
+        [
+            "address",
+            "article",
+            "aside",
+            "blockquote",
+            "canvas",
+            "dd",
+            "div",
+            "dl",
+            "dt",
+            "fieldset",
+            "figcaption",
+            "figure",
+            "footer",
+            "form",
+            "h1",
+            "h2",
+            "h3",
+            "h4",
+            "h5",
+            "h6",
+            "header",
+            "hr",
+            "li",
+            "main",
+            "nav",
+            "noscript",
+            "ol",
+            "output",
+            "p",
+            "pre",
+            "section",
+            "table",
+            "tfoot",
+            "ul",
+            "video",
+        ]
+    )
+
+    #: These HTML tags need special treatment so they can be
+    #: represented by a string class other than `bs4.element.NavigableSt=
ring`.
+    #:
+    #: For some of these tags, it's because the HTML standard defines
+    #: an unusual content model for them. I made this list by going
+    #: through the HTML spec
+    #: (https://html.spec.whatwg.org/#metadata-content) and looking for
+    #: "metadata content" elements that can contain strings.
+    #:
+    #: The Ruby tags (<rt> and <rp>) are here despite being normal
+    #: "phrasing content" tags, because the content they contain is
+    #: qualitatively different from other text in the document, and it
+    #: can be useful to be able to distinguish it.
+    #:
+    #: TODO: Arguably <noscript> could go here but it seems
+    #: qualitatively different from the other tags.
+    DEFAULT_STRING_CONTAINERS: Dict[str, Type[bs4.element.NavigableStrin=
g]] =3D { # type:ignore
+        "rt": RubyTextString,
+        "rp": RubyParenthesisString,
+        "style": Stylesheet,
+        "script": Script,
+        "template": TemplateString,
+    }
+
+    #: The HTML standard defines these attributes as containing a
+    #: space-separated list of values, not a single value. That is,
+    #: class=3D"foo bar" means that the 'class' attribute has two values=
,
+    #: 'foo' and 'bar', not the single value 'foo bar'.  When we
+    #: encounter one of these attributes, we will parse its value into
+    #: a list of values if possible. Upon output, the list will be
+    #: converted back into a string.
+    DEFAULT_CDATA_LIST_ATTRIBUTES: Dict[str, Set[str]] =3D {
+        "*": {"class", "accesskey", "dropzone"},
+        "a": {"rel", "rev"},
+        "link": {"rel", "rev"},
+        "td": {"headers"},
+        "th": {"headers"},
+        "form": {"accept-charset"},
+        "object": {"archive"},
         # These are HTML5 specific, as are *.accesskey and *.dropzone ab=
ove.
-        "area" : ["rel"],
-        "icon" : ["sizes"],
-        "iframe" : ["sandbox"],
-        "output" : ["for"],
-        }
+        "area": {"rel"},
+        "icon": {"sizes"},
+        "iframe": {"sandbox"},
+        "output": {"for"},
+    }
=20
-    DEFAULT_PRESERVE_WHITESPACE_TAGS =3D set(['pre', 'textarea'])
+    #: By default, whitespace inside these HTML tags will be
+    #: preserved rather than being collapsed.
+    DEFAULT_PRESERVE_WHITESPACE_TAGS: set[str] =3D set(["pre", "textarea=
"])
=20
-    def set_up_substitutions(self, tag):
+    def set_up_substitutions(self, tag: Tag) -> bool:
         """Replace the declared encoding in a <meta> tag with a placehol=
der,
         to be substituted when the tag is output to a string.
=20
@@ -458,16 +641,25 @@ class HTMLTreeBuilder(TreeBuilder):
         encoding, but exit in a different encoding, and the <meta> tag
         needs to be changed to reflect this.
=20
-        :param tag: A `Tag`
         :return: Whether or not a substitution was performed.
+
+        :meta private:
         """
         # We are only interested in <meta> tags
-        if tag.name !=3D 'meta':
+        if tag.name !=3D "meta":
             return False
=20
-        http_equiv =3D tag.get('http-equiv')
-        content =3D tag.get('content')
-        charset =3D tag.get('charset')
+        # TODO: This cast will fail in the (very unlikely) scenario
+        # that the programmer who instantiates the TreeBuilder
+        # specifies meta['content'] or meta['charset'] as
+        # cdata_list_attributes.
+        content: Optional[str] =3D cast(Optional[str], tag.get("content"=
))
+        charset: Optional[str] =3D cast(Optional[str], tag.get("charset"=
))
+
+        # But we can accommodate meta['http-equiv'] being made a
+        # cdata_list_attribute (again, very unlikely) without much
+        # trouble.
+        http_equiv: List[str] =3D tag.get_attribute_list("http-equiv")
=20
         # We are interested in <meta> tags that say what encoding the
         # document was originally in. This means HTML 5-style <meta>
@@ -478,20 +670,23 @@ class HTMLTreeBuilder(TreeBuilder):
         # In both cases we will replace the value of the appropriate
         # attribute with a standin object that can take on any
         # encoding.
-        meta_encoding =3D None
+        substituted =3D False
         if charset is not None:
             # HTML 5 style:
             # <meta charset=3D"utf8">
-            meta_encoding =3D charset
-            tag['charset'] =3D CharsetMetaAttributeValue(charset)
+            tag["charset"] =3D CharsetMetaAttributeValue(charset)
+            substituted =3D True
=20
-        elif (content is not None and http_equiv is not None
-              and http_equiv.lower() =3D=3D 'content-type'):
+        elif content is not None and any(
+            x.lower() =3D=3D "content-type" for x in http_equiv
+        ):
             # HTML 4 style:
             # <meta http-equiv=3D"content-type" content=3D"text/html; ch=
arset=3Dutf8">
-            tag['content'] =3D ContentMetaAttributeValue(content)
+            tag["content"] =3D ContentMetaAttributeValue(content)
+            substituted =3D True
+
+        return substituted
=20
-        return (meta_encoding is not None)
=20
 class DetectsXMLParsedAsHTML(object):
     """A mixin class for any class (a TreeBuilder, or some class used by=
 a
@@ -502,66 +697,88 @@ class DetectsXMLParsedAsHTML(object):
     This requires being able to observe an incoming processing
     instruction that might be an XML declaration, and also able to
     observe tags as they're opened. If you can't do that for a given
-    TreeBuilder, there's a less reliable implementation based on
+    `TreeBuilder`, there's a less reliable implementation based on
     examining the raw markup.
     """
=20
-    # Regular expression for seeing if markup has an <html> tag.
-    LOOKS_LIKE_HTML =3D re.compile("<[^ +]html", re.I)
-    LOOKS_LIKE_HTML_B =3D re.compile(b"<[^ +]html", re.I)
+    #: Regular expression for seeing if string markup has an <html> tag.
+    LOOKS_LIKE_HTML: Pattern[str] =3D re.compile("<[^ +]html", re.I)
+
+    #: Regular expression for seeing if byte markup has an <html> tag.
+    LOOKS_LIKE_HTML_B: Pattern[bytes] =3D re.compile(b"<[^ +]html", re.I=
)
+
+    #: The start of an XML document string.
+    XML_PREFIX: str =3D "<?xml"
+
+    #: The start of an XML document bytestring.
+    XML_PREFIX_B: bytes =3D b"<?xml"
+
+    # This is typed as str, not `ProcessingInstruction`, because this
+    # check may be run before any Beautiful Soup objects are created.
+    _first_processing_instruction: Optional[str]  #: :meta private:
+    _root_tag_name: Optional[str]  #: :meta private:
=20
-    XML_PREFIX =3D '<?xml'
-    XML_PREFIX_B =3D b'<?xml'
-   =20
     @classmethod
-    def warn_if_markup_looks_like_xml(cls, markup, stacklevel=3D3):
+    def warn_if_markup_looks_like_xml(
+        cls, markup: Optional[_RawMarkup], stacklevel: int =3D 3
+    ) -> bool:
         """Perform a check on some markup to see if it looks like XML
         that's not XHTML. If so, issue a warning.
=20
         This is much less reliable than doing the check while parsing,
         but some of the tree builders can't do that.
=20
-        :param stacklevel: The stacklevel of the code calling this
-        function.
+        :param stacklevel: The stacklevel of the code calling this\
+         function.
=20
         :return: True if the markup looks like non-XHTML XML, False
-        otherwise.
-
+         otherwise.
         """
+        if markup is None:
+            return False
+        markup =3D markup[:500]
         if isinstance(markup, bytes):
-            prefix =3D cls.XML_PREFIX_B
-            looks_like_html =3D cls.LOOKS_LIKE_HTML_B
+            markup_b: bytes =3D markup
+            looks_like_xml =3D markup_b.startswith(
+                cls.XML_PREFIX_B
+            ) and not cls.LOOKS_LIKE_HTML_B.search(markup)
         else:
-            prefix =3D cls.XML_PREFIX
-            looks_like_html =3D cls.LOOKS_LIKE_HTML
-       =20
-        if (markup is not None
-            and markup.startswith(prefix)
-            and not looks_like_html.search(markup[:500])
-        ):
-            cls._warn(stacklevel=3Dstacklevel+2)
+            markup_s: str =3D markup
+            looks_like_xml =3D markup_s.startswith(
+                cls.XML_PREFIX
+            ) and not cls.LOOKS_LIKE_HTML.search(markup)
+
+        if looks_like_xml:
+            cls._warn(stacklevel=3Dstacklevel + 2)
             return True
         return False
=20
     @classmethod
-    def _warn(cls, stacklevel=3D5):
+    def _warn(cls, stacklevel: int =3D 5) -> None:
         """Issue a warning about XML being parsed as HTML."""
         warnings.warn(
-            XMLParsedAsHTMLWarning.MESSAGE, XMLParsedAsHTMLWarning,
-            stacklevel=3Dstacklevel
+            XMLParsedAsHTMLWarning.MESSAGE,
+            XMLParsedAsHTMLWarning,
+            stacklevel=3Dstacklevel,
         )
-       =20
-    def _initialize_xml_detector(self):
+
+    def _initialize_xml_detector(self) -> None:
         """Call this method before parsing a document."""
         self._first_processing_instruction =3D None
-        self._root_tag =3D None
-      =20
-    def _document_might_be_xml(self, processing_instruction):
+        self._root_tag_name =3D None
+
+    def _document_might_be_xml(self, processing_instruction: str) -> Non=
e:
         """Call this method when encountering an XML declaration, or a
         "processing instruction" that might be an XML declaration.
+
+        This helps Beautiful Soup detect potential issues later, if
+        the XML document turns out to be a non-XHTML document that's
+        being parsed as XML.
         """
-        if (self._first_processing_instruction is not None
-            or self._root_tag is not None):
+        if (
+            self._first_processing_instruction is not None
+            or self._root_tag_name is not None
+        ):
             # The document has already started. Don't bother checking
             # anymore.
             return
@@ -570,28 +787,32 @@ class DetectsXMLParsedAsHTML(object):
=20
         # We won't know until we encounter the first tag whether or
         # not this is actually a problem.
-       =20
-    def _root_tag_encountered(self, name):
+
+    def _root_tag_encountered(self, name: str) -> None:
         """Call this when you encounter the document's root tag.
=20
         This is where we actually check whether an XML document is
         being incorrectly parsed as HTML, and issue the warning.
         """
-        if self._root_tag is not None:
+        if self._root_tag_name is not None:
             # This method was incorrectly called multiple times. Do
             # nothing.
             return
=20
-        self._root_tag =3D name
-        if (name !=3D 'html' and self._first_processing_instruction is n=
ot None
-            and self._first_processing_instruction.lower().startswith('x=
ml ')):
+        self._root_tag_name =3D name
+
+        if (
+            name !=3D "html"
+            and self._first_processing_instruction is not None
+            and self._first_processing_instruction.lower().startswith("x=
ml ")
+        ):
             # We encountered an XML declaration and then a tag other
             # than 'html'. This is a reliable indicator that a
             # non-XHTML document is being parsed as XML.
-            self._warn()
+            self._warn(stacklevel=3D10)
+
=20
-   =20
-def register_treebuilders_from(module):
+def register_treebuilders_from(module: ModuleType) -> None:
     """Copy TreeBuilders from the given module into this module."""
     this_module =3D sys.modules[__name__]
     for name in module.__all__:
@@ -603,33 +824,24 @@ def register_treebuilders_from(module):
             # Register the builder while we're at it.
             this_module.builder_registry.register(obj)
=20
-class ParserRejectedMarkup(Exception):
-    """An Exception to be raised when the underlying parser simply
-    refuses to parse the given markup.
-    """
-    def __init__(self, message_or_exception):
-        """Explain why the parser rejected the given markup, either
-        with a textual explanation or another exception.
-        """
-        if isinstance(message_or_exception, Exception):
-            e =3D message_or_exception
-            message_or_exception =3D "%s: %s" % (e.__class__.__name__, s=
tr(e))
-        super(ParserRejectedMarkup, self).__init__(message_or_exception)
-           =20
+
 # Builders are registered in reverse order of priority, so that custom
 # builder registrations will take precedence. In general, we want lxml
 # to take precedence over html5lib, because it's faster. And we only
 # want to use HTMLParser as a last resort.
-from . import _htmlparser
+from . import _htmlparser # noqa: E402
+
 register_treebuilders_from(_htmlparser)
 try:
     from . import _html5lib
+
     register_treebuilders_from(_html5lib)
 except ImportError:
     # They don't have html5lib installed.
     pass
 try:
     from . import _lxml
+
     register_treebuilders_from(_lxml)
 except ImportError:
     # They don't have lxml installed.
diff --git a/lib/bb/_vendor/bs4/builder/_html5lib.py b/lib/bb/_vendor/bs4=
/builder/_html5lib.py
index 8ca19fec6..62d4d11f2 100644
--- a/lib/bb/_vendor/bs4/builder/_html5lib.py
+++ b/lib/bb/_vendor/bs4/builder/_html5lib.py
@@ -2,316 +2,395 @@
 __license__ =3D "MIT"
=20
 __all__ =3D [
-    'HTML5TreeBuilder',
-    ]
+    "HTML5TreeBuilder",
+]
+
+from typing import (
+    Any,
+    cast,
+    Dict,
+    Iterable,
+    Optional,
+    Sequence,
+    TYPE_CHECKING,
+    Tuple,
+    Union,
+)
+from typing_extensions import TypeAlias
+from bb._vendor.bs4._typing import (
+    _AttributeValue,
+    _AttributeValues,
+    _Encoding,
+    _Encodings,
+    _NamespaceURL,
+    _RawMarkup,
+)
=20
 import warnings
-import re
-from . import (
+from bb._vendor.bs4.builder import (
     DetectsXMLParsedAsHTML,
     PERMISSIVE,
     HTML,
     HTML_5,
     HTMLTreeBuilder,
-    )
-from ..element import (
+)
+from bb._vendor.bs4.element import (
     NamespacedAttribute,
+    PageElement,
     nonwhitespace_re,
 )
 import html5lib
 from html5lib.constants import (
     namespaces,
-    prefixes,
-    )
-from ..element import (
+)
+from bb._vendor.bs4.element import (
     Comment,
     Doctype,
     NavigableString,
     Tag,
-    )
+)
+
+if TYPE_CHECKING:
+    from bb._vendor.bs4 import BeautifulSoup
+
+from html5lib.treebuilders import base as treebuilder_base
=20
-try:
-    # Pre-0.99999999
-    from html5lib.treebuilders import _base as treebuilder_base
-    new_html5lib =3D False
-except ImportError as e:
-    # 0.99999999 and up
-    from html5lib.treebuilders import base as treebuilder_base
-    new_html5lib =3D True
=20
 class HTML5TreeBuilder(HTMLTreeBuilder):
-    """Use html5lib to build a tree.
+    """Use `html5lib <https://github.com/html5lib/html5lib-python>`_ to
+    build a tree.
=20
-    Note that this TreeBuilder does not support some features common
-    to HTML TreeBuilders. Some of these features could theoretically
+    Note that `HTML5TreeBuilder` does not support some common HTML
+    `TreeBuilder` features. Some of these features could theoretically
     be implemented, but at the very least it's quite difficult,
     because html5lib moves the parse tree around as it's being built.
=20
-    * This TreeBuilder doesn't use different subclasses of NavigableStri=
ng
-      based on the name of the tag in which the string was found.
+    Specifically:
=20
-    * You can't use a SoupStrainer to parse only part of a document.
+    * This `TreeBuilder` doesn't use different subclasses of
+      `NavigableString` (e.g. `Script`) based on the name of the tag
+      in which the string was found.
+    * You can't use a `SoupStrainer` to parse only part of a document.
     """
=20
-    NAME =3D "html5lib"
+    NAME: str =3D "html5lib"
+
+    features: Iterable[str] =3D [NAME, PERMISSIVE, HTML_5, HTML]
+
+    #: html5lib can tell us which line number and position in the
+    #: original file is the source of an element.
+    TRACKS_LINE_NUMBERS: bool =3D True
=20
-    features =3D [NAME, PERMISSIVE, HTML_5, HTML]
+    underlying_builder: "TreeBuilderForHtml5lib"  #: :meta private:
+    user_specified_encoding: Optional[_Encoding]
=20
-    # html5lib can tell us which line number and position in the
-    # original file is the source of an element.
-    TRACKS_LINE_NUMBERS =3D True
-   =20
-    def prepare_markup(self, markup, user_specified_encoding,
-                       document_declared_encoding=3DNone, exclude_encodi=
ngs=3DNone):
+    def prepare_markup(
+        self,
+        markup: _RawMarkup,
+        user_specified_encoding: Optional[_Encoding] =3D None,
+        document_declared_encoding: Optional[_Encoding] =3D None,
+        exclude_encodings: Optional[_Encodings] =3D None,
+    ) -> Iterable[Tuple[_RawMarkup, Optional[_Encoding], Optional[_Encod=
ing], bool]]:
         # Store the user-specified encoding for use later on.
         self.user_specified_encoding =3D user_specified_encoding
=20
         # document_declared_encoding and exclude_encodings aren't used
         # ATM because the html5lib TreeBuilder doesn't use
         # UnicodeDammit.
-        if exclude_encodings:
-            warnings.warn(
-                "You provided a value for exclude_encoding, but the html=
5lib tree builder doesn't support exclude_encoding.",
-                stacklevel=3D3
-            )
+        for variable, name in (
+            (document_declared_encoding, "document_declared_encoding"),
+            (exclude_encodings, "exclude_encodings"),
+        ):
+            if variable:
+                warnings.warn(
+                    f"You provided a value for {name}, but the html5lib =
tree builder doesn't support {name}.",
+                    stacklevel=3D3,
+                )
=20
         # html5lib only parses HTML, so if it's given XML that's worth
         # noting.
-        DetectsXMLParsedAsHTML.warn_if_markup_looks_like_xml(
-            markup, stacklevel=3D3
-        )
+        DetectsXMLParsedAsHTML.warn_if_markup_looks_like_xml(markup, sta=
cklevel=3D3)
=20
         yield (markup, None, None, False)
=20
     # These methods are defined by Beautiful Soup.
-    def feed(self, markup):
-        if self.soup.parse_only is not None:
+    def feed(self, markup: _RawMarkup) -> None:
+        """Run some incoming markup through some parsing process,
+        populating the `BeautifulSoup` object in `HTML5TreeBuilder.soup`.
+        """
+        if self.soup is not None and self.soup.parse_only is not None:
             warnings.warn(
                 "You provided a value for parse_only, but the html5lib t=
ree builder doesn't support parse_only. The entire document will be parse=
d.",
-                stacklevel=3D4
+                stacklevel=3D4,
             )
+
+        # self.underlying_builder is probably None now, but it'll be set
+        # when html5lib calls self.create_treebuilder().
         parser =3D html5lib.HTMLParser(tree=3Dself.create_treebuilder)
+        assert self.underlying_builder is not None
         self.underlying_builder.parser =3D parser
         extra_kwargs =3D dict()
         if not isinstance(markup, str):
-            if new_html5lib:
-                extra_kwargs['override_encoding'] =3D self.user_specifie=
d_encoding
-            else:
-                extra_kwargs['encoding'] =3D self.user_specified_encodin=
g
-        doc =3D parser.parse(markup, **extra_kwargs)
-       =20
+            # kwargs, specifically override_encoding, will eventually
+            # be passed in to html5lib's
+            # HTMLBinaryInputStream.__init__.
+            extra_kwargs["override_encoding"] =3D self.user_specified_en=
coding
+
+        doc =3D parser.parse(markup, **extra_kwargs) # type:ignore
+
         # Set the character encoding detected by the tokenizer.
         if isinstance(markup, str):
             # We need to special-case this because html5lib sets
             # charEncoding to UTF-8 if it gets Unicode input.
             doc.original_encoding =3D None
         else:
-            original_encoding =3D parser.tokenizer.stream.charEncoding[0=
]
-            if not isinstance(original_encoding, str):
-                # In 0.99999999 and up, the encoding is an html5lib
-                # Encoding object. We want to use a string for compatibi=
lity
-                # with other tree builders.
-                original_encoding =3D original_encoding.name
+            original_encoding =3D parser.tokenizer.stream.charEncoding[0=
] # type:ignore
+            # The encoding is an html5lib Encoding object. We want to
+            # use a string for compatibility with other tree builders.
+            original_encoding =3D original_encoding.name
             doc.original_encoding =3D original_encoding
         self.underlying_builder.parser =3D None
-           =20
-    def create_treebuilder(self, namespaceHTMLElements):
+
+    def create_treebuilder(
+        self, namespaceHTMLElements: bool
+    ) -> "TreeBuilderForHtml5lib":
+        """Called by html5lib to instantiate the kind of class it
+        calls a 'TreeBuilder'.
+
+        :param namespaceHTMLElements: Whether or not to namespace HTML e=
lements.
+
+        :meta private:
+        """
         self.underlying_builder =3D TreeBuilderForHtml5lib(
-            namespaceHTMLElements, self.soup,
-            store_line_numbers=3Dself.store_line_numbers
+            namespaceHTMLElements, self.soup, store_line_numbers=3Dself.=
store_line_numbers
         )
         return self.underlying_builder
=20
-    def test_fragment_to_document(self, fragment):
+    def test_fragment_to_document(self, fragment: str) -> str:
         """See `TreeBuilder`."""
-        return '<html><head></head><body>%s</body></html>' % fragment
+        return "<html><head></head><body>%s</body></html>" % fragment
=20
=20
 class TreeBuilderForHtml5lib(treebuilder_base.TreeBuilder):
-   =20
-    def __init__(self, namespaceHTMLElements, soup=3DNone,
-                 store_line_numbers=3DTrue, **kwargs):
+    soup: "BeautifulSoup"  #: :meta private:
+    parser: Optional[html5lib.HTMLParser]  #: :meta private:
+
+    def __init__(
+        self,
+        namespaceHTMLElements: bool,
+        soup: Optional["BeautifulSoup"] =3D None,
+        store_line_numbers: bool =3D True,
+        **kwargs: Any,
+    ):
         if soup:
             self.soup =3D soup
         else:
-            from .. import BeautifulSoup
-            # TODO: Why is the parser 'html.parser' here? To avoid an
-            # infinite loop?
+            warnings.warn(
+                "The optionality of the 'soup' argument to the TreeBuild=
erForHtml5lib constructor is deprecated as of Beautiful Soup 4.13.0: 'sou=
p' is now required. If you can't pass in a BeautifulSoup object here, or =
you get this warning and it seems mysterious to you, please contact the B=
eautiful Soup developer team for possible un-deprecation.",
+                DeprecationWarning,
+                stacklevel=3D2,
+            )
+            from bb._vendor.bs4 import BeautifulSoup
+
+            # TODO: Why is the parser 'html.parser' here? Using
+            # html5lib doesn't cause an infinite loop and is more
+            # accurate. Best to get rid of this entire section, I think.
             self.soup =3D BeautifulSoup(
-                "", "html.parser", store_line_numbers=3Dstore_line_numbe=
rs,
-                **kwargs
+                "", "html.parser", store_line_numbers=3Dstore_line_numbe=
rs, **kwargs
             )
         # TODO: What are **kwargs exactly? Should they be passed in
         # here in addition to/instead of being passed to the BeautifulSo=
up
         # constructor?
         super(TreeBuilderForHtml5lib, self).__init__(namespaceHTMLElemen=
ts)
=20
-        # This will be set later to an html5lib.html5parser.HTMLParser
-        # object, which we can use to track the current line number.
+        # This will be set later to a real html5lib HTMLParser object,
+        # which we can use to track the current line number.
         self.parser =3D None
         self.store_line_numbers =3D store_line_numbers
-       =20
-    def documentClass(self):
+
+    def documentClass(self) -> "Element":
         self.soup.reset()
         return Element(self.soup, self.soup, None)
=20
-    def insertDoctype(self, token):
-        name =3D token["name"]
-        publicId =3D token["publicId"]
-        systemId =3D token["systemId"]
+    def insertDoctype(self, token: Dict[str, Any]) -> None:
+        name: str =3D cast(str, token["name"])
+        publicId: Optional[str] =3D cast(Optional[str], token["publicId"=
])
+        systemId: Optional[str] =3D cast(Optional[str], token["systemId"=
])
=20
         doctype =3D Doctype.for_name_and_ids(name, publicId, systemId)
         self.soup.object_was_parsed(doctype)
=20
-    def elementClass(self, name, namespace):
-        kwargs =3D {}
-        if self.parser and self.store_line_numbers:
+    def elementClass(self, name: str, namespace: str) -> "Element":
+        sourceline: Optional[int] =3D None
+        sourcepos: Optional[int] =3D None
+        if self.parser is not None and self.store_line_numbers:
             # This represents the point immediately after the end of the
             # tag. We don't know when the tag started, but we do know
             # where it ended -- the character just before this one.
-            sourceline, sourcepos =3D self.parser.tokenizer.stream.posit=
ion()
-            kwargs['sourceline'] =3D sourceline
-            kwargs['sourcepos'] =3D sourcepos-1
-        tag =3D self.soup.new_tag(name, namespace, **kwargs)
+            sourceline, sourcepos =3D self.parser.tokenizer.stream.posit=
ion() # type:ignore
+            assert sourcepos is not None
+            sourcepos =3D sourcepos - 1
+        tag =3D self.soup.new_tag(
+            name, namespace, sourceline=3Dsourceline, sourcepos=3Dsource=
pos
+        )
=20
         return Element(tag, self.soup, namespace)
=20
-    def commentClass(self, data):
+    def commentClass(self, data: str) -> "TextNode":
         return TextNode(Comment(data), self.soup)
=20
-    def fragmentClass(self):
-        from .. import BeautifulSoup
-        # TODO: Why is the parser 'html.parser' here? To avoid an
-        # infinite loop?
-        self.soup =3D BeautifulSoup("", "html.parser")
-        self.soup.name =3D "[document_fragment]"
-        return Element(self.soup, self.soup, None)
-
-    def appendChild(self, node):
-        # XXX This code is not covered by the BS4 tests.
+    def fragmentClass(self) -> "Element":
+        """This is only used by html5lib HTMLParser.parseFragment(),
+        which is never used by Beautiful Soup, only by the html5lib
+        unit tests. Since we don't currently hook into those tests,
+        the implementation is left blank.
+        """
+        raise NotImplementedError()
+
+    def getFragment(self) -> "Element":
+        """This is only used by the html5lib unit tests. Since we
+        don't currently hook into those tests, the implementation is
+        left blank.
+        """
+        raise NotImplementedError()
+
+    def appendChild(self, node: "Element") -> None:
+        # TODO: This code is not covered by the BS4 tests, and
+        # apparently not triggered by the html5lib test suite either.
+        # But it doesn't seem test-specific and there are calls to it
+        # (or a method with the same name) all over html5lib, so I'm
+        # leaving the implementation in place rather than replacing it
+        # with NotImplementedError()
         self.soup.append(node.element)
=20
-    def getDocument(self):
+    def getDocument(self) -> "BeautifulSoup":
         return self.soup
=20
-    def getFragment(self):
-        return treebuilder_base.TreeBuilder.getFragment(self).element
-
-    def testSerializer(self, element):
-        from .. import BeautifulSoup
-        rv =3D []
-        doctype_re =3D re.compile(r'^(.*?)(?: PUBLIC "(.*?)"(?: "(.*?)")=
?| SYSTEM "(.*?)")?$')
-
-        def serializeElement(element, indent=3D0):
-            if isinstance(element, BeautifulSoup):
-                pass
-            if isinstance(element, Doctype):
-                m =3D doctype_re.match(element)
-                if m:
-                    name =3D m.group(1)
-                    if m.lastindex > 1:
-                        publicId =3D m.group(2) or ""
-                        systemId =3D m.group(3) or m.group(4) or ""
-                        rv.append("""|%s<!DOCTYPE %s "%s" "%s">""" %
-                                  (' ' * indent, name, publicId, systemI=
d))
-                    else:
-                        rv.append("|%s<!DOCTYPE %s>" % (' ' * indent, na=
me))
-                else:
-                    rv.append("|%s<!DOCTYPE >" % (' ' * indent,))
-            elif isinstance(element, Comment):
-                rv.append("|%s<!-- %s -->" % (' ' * indent, element))
-            elif isinstance(element, NavigableString):
-                rv.append("|%s\"%s\"" % (' ' * indent, element))
-            else:
-                if element.namespace:
-                    name =3D "%s %s" % (prefixes[element.namespace],
-                                      element.name)
-                else:
-                    name =3D element.name
-                rv.append("|%s<%s>" % (' ' * indent, name))
-                if element.attrs:
-                    attributes =3D []
-                    for name, value in list(element.attrs.items()):
-                        if isinstance(name, NamespacedAttribute):
-                            name =3D "%s %s" % (prefixes[name.namespace]=
, name.name)
-                        if isinstance(value, list):
-                            value =3D " ".join(value)
-                        attributes.append((name, value))
-
-                    for name, value in sorted(attributes):
-                        rv.append('|%s%s=3D"%s"' % (' ' * (indent + 2), =
name, value))
-                indent +=3D 2
-                for child in element.children:
-                    serializeElement(child, indent)
-        serializeElement(element, 0)
-
-        return "\n".join(rv)
+    def testSerializer(self, node: "Element") -> None:
+        """This is only used by the html5lib unit tests. Since we
+        don't currently hook into those tests, the implementation is
+        left blank.
+        """
+        raise NotImplementedError()
+
=20
 class AttrList(object):
-    def __init__(self, element):
+    """Represents a Tag's attributes in a way compatible with html5lib."=
""
+
+    element: Tag
+    attrs: _AttributeValues
+
+    def __init__(self, element: Tag):
         self.element =3D element
         self.attrs =3D dict(self.element.attrs)
-    def __iter__(self):
+
+    def __iter__(self) -> Iterable[Tuple[str, _AttributeValue]]:
         return list(self.attrs.items()).__iter__()
-    def __setitem__(self, name, value):
+
+    def __setitem__(self, name: str, value: _AttributeValue) -> None:
         # If this attribute is a multi-valued attribute for this element=
,
         # turn its value into a list.
         list_attr =3D self.element.cdata_list_attributes or {}
-        if (name in list_attr.get('*', [])
-            or (self.element.name in list_attr
-                and name in list_attr.get(self.element.name, []))):
+        if name in list_attr.get("*", []) or (
+            self.element.name in list_attr
+            and name in list_attr.get(self.element.name, [])
+        ):
             # A node that is being cloned may have already undergone
-            # this procedure.
+            # this procedure. Check for this and skip it.
             if not isinstance(value, list):
-                value =3D nonwhitespace_re.findall(value)
+                assert isinstance(value, str)
+                value =3D self.element.attribute_value_list_class(
+                    nonwhitespace_re.findall(value)
+                )
         self.element[name] =3D value
-    def items(self):
+
+    def items(self) -> Iterable[Tuple[str, _AttributeValue]]:
         return list(self.attrs.items())
-    def keys(self):
+
+    def keys(self) -> Iterable[str]:
         return list(self.attrs.keys())
-    def __len__(self):
+
+    def __len__(self) -> int:
         return len(self.attrs)
-    def __getitem__(self, name):
+
+    def __getitem__(self, name: str) -> _AttributeValue:
         return self.attrs[name]
-    def __contains__(self, name):
+
+    def __contains__(self, name: str) -> bool:
         return name in list(self.attrs.keys())
=20
=20
-class Element(treebuilder_base.Node):
-    def __init__(self, element, soup, namespace):
-        treebuilder_base.Node.__init__(self, element.name)
-        self.element =3D element
+class BeautifulSoupNode(treebuilder_base.Node):
+    # A node can correspond to _either_ a Tag _or_ a NavigableString.
+    tag: Optional[Tag]
+    string: Optional[NavigableString]
+    soup: "BeautifulSoup"
+    namespace: Optional[_NamespaceURL]
+
+    @property
+    def element(self) -> PageElement:
+        assert self.tag is not None or self.string is not None
+        if self.tag is not None:
+            return self.tag
+        else:
+            assert self.string is not None
+            return self.string
+
+    @property
+    def nodeType(self) -> int:
+        """Return the html5lib constant corresponding to the type of
+        the underlying DOM object.
+
+        NOTE: This property is only accessed by the html5lib test
+        suite, not by Beautiful Soup proper.
+        """
+        raise NotImplementedError()
+
+    # TODO-TYPING: typeshed stubs are incorrect about this;
+    # cloneNode returns a new Node, not None.
+    def cloneNode(self) -> treebuilder_base.Node: # type:ignore
+        raise NotImplementedError()
+
+
+class Element(BeautifulSoupNode):
+    namespace: Optional[_NamespaceURL]
+
+    def __init__(
+        self, element: Tag, soup: "BeautifulSoup", namespace: Optional[_=
NamespaceURL]
+    ):
+        self.tag =3D element
+        self.string =3D None
         self.soup =3D soup
         self.namespace =3D namespace
+        treebuilder_base.Node.__init__(self, element.name)
=20
-    def appendChild(self, node):
-        string_child =3D child =3D None
-        if isinstance(node, str):
-            # Some other piece of code decided to pass in a string
-            # instead of creating a TextElement object to contain the
-            # string.
-            string_child =3D child =3D node
-        elif isinstance(node, Tag):
-            # Some other piece of code decided to pass in a Tag
-            # instead of creating an Element object to contain the
-            # Tag.
-            child =3D node
-        elif node.element.__class__ =3D=3D NavigableString:
-            string_child =3D child =3D node.element
-            node.parent =3D self
+    def appendChild(self, node: "BeautifulSoupNode") -> None:
+        string_child: Optional[NavigableString] =3D None
+        child: PageElement
+        if type(node.string) is NavigableString:
+            # We check for NavigableString *only* because we want to avo=
id
+            # joining PreformattedStrings, such as Comments, with nearby=
 strings.
+            string_child =3D child =3D node.string
         else:
             child =3D node.element
-            node.parent =3D self
+        node.parent =3D self
=20
-        if not isinstance(child, str) and child.parent is not None:
+        if (
+            child is not None
+            and child.parent is not None
+            and not isinstance(child, str)
+        ):
             node.element.extract()
=20
-        if (string_child is not None and self.element.contents
-            and self.element.contents[-1].__class__ =3D=3D NavigableStri=
ng):
+        if (
+            string_child is not None
+            and self.tag is not None and self.tag.contents
+            and type(self.tag.contents[-1]) is NavigableString
+        ):
             # We are appending a string onto another string.
             # TODO This has O(n^2) performance, for input like
             # "a</a>a</a>a</a>..."
-            old_element =3D self.element.contents[-1]
+            old_element =3D self.tag.contents[-1]
             new_element =3D self.soup.new_string(old_element + string_ch=
ild)
             old_element.replace_with(new_element)
             self.soup._most_recent_element =3D new_element
@@ -323,8 +402,8 @@ class Element(treebuilder_base.Node):
             # Tell Beautiful Soup to act as if it parsed this element
             # immediately after the parent's last descendant. (Or
             # immediately after the parent, if it has no children.)
-            if self.element.contents:
-                most_recent_element =3D self.element._last_descendant(Fa=
lse)
+            if self.tag is not None and self.tag.contents:
+                most_recent_element =3D self.tag._last_descendant(False)
             elif self.element.next_element is not None:
                 # Something from further ahead in the parse tree is
                 # being inserted into this earlier element. This is
@@ -335,66 +414,96 @@ class Element(treebuilder_base.Node):
                 most_recent_element =3D self.element
=20
             self.soup.object_was_parsed(
-                child, parent=3Dself.element,
-                most_recent_element=3Dmost_recent_element)
+                child, parent=3Dself.tag, most_recent_element=3Dmost_rec=
ent_element
+            )
=20
-    def getAttributes(self):
-        if isinstance(self.element, Comment):
-            return {}
-        return AttrList(self.element)
+    def getAttributes(self) -> AttrList:
+        assert self.tag is not None
+        return AttrList(self.tag)
=20
-    def setAttributes(self, attributes):
+    # An HTML5lib attribute name may either be a single string,
+    # or a tuple (namespace, name).
+    _Html5libAttributeName: TypeAlias =3D Union[str, Tuple[str, str]]
+    # Now we can define the type this method accepts as a dictionary
+    # mapping those attribute names to single string values.
+    _Html5libAttributes: TypeAlias =3D Dict[_Html5libAttributeName, str]
+
+    def setAttributes(self, attributes: Optional[_Html5libAttributes]) -=
> None:
+        assert self.tag is not None
         if attributes is not None and len(attributes) > 0:
-            converted_attributes =3D []
+            # Replace any namespaced attributes with
+            # NamespacedAttribute objects.
             for name, value in list(attributes.items()):
                 if isinstance(name, tuple):
                     new_name =3D NamespacedAttribute(*name)
                     del attributes[name]
                     attributes[new_name] =3D value
=20
+            # We can now cast attributes to the type of Dict
+            # used by Beautiful Soup.
+            normalized_attributes =3D cast(_AttributeValues, attributes)
+
+            # Values for tags like 'class' came in as single strings;
+            # replace them with lists of strings as appropriate.
             self.soup.builder._replace_cdata_list_attribute_values(
-                self.name, attributes)
-            for name, value in list(attributes.items()):
-                self.element[name] =3D value
+                self.name, normalized_attributes
+            )
+
+            # Then set the attributes on the Tag associated with this
+            # BeautifulSoupNode.
+            for name, value_or_values in list(normalized_attributes.item=
s()):
+                self.tag[name] =3D value_or_values
=20
             # The attributes may contain variables that need substitutio=
n.
             # Call set_up_substitutions manually.
             #
             # The Tag constructor called this method when the Tag was cr=
eated,
             # but we just set/changed the attributes, so call it again.
-            self.soup.builder.set_up_substitutions(self.element)
+            self.soup.builder.set_up_substitutions(self.tag)
+
     attributes =3D property(getAttributes, setAttributes)
=20
-    def insertText(self, data, insertBefore=3DNone):
+    def insertText(
+        self, data: str, insertBefore: Optional["BeautifulSoupNode"] =3D=
 None
+    ) -> None:
         text =3D TextNode(self.soup.new_string(data), self.soup)
         if insertBefore:
             self.insertBefore(text, insertBefore)
         else:
             self.appendChild(text)
=20
-    def insertBefore(self, node, refNode):
-        index =3D self.element.index(refNode.element)
-        if (node.element.__class__ =3D=3D NavigableString and self.eleme=
nt.contents
-            and self.element.contents[index-1].__class__ =3D=3D Navigabl=
eString):
+    def insertBefore(
+        self, node: "BeautifulSoupNode", refNode: "BeautifulSoupNode"
+    ) -> None:
+        assert self.tag is not None
+        index =3D self.tag.index(refNode.element)
+        if (
+            type(node.element) is NavigableString
+            and self.tag.contents
+            and type(self.tag.contents[index - 1]) is NavigableString
+        ):
             # (See comments in appendChild)
-            old_node =3D self.element.contents[index-1]
+            old_node =3D self.tag.contents[index - 1]
+            assert type(old_node) is NavigableString
             new_str =3D self.soup.new_string(old_node + node.element)
             old_node.replace_with(new_str)
         else:
-            self.element.insert(index, node.element)
+            self.tag.insert(index, node.element)
             node.parent =3D self
=20
-    def removeChild(self, node):
+    def removeChild(self, node: "Element") -> None:
         node.element.extract()
=20
-    def reparentChildren(self, new_parent):
+    def reparentChildren(self, newParent: "Element") -> None:
         """Move all of this tag's children into another tag."""
         # print("MOVE", self.element.contents)
         # print("FROM", self.element)
         # print("TO", new_parent.element)
=20
-        element =3D self.element
-        new_parent_element =3D new_parent.element
+        element =3D self.tag
+        assert element is not None
+        new_parent_element =3D newParent.tag
+        assert new_parent_element is not None
         # Determine what this tag's next_element will be once all the ch=
ildren
         # are removed.
         final_next_element =3D element.next_sibling
@@ -403,8 +512,14 @@ class Element(treebuilder_base.Node):
         if len(new_parent_element.contents) > 0:
             # The new parent already contains children. We will be
             # appending this tag's children to the end.
+
+            # We can make this assertion since we know new_parent has
+            # children.
+            assert new_parents_last_descendant is not None
             new_parents_last_child =3D new_parent_element.contents[-1]
-            new_parents_last_descendant_next_element =3D new_parents_las=
t_descendant.next_element
+            new_parents_last_descendant_next_element =3D (
+                new_parents_last_descendant.next_element
+            )
         else:
             # The new parent contains no children.
             new_parents_last_child =3D None
@@ -431,14 +546,24 @@ class Element(treebuilder_base.Node):
             # parent's last descendant. It has no .next_sibling and
             # its .next_element is whatever the previous last
             # descendant had.
-            last_childs_last_descendant =3D to_append[-1]._last_descenda=
nt(False, True)
+            last_childs_last_descendant =3D to_append[-1]._last_descenda=
nt(
+                is_initialized=3DFalse, accept_self=3DTrue
+            )
=20
-            last_childs_last_descendant.next_element =3D new_parents_las=
t_descendant_next_element
+            # Since we passed accept_self=3DTrue into _last_descendant,
+            # there's no possibility that the result is None.
+            assert last_childs_last_descendant is not None
+            last_childs_last_descendant.next_element =3D (
+                new_parents_last_descendant_next_element
+            )
             if new_parents_last_descendant_next_element is not None:
-                # TODO: This code has no test coverage and I'm not sure
-                # how to get html5lib to go through this path, but it's
-                # just the other side of the previous line.
-                new_parents_last_descendant_next_element.previous_elemen=
t =3D last_childs_last_descendant
+                # TODO-COVERAGE: This code has no test coverage and
+                # I'm not sure how to get html5lib to go through this
+                # path, but it's just the other side of the previous
+                # line.
+                new_parents_last_descendant_next_element.previous_elemen=
t =3D (
+                    last_childs_last_descendant
+                )
             last_childs_last_descendant.next_sibling =3D None
=20
         for child in to_append:
@@ -453,29 +578,34 @@ class Element(treebuilder_base.Node):
         # print("FROM", self.element)
         # print("TO", new_parent_element)
=20
-    def cloneNode(self):
-        tag =3D self.soup.new_tag(self.element.name, self.namespace)
+    # TODO-TYPING: typeshed stubs are incorrect about this;
+    # hasContent returns a boolean, not None.
+    def hasContent(self) -> bool: # type:ignore
+        return self.tag is None or len(self.tag.contents) > 0
+
+    # TODO-TYPING: typeshed stubs are incorrect about this;
+    # cloneNode returns a new Node, not None.
+    def cloneNode(self) -> treebuilder_base.Node: # type:ignore
+        assert self.tag is not None
+        tag =3D self.soup.new_tag(self.tag.name, self.namespace)
         node =3D Element(tag, self.soup, self.namespace)
-        for key,value in self.attributes:
+        for key, value in self.attributes:
             node.attributes[key] =3D value
         return node
=20
-    def hasContent(self):
-        return self.element.contents
-
-    def getNameTuple(self):
-        if self.namespace =3D=3D None:
+    def getNameTuple(self) -> Tuple[Optional[_NamespaceURL], str]:
+        if self.namespace is None:
             return namespaces["html"], self.name
         else:
             return self.namespace, self.name
=20
     nameTuple =3D property(getNameTuple)
=20
-class TextNode(Element):
-    def __init__(self, element, soup):
+
+class TextNode(BeautifulSoupNode):
+
+    def __init__(self, element: NavigableString, soup: "BeautifulSoup"):
         treebuilder_base.Node.__init__(self, None)
-        self.element =3D element
+        self.tag =3D None
+        self.string =3D element
         self.soup =3D soup
-
-    def cloneNode(self):
-        raise NotImplementedError
diff --git a/lib/bb/_vendor/bs4/builder/_htmlparser.py b/lib/bb/_vendor/b=
s4/builder/_htmlparser.py
index f55cbadf6..3e916dc77 100644
--- a/lib/bb/_vendor/bs4/builder/_htmlparser.py
+++ b/lib/bb/_vendor/bs4/builder/_htmlparser.py
@@ -1,50 +1,76 @@
 # encoding: utf-8
 """Use the HTMLParser library to parse HTML files that aren't too bad.""=
"
+from __future__ import annotations
=20
 # Use of this source code is governed by the MIT license.
 __license__ =3D "MIT"
=20
 __all__ =3D [
-    'HTMLParserTreeBuilder',
-    ]
+    "HTMLParserTreeBuilder",
+]
=20
 from html.parser import HTMLParser
-
-import sys
-import warnings
-
-from ..element import (
+import re
+
+from typing import (
+    Any,
+    Callable,
+    cast,
+    Dict,
+    Iterable,
+    List,
+    Optional,
+    TYPE_CHECKING,
+    Tuple,
+    Type,
+    Union,
+)
+
+from bb._vendor.bs4.element import (
+    AttributeDict,
     CData,
     Comment,
     Declaration,
     Doctype,
     ProcessingInstruction,
-    )
-from ..dammit import EntitySubstitution, UnicodeDammit
+)
+from bb._vendor.bs4.dammit import EntitySubstitution, UnicodeDammit
=20
-from . import (
+from bb._vendor.bs4.builder import (
     DetectsXMLParsedAsHTML,
-    ParserRejectedMarkup,
     HTML,
     HTMLTreeBuilder,
     STRICT,
+)
+
+from bb._vendor.bs4.exceptions import ParserRejectedMarkup
+
+if TYPE_CHECKING:
+    from bb._vendor.bs4 import BeautifulSoup
+    from bb._vendor.bs4.element import NavigableString
+    from bb._vendor.bs4._typing import (
+        _Encoding,
+        _Encodings,
+        _RawMarkup,
     )
=20
+HTMLPARSER =3D "html.parser"
+
+_DuplicateAttributeHandler =3D Callable[[Dict[str, str], str, str], None=
]
=20
-HTMLPARSER =3D 'html.parser'
=20
 class BeautifulSoupHTMLParser(HTMLParser, DetectsXMLParsedAsHTML):
+    #: Constant to handle duplicate attributes by ignoring later values
+    #: and keeping the earlier ones.
+    REPLACE: str =3D "replace"
+
+    #: Constant to handle duplicate attributes by replacing earlier valu=
es
+    #: with later ones.
+    IGNORE: str =3D "ignore"
+
     """A subclass of the Python standard library's HTMLParser class, whi=
ch
     listens for HTMLParser events and translates them into calls
     to Beautiful Soup's tree construction API.
-    """
-
-    # Strategies for handling duplicate attributes
-    IGNORE =3D 'ignore'
-    REPLACE =3D 'replace'
-   =20
-    def __init__(self, *args, **kwargs):
-        """Constructor.
=20
         :param on_duplicate_attribute: A strategy for what to do if a
             tag includes the same attribute more than once. Accepted
@@ -53,11 +79,19 @@ class BeautifulSoupHTMLParser(HTMLParser, DetectsXMLP=
arsedAsHTML):
             encountered), or a callable. A callable must take three
             arguments: the dictionary of attributes already processed,
             the name of the duplicate attribute, and the most recent val=
ue
-            encountered.          =20
-        """
-        self.on_duplicate_attribute =3D kwargs.pop(
-            'on_duplicate_attribute', self.REPLACE
-        )
+            encountered.
+    """
+
+    def __init__(
+        self,
+        soup: BeautifulSoup,
+        *args: Any,
+        on_duplicate_attribute: Union[str, _DuplicateAttributeHandler] =3D=
 REPLACE,
+        **kwargs: Any,
+    ):
+        self.soup =3D soup
+        self.on_duplicate_attribute =3D on_duplicate_attribute
+        self.attribute_dict_class =3D soup.builder.attribute_dict_class
         HTMLParser.__init__(self, *args, **kwargs)
=20
         # Keep a list of empty-element tags that were encountered
@@ -71,7 +105,11 @@ class BeautifulSoupHTMLParser(HTMLParser, DetectsXMLP=
arsedAsHTML):
=20
         self._initialize_xml_detector()
=20
-    def error(self, message):
+    on_duplicate_attribute: Union[str, _DuplicateAttributeHandler]
+    already_closed_empty_element: List[str]
+    soup: BeautifulSoup
+
+    def error(self, message: str) -> None:
         # NOTE: This method is required so long as Python 3.9 is
         # supported. The corresponding code is removed from HTMLParser
         # in 3.5, but not removed from ParserBase until 3.10.
@@ -87,37 +125,45 @@ class BeautifulSoupHTMLParser(HTMLParser, DetectsXML=
ParsedAsHTML):
         # catch this error and wrap it in a ParserRejectedMarkup.)
         raise ParserRejectedMarkup(message)
=20
-    def handle_startendtag(self, name, attrs):
+    def handle_startendtag(
+        self, tag: str, attrs: List[Tuple[str, Optional[str]]]
+    ) -> None:
         """Handle an incoming empty-element tag.
=20
-        This is only called when the markup looks like <tag/>.
-
-        :param name: Name of the tag.
-        :param attrs: Dictionary of the tag's attributes.
+        html.parser only calls this method when the markup looks like
+        <tag/>.
         """
-        # is_startend() tells handle_starttag not to close the tag
+        # `handle_empty_element` tells handle_starttag not to close the =
tag
         # just because its name matches a known empty-element tag. We
-        # know that this is an empty-element tag and we want to call
+        # know that this is an empty-element tag, and we want to call
         # handle_endtag ourselves.
-        tag =3D self.handle_starttag(name, attrs, handle_empty_element=3D=
False)
-        self.handle_endtag(name)
-       =20
-    def handle_starttag(self, name, attrs, handle_empty_element=3DTrue):
+        self.handle_starttag(tag, attrs, handle_empty_element=3DFalse)
+
+        # Similarly, we set `check_already_closed` when calling
+        # handle_endtag. Since we know the start event is identical to
+        # the end event, we don't want handle_endtag() to cross off
+        # any previous end events for tags of this name.
+        self.handle_endtag(tag, check_already_closed=3DFalse)
+
+    def handle_starttag(
+        self,
+        tag: str,
+        attrs: List[Tuple[str, Optional[str]]],
+        handle_empty_element: bool =3D True,
+    ) -> None:
         """Handle an opening tag, e.g. '<tag>'
=20
-        :param name: Name of the tag.
-        :param attrs: Dictionary of the tag's attributes.
         :param handle_empty_element: True if this tag is known to be
             an empty-element tag (i.e. there is not expected to be any
             closing tag).
         """
-        # XXX namespace
-        attr_dict =3D {}
+        # TODO: handle namespaces here?
+        attr_dict: AttributeDict =3D self.attribute_dict_class()
         for key, value in attrs:
             # Change None attribute values to the empty string
             # for consistency with the other tree builders.
             if value is None:
-                value =3D ''
+                value =3D ""
             if key in attr_dict:
                 # A single attribute shows up multiple times in this
                 # tag. How to handle it depends on the
@@ -128,17 +174,21 @@ class BeautifulSoupHTMLParser(HTMLParser, DetectsXM=
LParsedAsHTML):
                 elif on_dupe in (None, self.REPLACE):
                     attr_dict[key] =3D value
                 else:
+                    on_dupe =3D cast(_DuplicateAttributeHandler, on_dupe=
)
                     on_dupe(attr_dict, key, value)
             else:
                 attr_dict[key] =3D value
-            attrvalue =3D '""'
-        #print("START", name)
-        sourceline, sourcepos =3D self.getpos()
-        tag =3D self.soup.handle_starttag(
-            name, None, None, attr_dict, sourceline=3Dsourceline,
-            sourcepos=3Dsourcepos
+        # print("START", tag)
+        sourceline: Optional[int]
+        sourcepos: Optional[int]
+        if self.soup.builder.store_line_numbers:
+            sourceline, sourcepos =3D self.getpos()
+        else:
+            sourceline =3D sourcepos =3D None
+        tagObj =3D self.soup.handle_starttag(
+            tag, None, None, attr_dict, sourceline=3Dsourceline, sourcep=
os=3Dsourcepos
         )
-        if tag and tag.is_empty_element and handle_empty_element:
+        if tagObj is not None and tagObj.is_empty_element and handle_emp=
ty_element:
             # Unlike other parsers, html.parser doesn't send separate en=
d tag
             # events for empty-element tags. (It's handled in
             # handle_startendtag, but only if the original markup looked=
 like
@@ -148,78 +198,111 @@ class BeautifulSoupHTMLParser(HTMLParser, DetectsX=
MLParsedAsHTML):
             # know the start event is identical to the end event, we
             # don't want handle_endtag() to cross off any previous end
             # events for tags of this name.
-            self.handle_endtag(name, check_already_closed=3DFalse)
+            self.handle_endtag(tag, check_already_closed=3DFalse)
=20
             # But we might encounter an explicit closing tag for this ta=
g
             # later on. If so, we want to ignore it.
-            self.already_closed_empty_element.append(name)
+            self.already_closed_empty_element.append(tag)
+
+        if self._root_tag_name is None:
+            self._root_tag_encountered(tag)
=20
-        if self._root_tag is None:
-            self._root_tag_encountered(name)
-           =20
-    def handle_endtag(self, name, check_already_closed=3DTrue):
+    def handle_endtag(self, tag: str, check_already_closed: bool =3D Tru=
e) -> None:
         """Handle a closing tag, e.g. '</tag>'
-       =20
-        :param name: A tag name.
+
+        :param tag: A tag name.
         :param check_already_closed: True if this tag is expected to
            be the closing portion of an empty-element tag,
            e.g. '<tag></tag>'.
         """
-        #print("END", name)
-        if check_already_closed and name in self.already_closed_empty_el=
ement:
+        # print("END", tag)
+        if check_already_closed and tag in self.already_closed_empty_ele=
ment:
             # This is a redundant end tag for an empty-element tag.
             # We've already called handle_endtag() for it, so just
             # check it off the list.
-            #print("ALREADY CLOSED", name)
-            self.already_closed_empty_element.remove(name)
+            # print("ALREADY CLOSED", tag)
+            self.already_closed_empty_element.remove(tag)
         else:
-            self.soup.handle_endtag(name)
-           =20
-    def handle_data(self, data):
+            self.soup.handle_endtag(tag)
+
+    def handle_data(self, data: str) -> None:
         """Handle some textual data that shows up between tags."""
         self.soup.handle_data(data)
=20
-    def handle_charref(self, name):
+    _DECIMAL_REFERENCE_WITH_FOLLOWING_DATA =3D re.compile("^([0-9]+)(.*)=
")
+    _HEX_REFERENCE_WITH_FOLLOWING_DATA =3D re.compile("^([0-9a-f]+)(.*)"=
)
+
+    @classmethod
+    def _dereference_numeric_character_reference(cls, name:str) -> Tuple=
[str, bool, str]:
+        """Convert a numeric character reference into an actual characte=
r.
+
+        :param name: The number of the character reference, as
+          obtained by html.parser
+
+        :return: A 3-tuple (dereferenced, replacement_added,
+          extra_data). `dereferenced` is the dereferenced character
+          reference, or the empty string if there was no
+          reference. `replacement_added` is True if the reference
+          could only be dereferenced by replacing content with U+FFFD
+          REPLACEMENT CHARACTER. `extra_data` is a portion of data
+          following the character reference, which was deemed to be
+          normal data and not part of the reference at all.
+        """
+        dereferenced:str =3D ""
+        replacement_added:bool =3D False
+        extra_data:str =3D ""
+
+        base:int =3D 10
+        reg =3D cls._DECIMAL_REFERENCE_WITH_FOLLOWING_DATA
+        if name.startswith("x") or name.startswith("X"):
+            # Hex reference
+            name =3D name[1:]
+            base =3D 16
+            reg =3D cls._HEX_REFERENCE_WITH_FOLLOWING_DATA
+
+        real_name:Optional[int] =3D None
+        try:
+            real_name =3D int(name, base)
+        except ValueError:
+            # This is either bad data that starts with what looks like
+            # a numeric character reference, or a real numeric
+            # reference that wasn't terminated by a semicolon.
+            #
+            # The fix to https://bugs.python.org/issue13633 made it
+            # our responsibility to handle the extra data.
+            #
+            # To preserve the old behavior, we extract the numeric
+            # portion of the incoming "reference" and treat that as a
+            # numeric reference. All subsequent data will be processed
+            # as string data.
+            match =3D reg.search(name)
+            if match is not None:
+                real_name =3D int(match.groups()[0], base)
+                extra_data =3D match.groups()[1]
+
+        if real_name is None:
+            dereferenced =3D ""
+            extra_data =3D name
+        else:
+            dereferenced, replacement_added =3D UnicodeDammit.numeric_ch=
aracter_reference(real_name)
+        return dereferenced, replacement_added, extra_data
+
+    def handle_charref(self, name: str) -> None:
         """Handle a numeric character reference by converting it to the
         corresponding Unicode character and treating it as textual
         data.
=20
         :param name: Character number, possibly in hexadecimal.
         """
-        # TODO: This was originally a workaround for a bug in
-        # HTMLParser. (http://bugs.python.org/issue13633) The bug has
-        # been fixed, but removing this code still makes some
-        # Beautiful Soup tests fail. This needs investigation.
-        if name.startswith('x'):
-            real_name =3D int(name.lstrip('x'), 16)
-        elif name.startswith('X'):
-            real_name =3D int(name.lstrip('X'), 16)
-        else:
-            real_name =3D int(name)
-
-        data =3D None
-        if real_name < 256:
-            # HTML numeric entities are supposed to reference Unicode
-            # code points, but sometimes they reference code points in
-            # some other encoding (ahem, Windows-1252). E.g. &#147;
-            # instead of &#201; for LEFT DOUBLE QUOTATION MARK. This
-            # code tries to detect this situation and compensate.
-            for encoding in (self.soup.original_encoding, 'windows-1252'=
):
-                if not encoding:
-                    continue
-                try:
-                    data =3D bytearray([real_name]).decode(encoding)
-                except UnicodeDecodeError as e:
-                    pass
-        if not data:
-            try:
-                data =3D chr(real_name)
-            except (ValueError, OverflowError) as e:
-                pass
-        data =3D data or "\N{REPLACEMENT CHARACTER}"
-        self.handle_data(data)
-
-    def handle_entityref(self, name):
+        dereferenced, replacement_added, extra_data =3D self._dereferenc=
e_numeric_character_reference(name)
+        if replacement_added:
+            self.soup.contains_replacement_characters =3D True
+        if dereferenced is not None:
+            self.handle_data(dereferenced)
+        if extra_data is not None:
+            self.handle_data(extra_data)
+
+    def handle_entityref(self, name: str) -> None:
         """Handle a named entity reference by converting it to the
         corresponding Unicode character(s) and treating it as textual
         data.
@@ -238,7 +321,7 @@ class BeautifulSoupHTMLParser(HTMLParser, DetectsXMLP=
arsedAsHTML):
             data =3D "&%s" % name
         self.handle_data(data)
=20
-    def handle_comment(self, data):
+    def handle_comment(self, data: str) -> None:
         """Handle an HTML comment.
=20
         :param data: The text of the comment.
@@ -247,31 +330,32 @@ class BeautifulSoupHTMLParser(HTMLParser, DetectsXM=
LParsedAsHTML):
         self.soup.handle_data(data)
         self.soup.endData(Comment)
=20
-    def handle_decl(self, data):
+    def handle_decl(self, decl: str) -> None:
         """Handle a DOCTYPE declaration.
=20
         :param data: The text of the declaration.
         """
         self.soup.endData()
-        data =3D data[len("DOCTYPE "):]
-        self.soup.handle_data(data)
+        decl =3D decl[len("DOCTYPE ") :]
+        self.soup.handle_data(decl)
         self.soup.endData(Doctype)
=20
-    def unknown_decl(self, data):
+    def unknown_decl(self, data: str) -> None:
         """Handle a declaration of unknown type -- probably a CDATA bloc=
k.
=20
         :param data: The text of the declaration.
         """
-        if data.upper().startswith('CDATA['):
+        cls: Type[NavigableString]
+        if data.upper().startswith("CDATA["):
             cls =3D CData
-            data =3D data[len('CDATA['):]
+            data =3D data[len("CDATA[") :]
         else:
             cls =3D Declaration
         self.soup.endData()
         self.soup.handle_data(data)
         self.soup.endData(cls)
=20
-    def handle_pi(self, data):
+    def handle_pi(self, data: str) -> None:
         """Handle a processing instruction.
=20
         :param data: The text of the instruction.
@@ -283,25 +367,34 @@ class BeautifulSoupHTMLParser(HTMLParser, DetectsXM=
LParsedAsHTML):
=20
=20
 class HTMLParserTreeBuilder(HTMLTreeBuilder):
-    """A Beautiful soup `TreeBuilder` that uses the `HTMLParser` parser,
-    found in the Python standard library.
-    """
-    is_xml =3D False
-    picklable =3D True
-    NAME =3D HTMLPARSER
-    features =3D [NAME, HTML, STRICT]
+    """A Beautiful soup `bs4.builder.TreeBuilder` that uses the
+    :py:class:`html.parser.HTMLParser` parser, found in the Python
+    standard library.
=20
-    # The html.parser knows which line number and position in the
-    # original file is the source of an element.
-    TRACKS_LINE_NUMBERS =3D True
+    """
=20
-    def __init__(self, parser_args=3DNone, parser_kwargs=3DNone, **kwarg=
s):
+    is_xml: bool =3D False
+    picklable: bool =3D True
+    NAME: str =3D HTMLPARSER
+    features: Iterable[str] =3D [NAME, HTML, STRICT]
+    parser_args: Tuple[Iterable[Any], Dict[str, Any]]
+
+    #: The html.parser knows which line number and position in the
+    #: original file is the source of an element.
+    TRACKS_LINE_NUMBERS: bool =3D True
+
+    def __init__(
+        self,
+        parser_args: Optional[Iterable[Any]] =3D None,
+        parser_kwargs: Optional[Dict[str, Any]] =3D None,
+        **kwargs: Any,
+    ):
         """Constructor.
=20
-        :param parser_args: Positional arguments to pass into=20
+        :param parser_args: Positional arguments to pass into
             the BeautifulSoupHTMLParser constructor, once it's
             invoked.
-        :param parser_kwargs: Keyword arguments to pass into=20
+        :param parser_kwargs: Keyword arguments to pass into
             the BeautifulSoupHTMLParser constructor, once it's
             invoked.
         :param kwargs: Keyword arguments for the superclass constructor.
@@ -309,7 +402,7 @@ class HTMLParserTreeBuilder(HTMLTreeBuilder):
         # Some keyword arguments will be pulled out of kwargs and placed
         # into parser_kwargs.
         extra_parser_kwargs =3D dict()
-        for arg in ('on_duplicate_attribute',):
+        for arg in ("on_duplicate_attribute",):
             if arg in kwargs:
                 value =3D kwargs.pop(arg)
                 extra_parser_kwargs[arg] =3D value
@@ -317,12 +410,16 @@ class HTMLParserTreeBuilder(HTMLTreeBuilder):
         parser_args =3D parser_args or []
         parser_kwargs =3D parser_kwargs or {}
         parser_kwargs.update(extra_parser_kwargs)
-        parser_kwargs['convert_charrefs'] =3D False
+        parser_kwargs["convert_charrefs"] =3D False
         self.parser_args =3D (parser_args, parser_kwargs)
-       =20
-    def prepare_markup(self, markup, user_specified_encoding=3DNone,
-                       document_declared_encoding=3DNone, exclude_encodi=
ngs=3DNone):
=20
+    def prepare_markup(
+        self,
+        markup: _RawMarkup,
+        user_specified_encoding: Optional[_Encoding] =3D None,
+        document_declared_encoding: Optional[_Encoding] =3D None,
+        exclude_encodings: Optional[_Encodings] =3D None,
+    ) -> Iterable[Tuple[str, Optional[_Encoding], Optional[_Encoding], b=
ool]]:
         """Run any preliminary steps necessary to make incoming markup
         acceptable to the parser.
=20
@@ -333,13 +430,13 @@ class HTMLParserTreeBuilder(HTMLTreeBuilder):
         :param exclude_encodings: The user asked _not_ to try any of
             these encodings.
=20
-        :yield: A series of 4-tuples:
-         (markup, encoding, declared encoding,
-          has undergone character replacement)
+        :yield: A series of 4-tuples: (markup, encoding, declared encodi=
ng,
+             has undergone character replacement)
=20
-         Each 4-tuple represents a strategy for converting the
-         document to Unicode and parsing it. Each strategy will be tried=
=20
-         in turn.
+            Each 4-tuple represents a strategy for parsing the document.
+            This TreeBuilder uses Unicode, Dammit to convert the markup
+            into Unicode, so the ``markup`` element of the tuple will
+            always be a string.
         """
         if isinstance(markup, str):
             # Parse Unicode as-is.
@@ -348,34 +445,67 @@ class HTMLParserTreeBuilder(HTMLTreeBuilder):
=20
         # Ask UnicodeDammit to sniff the most likely encoding.
=20
-        # This was provided by the end-user; treat it as a known
-        # definite encoding per the algorithm laid out in the HTML5
-        # spec.  (See the EncodingDetector class for details.)
-        known_definite_encodings =3D [user_specified_encoding]
+        known_definite_encodings: List[_Encoding] =3D []
+        if user_specified_encoding:
+            # This was provided by the end-user; treat it as a known
+            # definite encoding per the algorithm laid out in the
+            # HTML5 spec. (See the EncodingDetector class for
+            # details.)
+            known_definite_encodings.append(user_specified_encoding)
=20
-        # This was found in the document; treat it as a slightly lower-p=
riority
-        # user encoding.
-        user_encodings =3D [document_declared_encoding]
+        user_encodings: List[_Encoding] =3D []
+        if document_declared_encoding:
+            # This was found in the document; treat it as a slightly
+            # lower-priority user encoding.
+            user_encodings.append(document_declared_encoding)
=20
-        try_encodings =3D [user_specified_encoding, document_declared_en=
coding]
         dammit =3D UnicodeDammit(
             markup,
             known_definite_encodings=3Dknown_definite_encodings,
             user_encodings=3Duser_encodings,
             is_html=3DTrue,
-            exclude_encodings=3Dexclude_encodings
+            exclude_encodings=3Dexclude_encodings,
         )
-        yield (dammit.markup, dammit.original_encoding,
-               dammit.declared_html_encoding,
-               dammit.contains_replacement_characters)
=20
-    def feed(self, markup):
-        """Run some incoming markup through some parsing process,
-        populating the `BeautifulSoup` object in self.soup.
+        if dammit.unicode_markup is None:
+            # In every case I've seen, Unicode, Dammit is able to
+            # convert the markup into Unicode, even if it needs to use
+            # REPLACEMENT CHARACTER. But there is a code path that
+            # could result in unicode_markup being None, and
+            # HTMLParser can only parse Unicode, so here we handle
+            # that code path.
+            raise ParserRejectedMarkup(
+                "Could not convert input to Unicode, and html.parser wil=
l not accept bytestrings."
+            )
+        else:
+            yield (
+                dammit.unicode_markup,
+                dammit.original_encoding,
+                dammit.declared_html_encoding,
+                dammit.contains_replacement_characters,
+            )
+
+    def feed(self, markup: _RawMarkup, _parser_class:type[BeautifulSoupH=
TMLParser] =3DBeautifulSoupHTMLParser) -> None:
+        """
+        :param markup: The markup to feed into the parser.
+        :param _parser_class: An HTMLParser subclass to use. This is onl=
y intended for use in unit tests.
         """
         args, kwargs =3D self.parser_args
-        parser =3D BeautifulSoupHTMLParser(*args, **kwargs)
-        parser.soup =3D self.soup
+
+        # HTMLParser.feed will only handle str, but
+        # BeautifulSoup.markup is allowed to be _RawMarkup, because
+        # it's set by the yield value of
+        # TreeBuilder.prepare_markup. Fortunately,
+        # HTMLParserTreeBuilder.prepare_markup always yields a str
+        # (UnicodeDammit.unicode_markup).
+        assert isinstance(markup, str)
+
+        # We know BeautifulSoup calls TreeBuilder.initialize_soup
+        # before calling feed(), so we can assume self.soup
+        # is set.
+        assert self.soup is not None
+        parser =3D _parser_class(self.soup, *args, **kwargs)
+
         try:
             parser.feed(markup)
             parser.close()
diff --git a/lib/bb/_vendor/bs4/builder/_lxml.py b/lib/bb/_vendor/bs4/bui=
lder/_lxml.py
index fc80133b2..4f14bfffa 100644
--- a/lib/bb/_vendor/bs4/builder/_lxml.py
+++ b/lib/bb/_vendor/bs4/builder/_lxml.py
@@ -1,62 +1,112 @@
+# encoding: utf-8
+from __future__ import annotations
+
 # Use of this source code is governed by the MIT license.
 __license__ =3D "MIT"
=20
 __all__ =3D [
-    'LXMLTreeBuilderForXML',
-    'LXMLTreeBuilder',
-    ]
-
-try:
-    from collections.abc import Callable # Python 3.6
-except ImportError as e:
-    from collections import Callable
+    "LXMLTreeBuilderForXML",
+    "LXMLTreeBuilder",
+]
+
+
+from typing import (
+    Any,
+    Dict,
+    Iterable,
+    List,
+    Optional,
+    Set,
+    Tuple,
+    Type,
+    TYPE_CHECKING,
+    Union,
+)
=20
 from io import BytesIO
 from io import StringIO
-from lxml import etree
-from ..element import (
+
+from typing_extensions import TypeAlias
+
+from lxml import etree # type:ignore
+from bb._vendor.bs4.element import (
+    AttributeDict,
+    XMLAttributeDict,
     Comment,
     Doctype,
     NamespacedAttribute,
     ProcessingInstruction,
     XMLProcessingInstruction,
 )
-from . import (
+from bb._vendor.bs4.builder import (
     DetectsXMLParsedAsHTML,
     FAST,
     HTML,
     HTMLTreeBuilder,
     PERMISSIVE,
-    ParserRejectedMarkup,
     TreeBuilder,
-    XML)
-from ..dammit import EncodingDetector
+    XML,
+)
+from bb._vendor.bs4.dammit import EncodingDetector
+from bb._vendor.bs4.exceptions import ParserRejectedMarkup
+
+if TYPE_CHECKING:
+    from bb._vendor.bs4._typing import (
+        _Encoding,
+        _Encodings,
+        _NamespacePrefix,
+        _NamespaceURL,
+        _NamespaceMapping,
+        _InvertedNamespaceMapping,
+        _RawMarkup,
+    )
+    from bb._vendor.bs4 import BeautifulSoup
+
+LXML: str =3D "lxml"
=20
-LXML =3D 'lxml'
=20
-def _invert(d):
+def _invert(d: dict[Any, Any]) -> dict[Any, Any]:
     "Invert a dictionary."
-    return dict((v,k) for k, v in list(d.items()))
+    return dict((v, k) for k, v in list(d.items()))
+
+
+_LXMLParser: TypeAlias =3D Union[etree.XMLParser, etree.HTMLParser]
+_ParserOrParserClass: TypeAlias =3D Union[
+    _LXMLParser, Type[etree.XMLParser], Type[etree.HTMLParser]
+]
+
=20
 class LXMLTreeBuilderForXML(TreeBuilder):
-    DEFAULT_PARSER_CLASS =3D etree.XMLParser
+    DEFAULT_PARSER_CLASS: Type[etree.XMLParser] =3D etree.XMLParser
+
+    is_xml: bool =3D True
+
+    #: Set this to true (probably by passing huge_tree=3DTrue into the :
+    #: BeautifulSoup constructor) to enable the lxml feature "disable se=
curity
+    #: restrictions and support very deep trees and very long text
+    #: content".
+    huge_tree: bool
=20
-    is_xml =3D True
-    processing_instruction_class =3D XMLProcessingInstruction
+    processing_instruction_class: Type[ProcessingInstruction]
=20
-    NAME =3D "lxml-xml"
-    ALTERNATE_NAMES =3D ["xml"]
+    NAME: str =3D "lxml-xml"
+    ALTERNATE_NAMES: Iterable[str] =3D ["xml"]
=20
     # Well, it's permissive by XML parser standards.
-    features =3D [NAME, LXML, XML, FAST, PERMISSIVE]
+    features: Iterable[str] =3D [NAME, LXML, XML, FAST, PERMISSIVE]
=20
-    CHUNK_SIZE =3D 512
+    CHUNK_SIZE: int =3D 512
=20
     # This namespace mapping is specified in the XML Namespace
     # standard.
-    DEFAULT_NSMAPS =3D dict(xml=3D'http://www.w3.org/XML/1998/namespace'=
)
+    DEFAULT_NSMAPS: _NamespaceMapping =3D dict(xml=3D"http://www.w3.org/=
XML/1998/namespace")
=20
-    DEFAULT_NSMAPS_INVERTED =3D _invert(DEFAULT_NSMAPS)
+    DEFAULT_NSMAPS_INVERTED: _InvertedNamespaceMapping =3D _invert(DEFAU=
LT_NSMAPS)
+
+    nsmaps: List[Optional[_InvertedNamespaceMapping]]
+    empty_element_tags: Optional[Set[str]]
+    parser: Any
+    _default_parser: Optional[etree.XMLParser]
=20
     # NOTE: If we parsed Element objects and looked at .sourceline,
     # we'd be able to see the line numbers from the original document.
@@ -64,17 +114,19 @@ class LXMLTreeBuilderForXML(TreeBuilder):
     # as the target of parse messages, and those messages don't include
     # line numbers.
     # See: https://bugs.launchpad.net/lxml/+bug/1846906
-   =20
-    def initialize_soup(self, soup):
+
+    def initialize_soup(self, soup: BeautifulSoup) -> None:
         """Let the BeautifulSoup object know about the standard namespac=
e
         mapping.
=20
         :param soup: A `BeautifulSoup`.
         """
+        # Beyond this point, self.soup is set, so we can assume (and
+        # assert) it's not None whenever necessary.
         super(LXMLTreeBuilderForXML, self).initialize_soup(soup)
         self._register_namespaces(self.DEFAULT_NSMAPS)
=20
-    def _register_namespaces(self, mapping):
+    def _register_namespaces(self, mapping: Dict[str, str]) -> None:
         """Let the BeautifulSoup object know about namespaces encountere=
d
         while parsing the document.
=20
@@ -87,6 +139,7 @@ class LXMLTreeBuilderForXML(TreeBuilder):
=20
         :param mapping: A dictionary mapping namespace prefixes to URIs.
         """
+        assert self.soup is not None
         for key, value in list(mapping.items()):
             # This is 'if key' and not 'if key is not None' because we
             # don't track un-prefixed namespaces. Soupselect will
@@ -97,20 +150,18 @@ class LXMLTreeBuilderForXML(TreeBuilder):
                 # If there are multiple namespaces defined with the same
                 # prefix, the first one in the document takes precedence.
                 self.soup._namespaces[key] =3D value
-               =20
-    def default_parser(self, encoding):
+
+    def default_parser(self, encoding: Optional[_Encoding]) -> _ParserOr=
ParserClass:
         """Find the default parser for the given encoding.
=20
-        :param encoding: A string.
         :return: Either a parser object or a class, which
           will be instantiated with default arguments.
         """
         if self._default_parser is not None:
             return self._default_parser
-        return etree.XMLParser(
-            target=3Dself, strip_cdata=3DFalse, recover=3DTrue, encoding=
=3Dencoding)
+        return self.DEFAULT_PARSER_CLASS(target=3Dself, recover=3DTrue, =
huge_tree=3Dself.huge_tree, encoding=3Dencoding)
=20
-    def parser_for(self, encoding):
+    def parser_for(self, encoding: Optional[_Encoding]) -> _LXMLParser:
         """Instantiate an appropriate parser for the given encoding.
=20
         :param encoding: A string.
@@ -119,36 +170,53 @@ class LXMLTreeBuilderForXML(TreeBuilder):
         # Use the default parser.
         parser =3D self.default_parser(encoding)
=20
-        if isinstance(parser, Callable):
+        if callable(parser):
             # Instantiate the parser with default arguments
-            parser =3D parser(
-                target=3Dself, strip_cdata=3DFalse, recover=3DTrue, enco=
ding=3Dencoding
-            )
+            parser =3D parser(target=3Dself, recover=3DTrue, huge_tree=3D=
self.huge_tree, encoding=3Dencoding)
         return parser
=20
-    def __init__(self, parser=3DNone, empty_element_tags=3DNone, **kwarg=
s):
+    def __init__(
+            self,
+            parser: Optional[etree.XMLParser] =3D None,
+            empty_element_tags: Optional[Set[str]] =3D None,
+            huge_tree: bool =3D False,
+            **kwargs: Any,
+    ):
         # TODO: Issue a warning if parser is present but not a
         # callable, since that means there's no way to create new
         # parsers for different encodings.
         self._default_parser =3D parser
-        if empty_element_tags is not None:
-            self.empty_element_tags =3D set(empty_element_tags)
         self.soup =3D None
         self.nsmaps =3D [self.DEFAULT_NSMAPS_INVERTED]
         self.active_namespace_prefixes =3D [dict(self.DEFAULT_NSMAPS)]
+        if self.is_xml:
+            self.processing_instruction_class =3D XMLProcessingInstructi=
on
+        else:
+            self.processing_instruction_class =3D ProcessingInstruction
+
+        if "attribute_dict_class" not in kwargs:
+            kwargs["attribute_dict_class"] =3D XMLAttributeDict
+        self.huge_tree =3D huge_tree
+
         super(LXMLTreeBuilderForXML, self).__init__(**kwargs)
-       =20
-    def _getNsTag(self, tag):
+
+    def _getNsTag(self, tag: str) -> Tuple[Optional[str], str]:
         # Split the namespace URL out of a fully-qualified lxml tag
         # name. Copied from lxml's src/lxml/sax.py.
-        if tag[0] =3D=3D '{':
-            return tuple(tag[1:].split('}', 1))
-        else:
-            return (None, tag)
-
-    def prepare_markup(self, markup, user_specified_encoding=3DNone,
-                       exclude_encodings=3DNone,
-                       document_declared_encoding=3DNone):
+        if tag[0] =3D=3D "{" and "}" in tag:
+            namespace, name =3D tag[1:].split("}", 1)
+            return (namespace, name)
+        return (None, tag)
+
+    def prepare_markup(
+        self,
+        markup: _RawMarkup,
+        user_specified_encoding: Optional[_Encoding] =3D None,
+        document_declared_encoding: Optional[_Encoding] =3D None,
+        exclude_encodings: Optional[_Encodings] =3D None,
+    ) -> Iterable[
+        Tuple[Union[str, bytes], Optional[_Encoding], Optional[_Encoding=
], bool]
+    ]:
         """Run any preliminary steps necessary to make incoming markup
         acceptable to the parser.
=20
@@ -166,24 +234,17 @@ class LXMLTreeBuilderForXML(TreeBuilder):
         :param exclude_encodings: The user asked _not_ to try any of
             these encodings.
=20
-        :yield: A series of 4-tuples:
-         (markup, encoding, declared encoding,
-          has undergone character replacement)
+        :yield: A series of 4-tuples: (markup, encoding, declared encodi=
ng,
+            has undergone character replacement)
=20
-         Each 4-tuple represents a strategy for converting the
-         document to Unicode and parsing it. Each strategy will be tried=
=20
-         in turn.
+            Each 4-tuple represents a strategy for converting the
+            document to Unicode and parsing it. Each strategy will be tr=
ied
+            in turn.
         """
-        is_html =3D not self.is_xml
-        if is_html:
-            self.processing_instruction_class =3D ProcessingInstruction
+        if not self.is_xml:
             # We're in HTML mode, so if we're given XML, that's worth
             # noting.
-            DetectsXMLParsedAsHTML.warn_if_markup_looks_like_xml(
-                markup, stacklevel=3D3
-            )
-        else:
-            self.processing_instruction_class =3D XMLProcessingInstructi=
on
+            DetectsXMLParsedAsHTML.warn_if_markup_looks_like_xml(markup,=
 stacklevel=3D3)
=20
         if isinstance(markup, str):
             # We were given Unicode. Maybe lxml can parse Unicode on
@@ -192,66 +253,107 @@ class LXMLTreeBuilderForXML(TreeBuilder):
             # TODO: This is a workaround for
             # https://bugs.launchpad.net/lxml/+bug/1948551.
             # We can remove it once the upstream issue is fixed.
-            if len(markup) > 0 and markup[0] =3D=3D u'\N{BYTE ORDER MARK=
}':
+            if len(markup) > 0 and markup[0] =3D=3D "\N{BYTE ORDER MARK}=
":
                 markup =3D markup[1:]
             yield markup, None, document_declared_encoding, False
=20
         if isinstance(markup, str):
             # No, apparently not. Convert the Unicode to UTF-8 and
             # tell lxml to parse it as UTF-8.
-            yield (markup.encode("utf8"), "utf8",
-                   document_declared_encoding, False)
+            yield (markup.encode("utf8"), "utf8", document_declared_enco=
ding, False)
+
+            # Since the document was Unicode in the first place, there
+            # is no need to try any more strategies; we know this will
+            # work.
+            return
+
+        known_definite_encodings: List[_Encoding] =3D []
+        if user_specified_encoding:
+            # This was provided by the end-user; treat it as a known
+            # definite encoding per the algorithm laid out in the
+            # HTML5 spec. (See the EncodingDetector class for
+            # details.)
+            known_definite_encodings.append(user_specified_encoding)
+
+        user_encodings: List[_Encoding] =3D []
+        if document_declared_encoding:
+            # This was found in the document; treat it as a slightly
+            # lower-priority user encoding.
+            user_encodings.append(document_declared_encoding)
=20
-        # This was provided by the end-user; treat it as a known
-        # definite encoding per the algorithm laid out in the HTML5
-        # spec.  (See the EncodingDetector class for details.)
-        known_definite_encodings =3D [user_specified_encoding]
-
-        # This was found in the document; treat it as a slightly lower-p=
riority
-        # user encoding.
-        user_encodings =3D [document_declared_encoding]
         detector =3D EncodingDetector(
-            markup, known_definite_encodings=3Dknown_definite_encodings,
-            user_encodings=3Duser_encodings, is_html=3Dis_html,
-            exclude_encodings=3Dexclude_encodings
+            markup,
+            known_definite_encodings=3Dknown_definite_encodings,
+            user_encodings=3Duser_encodings,
+            is_html=3Dnot self.is_xml,
+            exclude_encodings=3Dexclude_encodings,
         )
         for encoding in detector.encodings:
             yield (detector.markup, encoding, document_declared_encoding=
, False)
=20
-    def feed(self, markup):
+    def feed(self, markup: _RawMarkup) -> None:
+        io: Union[BytesIO, StringIO]
         if isinstance(markup, bytes):
-            markup =3D BytesIO(markup)
+            io =3D BytesIO(markup)
         elif isinstance(markup, str):
-            markup =3D StringIO(markup)
+            io =3D StringIO(markup)
+
+        # initialize_soup is called before feed, so we know this
+        # is not None.
+        assert self.soup is not None
=20
         # Call feed() at least once, even if the markup is empty,
         # or the parser won't be initialized.
-        data =3D markup.read(self.CHUNK_SIZE)
+        data =3D io.read(self.CHUNK_SIZE)
         try:
             self.parser =3D self.parser_for(self.soup.original_encoding)
             self.parser.feed(data)
             while len(data) !=3D 0:
                 # Now call feed() on the rest of the data, chunk by chun=
k.
-                data =3D markup.read(self.CHUNK_SIZE)
+                data =3D io.read(self.CHUNK_SIZE)
                 if len(data) !=3D 0:
                     self.parser.feed(data)
             self.parser.close()
         except (UnicodeDecodeError, LookupError, etree.ParserError) as e=
:
             raise ParserRejectedMarkup(e)
=20
-    def close(self):
+    def close(self) -> None:
         self.nsmaps =3D [self.DEFAULT_NSMAPS_INVERTED]
=20
-    def start(self, name, attrs, nsmap=3D{}):
-        # Make sure attrs is a mutable dict--lxml may send an immutable =
dictproxy.
-        attrs =3D dict(attrs)
-        nsprefix =3D None
+    def start(
+        self,
+        tag: str | bytes,
+        attrib: Dict[str | bytes, str | bytes],
+        nsmap: _NamespaceMapping =3D {},
+    ) -> None:
+        # This is called by lxml code as a result of calling
+        # BeautifulSoup.feed(), and we know self.soup is set by the time=
 feed()
+        # is called.
+        assert self.soup is not None
+        assert isinstance(tag, str)
+
+        # We need to recreate the attribute dict for three
+        # reasons. First, for type checking, so we can assert there
+        # are no bytestrings in the keys or values. Second, because we
+        # need a mutable dict--lxml might send us an immutable
+        # dictproxy. Third, so we can handle namespaced attribute
+        # names by converting the keys to NamespacedAttributes.
+        new_attrib: Dict[Union[str, NamespacedAttribute], str] =3D (
+            self.attribute_dict_class()
+        )
+        for k, v in attrib.items():
+            assert isinstance(k, str)
+            assert isinstance(v, str)
+            new_attrib[k] =3D v
+
+        nsprefix: Optional[_NamespacePrefix] =3D None
+        namespace: Optional[_NamespaceURL] =3D None
         # Invert each namespace map as it comes in.
         if len(nsmap) =3D=3D 0 and len(self.nsmaps) > 1:
-                # There are no new namespaces for this tag, but
-                # non-default namespaces are in play, so we need a
-                # separate tag stack to know when they end.
-                self.nsmaps.append(None)
+            # There are no new namespaces for this tag, but
+            # non-default namespaces are in play, so we need a
+            # separate tag stack to know when they end.
+            self.nsmaps.append(None)
         elif len(nsmap) > 0:
             # A new namespace mapping has come into play.
=20
@@ -272,40 +374,44 @@ class LXMLTreeBuilderForXML(TreeBuilder):
             # We should not track un-prefixed namespaces as we can only =
hold one
             # and it will be recognized as the default namespace by soup=
sieve,
             # which may be confusing in some situations.
-            if '' in current_mapping:
-                del current_mapping['']
+            if "" in current_mapping:
+                del current_mapping[""]
             self.active_namespace_prefixes.append(current_mapping)
-           =20
+
             # Also treat the namespace mapping as a set of attributes on=
 the
             # tag, so we can recreate it later.
-            attrs =3D attrs.copy()
             for prefix, namespace in list(nsmap.items()):
                 attribute =3D NamespacedAttribute(
-                    "xmlns", prefix, "http://www.w3.org/2000/xmlns/")
-                attrs[attribute] =3D namespace
+                    "xmlns", prefix, "http://www.w3.org/2000/xmlns/"
+                )
+                new_attrib[attribute] =3D namespace
=20
         # Namespaces are in play. Find any attributes that came in
         # from lxml with namespaces attached to their names, and
         # turn then into NamespacedAttribute objects.
-        new_attrs =3D {}
-        for attr, value in list(attrs.items()):
+        final_attrib: AttributeDict =3D self.attribute_dict_class()
+        for attr, value in list(new_attrib.items()):
             namespace, attr =3D self._getNsTag(attr)
             if namespace is None:
-                new_attrs[attr] =3D value
+                final_attrib[attr] =3D value
             else:
                 nsprefix =3D self._prefix_for_namespace(namespace)
                 attr =3D NamespacedAttribute(nsprefix, attr, namespace)
-                new_attrs[attr] =3D value
-        attrs =3D new_attrs
+                final_attrib[attr] =3D value
=20
-        namespace, name =3D self._getNsTag(name)
+        namespace, tag =3D self._getNsTag(tag)
         nsprefix =3D self._prefix_for_namespace(namespace)
         self.soup.handle_starttag(
-            name, namespace, nsprefix, attrs,
-            namespaces=3Dself.active_namespace_prefixes[-1]
+            tag,
+            namespace,
+            nsprefix,
+            final_attrib,
+            namespaces=3Dself.active_namespace_prefixes[-1],
         )
-       =20
-    def _prefix_for_namespace(self, namespace):
+
+    def _prefix_for_namespace(
+        self, namespace: Optional[_NamespaceURL]
+    ) -> Optional[_NamespacePrefix]:
         """Find the currently active prefix for the given namespace."""
         if namespace is None:
             return None
@@ -314,17 +420,18 @@ class LXMLTreeBuilderForXML(TreeBuilder):
                 return inverted_nsmap[namespace]
         return None
=20
-    def end(self, name):
+    def end(self, tag: str | bytes) -> None:
+        assert self.soup is not None
+        assert isinstance(tag, str)
         self.soup.endData()
-        completed_tag =3D self.soup.tagStack[-1]
-        namespace, name =3D self._getNsTag(name)
+        namespace, tag =3D self._getNsTag(tag)
         nsprefix =3D None
         if namespace is not None:
             for inverted_nsmap in reversed(self.nsmaps):
                 if inverted_nsmap is not None and namespace in inverted_=
nsmap:
                     nsprefix =3D inverted_nsmap[namespace]
                     break
-        self.soup.handle_endtag(name, nsprefix)
+        self.soup.handle_endtag(tag, nsprefix)
         if len(self.nsmaps) > 1:
             # This tag, or one of its parents, introduced a namespace
             # mapping, so pop it off the stack.
@@ -335,45 +442,52 @@ class LXMLTreeBuilderForXML(TreeBuilder):
                 # longer in scope. Recalculate the currently active
                 # namespace prefixes.
                 self.active_namespace_prefixes.pop()
-           =20
-    def pi(self, target, data):
+
+    def pi(self, target: str, data: str) -> None:
+        assert self.soup is not None
         self.soup.endData()
-        data =3D target + ' ' + data
+        data =3D target + " " + data
         self.soup.handle_data(data)
         self.soup.endData(self.processing_instruction_class)
-       =20
-    def data(self, content):
-        self.soup.handle_data(content)
=20
-    def doctype(self, name, pubid, system):
+    def data(self, data: str | bytes) -> None:
+        assert self.soup is not None
+        assert isinstance(data, str)
+        self.soup.handle_data(data)
+
+    def doctype(self, name: str, pubid: str, system: str) -> None:
+        assert self.soup is not None
         self.soup.endData()
-        doctype =3D Doctype.for_name_and_ids(name, pubid, system)
-        self.soup.object_was_parsed(doctype)
+        doctype_string =3D Doctype._string_for_name_and_ids(name, pubid,=
 system)
+        self.soup.handle_data(doctype_string)
+        self.soup.endData(containerClass=3DDoctype)
=20
-    def comment(self, content):
+    def comment(self, text: str | bytes) -> None:
         "Handle comments as Comment objects."
+        assert self.soup is not None
+        assert isinstance(text, str)
         self.soup.endData()
-        self.soup.handle_data(content)
+        self.soup.handle_data(text)
         self.soup.endData(Comment)
=20
-    def test_fragment_to_document(self, fragment):
+    def test_fragment_to_document(self, fragment: str) -> str:
         """See `TreeBuilder`."""
         return '<?xml version=3D"1.0" encoding=3D"utf-8"?>\n%s' % fragme=
nt
=20
=20
 class LXMLTreeBuilder(HTMLTreeBuilder, LXMLTreeBuilderForXML):
+    NAME: str =3D LXML
+    ALTERNATE_NAMES: Iterable[str] =3D ["lxml-html"]
=20
-    NAME =3D LXML
-    ALTERNATE_NAMES =3D ["lxml-html"]
+    features: Iterable[str] =3D list(ALTERNATE_NAMES) + [NAME, HTML, FAS=
T, PERMISSIVE]
+    is_xml: bool =3D False
=20
-    features =3D ALTERNATE_NAMES + [NAME, HTML, FAST, PERMISSIVE]
-    is_xml =3D False
-    processing_instruction_class =3D ProcessingInstruction
-
-    def default_parser(self, encoding):
+    def default_parser(self, encoding: Optional[_Encoding]) -> _ParserOr=
ParserClass:
         return etree.HTMLParser
=20
-    def feed(self, markup):
+    def feed(self, markup: _RawMarkup) -> None:
+        # We know self.soup is set by the time feed() is called.
+        assert self.soup is not None
         encoding =3D self.soup.original_encoding
         try:
             self.parser =3D self.parser_for(encoding)
@@ -382,7 +496,6 @@ class LXMLTreeBuilder(HTMLTreeBuilder, LXMLTreeBuilde=
rForXML):
         except (UnicodeDecodeError, LookupError, etree.ParserError) as e=
:
             raise ParserRejectedMarkup(e)
=20
-
-    def test_fragment_to_document(self, fragment):
+    def test_fragment_to_document(self, fragment: str) -> str:
         """See `TreeBuilder`."""
-        return '<html><body>%s</body></html>' % fragment
+        return "<html><body>%s</body></html>" % fragment
diff --git a/lib/bb/_vendor/bs4/css.py b/lib/bb/_vendor/bs4/css.py
index 7cbeb83c1..b6e73c2ed 100644
--- a/lib/bb/_vendor/bs4/css.py
+++ b/lib/bb/_vendor/bs4/css.py
@@ -1,36 +1,55 @@
-"""Integration code for CSS selectors using Soup Sieve (pypi: soupsieve)=
."""
+"""Integration code for CSS selectors using `Soup Sieve <https://faceles=
suser.github.io/soupsieve/>`_ (pypi: ``soupsieve``).
+
+Acquire a `CSS` object through the `element.Tag.css` attribute of
+the starting point of your CSS selector, or (if you want to run a
+selector against the entire document) of the `BeautifulSoup` object
+itself.
+
+The main advantage of doing this instead of using ``soupsieve``
+functions is that you don't need to keep passing the `element.Tag` to be
+selected against, since the `CSS` object is permanently scoped to that
+`element.Tag`.
+
+"""
+
+from __future__ import annotations
+
+from types import ModuleType
+from typing import (
+    Any,
+    cast,
+    Iterable,
+    Iterator,
+    MutableSequence,
+    Optional,
+    TYPE_CHECKING,
+)
+from bb._vendor.bs4._typing import _NamespaceMapping
+
+if TYPE_CHECKING:
+    from bb._vendor.bs4 import element
+    from bb._vendor.bs4.element import ResultSet, Tag
=20
 # We don't use soupsieve
 soupsieve =3D None
=20
-
 class CSS(object):
-    """A proxy object against the soupsieve library, to simplify its
+    """A proxy object against the ``soupsieve`` library, to simplify its
     CSS selector API.
=20
-    Acquire this object through the .css attribute on the
-    BeautifulSoup object, or on the Tag you want to use as the
-    starting point for a CSS selector.
-
-    The main advantage of doing this is that the tag to be selected
-    against doesn't need to be explicitly specified in the function
-    calls, since it's already scoped to a tag.
-    """
-
-    def __init__(self, tag, api=3Dsoupsieve):
-        """Constructor.
+    You don't need to instantiate this class yourself; instead, use
+    `element.Tag.css`.
=20
-        You don't need to instantiate this class yourself; instead,
-        access the .css attribute on the BeautifulSoup object, or on
-        the Tag you want to use as the starting point for your CSS
-        selector.
+    :param tag: All CSS selectors run by this object will use this as
+        their starting point.
=20
-        :param tag: All CSS selectors will use this as their starting
-        point.
+    :param api: An optional drop-in replacement for the ``soupsieve`` mo=
dule,
+        intended for use in unit tests.
+    """
=20
-        :param api: A plug-in replacement for the soupsieve module,
-        designed mainly for use in tests.
-        """
+    def __init__(self, tag: element.Tag, api: Optional[ModuleType] =3D N=
one):
+        if api is None:
+            api =3D soupsieve
         if api is None:
             raise NotImplementedError(
                 "Cannot execute CSS selectors because the soupsieve pack=
age is not installed."
@@ -38,19 +57,21 @@ class CSS(object):
         self.api =3D api
         self.tag =3D tag
=20
-    def escape(self, ident):
+    def escape(self, ident: str) -> str:
         """Escape a CSS identifier.
=20
-        This is a simple wrapper around soupselect.escape(). See the
+        This is a simple wrapper around `soupsieve.escape() <https://fac=
elessuser.github.io/soupsieve/api/#soupsieveescape>`_. See the
         documentation for that function for more information.
         """
         if soupsieve is None:
             raise NotImplementedError(
                 "Cannot escape CSS identifiers because the soupsieve pac=
kage is not installed."
             )
-        return self.api.escape(ident)
+        return cast(str, self.api.escape(ident))
=20
-    def _ns(self, ns, select):
+    def _ns(
+        self, ns: Optional[_NamespaceMapping], select: str
+    ) -> Optional[_NamespaceMapping]:
         """Normalize a dictionary of namespaces."""
         if not isinstance(select, self.api.SoupSieve) and ns is None:
             # If the selector is a precompiled pattern, it already has
@@ -59,19 +80,26 @@ class CSS(object):
             ns =3D self.tag._namespaces
         return ns
=20
-    def _rs(self, results):
-        """Normalize a list of results to a Resultset.
+    def _rs(self, results: MutableSequence[Tag]) -> ResultSet[Tag]:
+        """Normalize a list of results to a py:class:`ResultSet`.
=20
-        A ResultSet is more consistent with the rest of Beautiful
-        Soup's API, and ResultSet.__getattr__ has a helpful error
-        message if you try to treat a list of results as a single
-        result (a common mistake).
+        A py:class:`ResultSet` is more consistent with the rest of
+        Beautiful Soup's API, and :py:meth:`ResultSet.__getattr__` has
+        a helpful error message if you try to treat a list of results
+        as a single result (a common mistake).
         """
         # Import here to avoid circular import
-        from .element import ResultSet
+        from bb._vendor.bs4 import ResultSet
+
         return ResultSet(None, results)
=20
-    def compile(self, select, namespaces=3DNone, flags=3D0, **kwargs):
+    def compile(
+        self,
+        select: str,
+        namespaces: Optional[_NamespaceMapping] =3D None,
+        flags: int =3D 0,
+        **kwargs: Any,
+    ) -> SoupSieve:
         """Pre-compile a selector and return the compiled object.
=20
         :param selector: A CSS selector.
@@ -82,25 +110,28 @@ class CSS(object):
            parsing the document.
=20
         :param flags: Flags to be passed into Soup Sieve's
-            soupsieve.compile() method.
+            `soupsieve.compile() <https://facelessuser.github.io/soupsie=
ve/api/#soupsievecompile>`_ method.
=20
-        :param kwargs: Keyword arguments to be passed into SoupSieve's
-           soupsieve.compile() method.
+        :param kwargs: Keyword arguments to be passed into Soup Sieve's
+           `soupsieve.compile() <https://facelessuser.github.io/soupsiev=
e/api/#soupsievecompile>`_ method.
=20
         :return: A precompiled selector object.
         :rtype: soupsieve.SoupSieve
         """
-        return self.api.compile(
-            select, self._ns(namespaces, select), flags, **kwargs
-        )
-
-    def select_one(self, select, namespaces=3DNone, flags=3D0, **kwargs)=
:
+        return self.api.compile(select, self._ns(namespaces, select), fl=
ags, **kwargs)
+
+    def select_one(
+        self,
+        select: str,
+        namespaces: Optional[_NamespaceMapping] =3D None,
+        flags: int =3D 0,
+        **kwargs: Any,
+    ) -> element.Tag | None:
         """Perform a CSS selection operation on the current Tag and retu=
rn the
-        first result.
+        first result, if any.
=20
         This uses the Soup Sieve library. For more information, see
-        that library's documentation for the soupsieve.select_one()
-        method.
+        that library's documentation for the `soupsieve.select_one() <ht=
tps://facelessuser.github.io/soupsieve/api/#soupsieveselect_one>`_ method.
=20
         :param selector: A CSS selector.
=20
@@ -110,27 +141,29 @@ class CSS(object):
            parsing the document.
=20
         :param flags: Flags to be passed into Soup Sieve's
-            soupsieve.select_one() method.
-
-        :param kwargs: Keyword arguments to be passed into SoupSieve's
-           soupsieve.select_one() method.
-
-        :return: A Tag, or None if the selector has no match.
-        :rtype: bs4.element.Tag
+            `soupsieve.select_one() <https://facelessuser.github.io/soup=
sieve/api/#soupsieveselect_one>`_ method.
=20
+        :param kwargs: Keyword arguments to be passed into Soup Sieve's
+           `soupsieve.select_one() <https://facelessuser.github.io/soups=
ieve/api/#soupsieveselect_one>`_ method.
         """
         return self.api.select_one(
             select, self.tag, self._ns(namespaces, select), flags, **kwa=
rgs
         )
=20
-    def select(self, select, namespaces=3DNone, limit=3D0, flags=3D0, **=
kwargs):
-        """Perform a CSS selection operation on the current Tag.
+    def select(
+        self,
+        select: str,
+        namespaces: Optional[_NamespaceMapping] =3D None,
+        limit: int =3D 0,
+        flags: int =3D 0,
+        **kwargs: Any,
+    ) -> ResultSet[element.Tag]:
+        """Perform a CSS selection operation on the current `element.Tag=
`.
=20
         This uses the Soup Sieve library. For more information, see
-        that library's documentation for the soupsieve.select()
-        method.
+        that library's documentation for the `soupsieve.select() <https:=
//facelessuser.github.io/soupsieve/api/#soupsieveselect>`_ method.
=20
-        :param selector: A string containing a CSS selector.
+        :param selector: A CSS selector.
=20
         :param namespaces: A dictionary mapping namespace prefixes
             used in the CSS selector to namespace URIs. By default,
@@ -140,30 +173,33 @@ class CSS(object):
         :param limit: After finding this number of results, stop looking.
=20
         :param flags: Flags to be passed into Soup Sieve's
-            soupsieve.select() method.
-
-        :param kwargs: Keyword arguments to be passed into SoupSieve's
-            soupsieve.select() method.
-
-        :return: A ResultSet of Tag objects.
-        :rtype: bs4.element.ResultSet
+            `soupsieve.select() <https://facelessuser.github.io/soupsiev=
e/api/#soupsieveselect>`_ method.
=20
+        :param kwargs: Keyword arguments to be passed into Soup Sieve's
+           `soupsieve.select() <https://facelessuser.github.io/soupsieve=
/api/#soupsieveselect>`_ method.
         """
         if limit is None:
             limit =3D 0
=20
         return self._rs(
             self.api.select(
-                select, self.tag, self._ns(namespaces, select), limit, f=
lags,
-                **kwargs
+                select, self.tag, self._ns(namespaces, select), limit, f=
lags, **kwargs
             )
         )
=20
-    def iselect(self, select, namespaces=3DNone, limit=3D0, flags=3D0, *=
*kwargs):
-        """Perform a CSS selection operation on the current Tag.
+    def iselect(
+        self,
+        select: str,
+        namespaces: Optional[_NamespaceMapping] =3D None,
+        limit: int =3D 0,
+        flags: int =3D 0,
+        **kwargs: Any,
+    ) -> Iterator[element.Tag]:
+        """Perform a CSS selection operation on the current `element.Tag=
`.
=20
         This uses the Soup Sieve library. For more information, see
-        that library's documentation for the soupsieve.iselect()
+        that library's documentation for the `soupsieve.iselect()
+        <https://facelessuser.github.io/soupsieve/api/#soupsieveiselect>=
`_
         method. It is the same as select(), but it returns a generator
         instead of a list.
=20
@@ -177,23 +213,27 @@ class CSS(object):
         :param limit: After finding this number of results, stop looking.
=20
         :param flags: Flags to be passed into Soup Sieve's
-            soupsieve.iselect() method.
-
-        :param kwargs: Keyword arguments to be passed into SoupSieve's
-            soupsieve.iselect() method.
+            `soupsieve.iselect() <https://facelessuser.github.io/soupsie=
ve/api/#soupsieveiselect>`_ method.
=20
-        :return: A generator
-        :rtype: types.GeneratorType
+        :param kwargs: Keyword arguments to be passed into Soup Sieve's
+           `soupsieve.iselect() <https://facelessuser.github.io/soupsiev=
e/api/#soupsieveiselect>`_ method.
         """
         return self.api.iselect(
             select, self.tag, self._ns(namespaces, select), limit, flags=
, **kwargs
         )
=20
-    def closest(self, select, namespaces=3DNone, flags=3D0, **kwargs):
-        """Find the Tag closest to this one that matches the given selec=
tor.
+    def closest(
+        self,
+        select: str,
+        namespaces: Optional[_NamespaceMapping] =3D None,
+        flags: int =3D 0,
+        **kwargs: Any,
+    ) -> Optional[element.Tag]:
+        """Find the `element.Tag` closest to this one that matches the g=
iven selector.
=20
         This uses the Soup Sieve library. For more information, see
-        that library's documentation for the soupsieve.closest()
+        that library's documentation for the `soupsieve.closest()
+        <https://facelessuser.github.io/soupsieve/api/#soupsieveclosest>=
`_
         method.
=20
         :param selector: A string containing a CSS selector.
@@ -204,24 +244,28 @@ class CSS(object):
             parsing the document.
=20
         :param flags: Flags to be passed into Soup Sieve's
-            soupsieve.closest() method.
+            `soupsieve.closest() <https://facelessuser.github.io/soupsie=
ve/api/#soupsieveclosest>`_ method.
=20
-        :param kwargs: Keyword arguments to be passed into SoupSieve's
-            soupsieve.closest() method.
-
-        :return: A Tag, or None if there is no match.
-        :rtype: bs4.Tag
+        :param kwargs: Keyword arguments to be passed into Soup Sieve's
+           `soupsieve.closest() <https://facelessuser.github.io/soupsiev=
e/api/#soupsieveclosest>`_ method.
=20
         """
         return self.api.closest(
             select, self.tag, self._ns(namespaces, select), flags, **kwa=
rgs
         )
=20
-    def match(self, select, namespaces=3DNone, flags=3D0, **kwargs):
-        """Check whether this Tag matches the given CSS selector.
+    def match(
+        self,
+        select: str,
+        namespaces: Optional[_NamespaceMapping] =3D None,
+        flags: int =3D 0,
+        **kwargs: Any,
+    ) -> bool:
+        """Check whether or not this `element.Tag` matches the given CSS=
 selector.
=20
         This uses the Soup Sieve library. For more information, see
-        that library's documentation for the soupsieve.match()
+        that library's documentation for the `soupsieve.match()
+        <https://facelessuser.github.io/soupsieve/api/#soupsievematch>`_
         method.
=20
         :param: a CSS selector.
@@ -232,25 +276,37 @@ class CSS(object):
             parsing the document.
=20
         :param flags: Flags to be passed into Soup Sieve's
-            soupsieve.match() method.
+            `soupsieve.match()
+            <https://facelessuser.github.io/soupsieve/api/#soupsievematc=
h>`_
+            method.
=20
         :param kwargs: Keyword arguments to be passed into SoupSieve's
-            soupsieve.match() method.
-
-        :return: True if this Tag matches the selector; False otherwise.
-        :rtype: bool
+            `soupsieve.match()
+            <https://facelessuser.github.io/soupsieve/api/#soupsievematc=
h>`_
+            method.
         """
-        return self.api.match(
-            select, self.tag, self._ns(namespaces, select), flags, **kwa=
rgs
+        return cast(
+            bool,
+            self.api.match(
+                select, self.tag, self._ns(namespaces, select), flags, *=
*kwargs
+            ),
         )
=20
-    def filter(self, select, namespaces=3DNone, flags=3D0, **kwargs):
-        """Filter this Tag's direct children based on the given CSS sele=
ctor.
+    def filter(
+        self,
+        select: str,
+        namespaces: Optional[_NamespaceMapping] =3D None,
+        flags: int =3D 0,
+        **kwargs: Any,
+    ) -> ResultSet[element.Tag]:
+        """Filter this `element.Tag`'s direct children based on the give=
n CSS selector.
=20
         This uses the Soup Sieve library. It works the same way as
-        passing this Tag into that library's soupsieve.filter()
-        method. More information, for more information see the
-        documentation for soupsieve.filter().
+        passing a `element.Tag` into that library's `soupsieve.filter()
+        <https://facelessuser.github.io/soupsieve/api/#soupsievefilter>`=
_
+        method. For more information, see the documentation for
+        `soupsieve.filter()
+        <https://facelessuser.github.io/soupsieve/api/#soupsievefilter>`=
_.
=20
         :param namespaces: A dictionary mapping namespace prefixes
             used in the CSS selector to namespace URIs. By default,
@@ -258,14 +314,14 @@ class CSS(object):
             parsing the document.
=20
         :param flags: Flags to be passed into Soup Sieve's
-            soupsieve.filter() method.
+            `soupsieve.filter()
+            <https://facelessuser.github.io/soupsieve/api/#soupsievefilt=
er>`_
+            method.
=20
         :param kwargs: Keyword arguments to be passed into SoupSieve's
-            soupsieve.filter() method.
-
-        :return: A ResultSet of Tag objects.
-        :rtype: bs4.element.ResultSet
-
+            `soupsieve.filter()
+            <https://facelessuser.github.io/soupsieve/api/#soupsievefilt=
er>`_
+            method.
         """
         return self._rs(
             self.api.filter(
diff --git a/lib/bb/_vendor/bs4/dammit.py b/lib/bb/_vendor/bs4/dammit.py
index 692433c57..4051a9037 100644
--- a/lib/bb/_vendor/bs4/dammit.py
+++ b/lib/bb/_vendor/bs4/dammit.py
@@ -2,19 +2,41 @@
 """Beautiful Soup bonus library: Unicode, Dammit
=20
 This library converts a bytestream to Unicode through any means
-necessary. It is heavily based on code from Mark Pilgrim's Universal
-Feed Parser. It works best on XML and HTML, but it does not rewrite the
-XML or HTML to reflect a new encoding; that's the tree builder's job.
+necessary. It is heavily based on code from Mark Pilgrim's `Universal
+Feed Parser <https://pypi.org/project/feedparser/>`_, now maintained
+by Kurt McKee. It does not rewrite the body of an XML or HTML document
+to reflect a new encoding; that's the job of `TreeBuilder`.
+
 """
+
 # Use of this source code is governed by the MIT license.
 __license__ =3D "MIT"
=20
 from html.entities import codepoint2name
 from collections import defaultdict
 import codecs
+from html.entities import html5
 import re
-import logging
-import string
+from logging import Logger, getLogger
+from types import ModuleType
+from typing import (
+    Dict,
+    Iterator,
+    List,
+    Optional,
+    Pattern,
+    Set,
+    Tuple,
+    Type,
+    Union,
+    cast,
+)
+from typing_extensions import Literal
+from bb._vendor.bs4._typing import (
+    _Encoding,
+    _Encodings,
+)
+import warnings
=20
 # Import a library to autodetect character encodings. We'll support
 # any of a number of libraries that all support the same API:
@@ -22,75 +44,125 @@ import string
 # * cchardet
 # * chardet
 # * charset-normalizer
-chardet_module =3D None
+chardet_module: Optional[ModuleType] =3D None
 try:
     #  PyPI package: cchardet
-    import cchardet as chardet_module
+    import cchardet # type:ignore
+
+    chardet_module =3D cchardet
 except ImportError:
     try:
         #  Debian package: python-chardet
         #  PyPI package: chardet
-        import chardet as chardet_module
+        import chardet
+
+        chardet_module =3D chardet
     except ImportError:
         try:
             # PyPI package: charset-normalizer
-            import charset_normalizer as chardet_module
+            import charset_normalizer # type:ignore
+
+            chardet_module =3D charset_normalizer
         except ImportError:
             # No chardet available.
-            chardet_module =3D None
+            pass
=20
-if chardet_module:
-    def chardet_dammit(s):
-        if isinstance(s, str):
-            return None
-        return chardet_module.detect(s)['encoding']
-else:
-    def chardet_dammit(s):
+
+def _chardet_dammit(s: bytes) -> Optional[str]:
+    """Try as hard as possible to detect the encoding of a bytestring.""=
"
+    if chardet_module is None or isinstance(s, str):
         return None
+    module =3D chardet_module
+    return module.detect(s)["encoding"]
+
=20
 # Build bytestring and Unicode versions of regular expressions for findi=
ng
 # a declared encoding inside an XML or HTML document.
-xml_encoding =3D '^\\s*<\\?.*encoding=3D[\'"](.*?)[\'"].*\\?>'
-html_meta =3D '<\\s*meta[^>]+charset\\s*=3D\\s*["\']?([^>]*?)[ /;\'">]'
-encoding_res =3D dict()
+xml_encoding: str =3D "^\\s*<\\?.*encoding=3D['\"](.*?)['\"].*\\?>"  #: =
:meta private:
+html_meta: str =3D (
+    "<\\s*meta[^>]+charset\\s*=3D\\s*[\"']?([^>]*?)[ /;'\">]"  #: :meta =
private:
+)
+
+# TODO-TYPING: The Pattern type here could use more refinement, but it's=
 tricky.
+encoding_res: Dict[Type, Dict[str, Pattern]] =3D dict()
 encoding_res[bytes] =3D {
-    'html' : re.compile(html_meta.encode("ascii"), re.I),
-    'xml' : re.compile(xml_encoding.encode("ascii"), re.I),
+    "html": re.compile(html_meta.encode("ascii"), re.I),
+    "xml": re.compile(xml_encoding.encode("ascii"), re.I),
 }
 encoding_res[str] =3D {
-    'html' : re.compile(html_meta, re.I),
-    'xml' : re.compile(xml_encoding, re.I)
+    "html": re.compile(html_meta, re.I),
+    "xml": re.compile(xml_encoding, re.I),
 }
=20
-from html.entities import html5
=20
-class EntitySubstitution(object):
-    """The ability to substitute XML or HTML entities for certain charac=
ters."""
+class EntitySubstitutionMeta(type):
+    """Provides lazy access to some data structures and regular
+    expressions used by EntitySubstitution which have a measurable
+    startup cost.
+    """
+    # Trigger for
+    _CLASS_VARIABLES_POPULATED: bool =3D False
=20
-    def _populate_class_variables():
-        """Initialize variables used by this class to manage the plethor=
a of
-        HTML5 named entities.
+    @property
+    def HTML_ENTITY_TO_CHARACTER(self) -> Dict[str, str]:
+        """A mapping of entity names like "angmsdaa" to Unicode
+        strings like "=E2=A6=A8".
+        """
+        if not self._CLASS_VARIABLES_POPULATED:
+            self._populate_class_variables()
+        return self._HTML_ENTITY_TO_CHARACTER
+    _HTML_ENTITY_TO_CHARACTER: Dict[str, str]
=20
-        This function returns a 3-tuple containing two dictionaries
-        and a regular expression:
+    @property
+    def CHARACTER_TO_HTML_ENTITY(self) -> Dict[str, str]:
+        """A mapping of Unicode strings like "=E2=A6=A8" to entity names=
 like
+        "angmsdaa". When a single Unicode string has multiple entity
+        names, we try to choose the most commonly-used name.
+        """
+        if not self._CLASS_VARIABLES_POPULATED:
+            self._populate_class_variables()
+        return self._CHARACTER_TO_HTML_ENTITY
+    _CHARACTER_TO_HTML_ENTITY: Dict[str, str]
=20
-        unicode_to_name - A mapping of Unicode strings like "=E2=A6=A8" =
to
-        entity names like "angmsdaa". When a single Unicode string has
-        multiple entity names, we try to choose the most commonly-used
-        name.
+    @property
+    def CHARACTER_TO_HTML_ENTITY_RE(self) -> Pattern[str]:
+        """A regular expression matching (almost) any Unicode string
+        that corresponds to an HTML5 named entity.
+        """
=20
-        name_to_unicode: A mapping of entity names like "angmsdaa" to=20
-        Unicode strings like "=E2=A6=A8".
+        if not self._CLASS_VARIABLES_POPULATED:
+            self._populate_class_variables()
+        return self._CHARACTER_TO_HTML_ENTITY_RE
+    _CHARACTER_TO_HTML_ENTITY_RE: Pattern[str]
=20
-        named_entity_re: A regular expression matching (almost) any
-        Unicode string that corresponds to an HTML5 named entity.
+    @property
+    def CHARACTER_TO_HTML_ENTITY_WITH_AMPERSAND_RE(self) -> Pattern[str]=
:
+        """A very similar regular expression to
+        CHARACTER_TO_HTML_ENTITY_RE, but which also matches unescaped
+        ampersands. This is used by the 'html' formatter to provide
+        backwards-compatibility, even though the HTML5 spec allows
+        most ampersands to go unescaped.
+        """
+        if not self._CLASS_VARIABLES_POPULATED:
+            self._populate_class_variables()
+        return self._CHARACTER_TO_HTML_ENTITY_WITH_AMPERSAND_RE
+    _CHARACTER_TO_HTML_ENTITY_WITH_AMPERSAND_RE: Pattern[str]
+
+    def _populate_class_variables(self) -> None:
+        """Initialize variables used by EntitySubstitution to manage the=
 plethora of
+        HTML and HTML5 named entities.
+
+        This method populates the class variables necessary to make
+        the properties defined in the metaclass work.
         """
+        if self._CLASS_VARIABLES_POPULATED:
+            return
         unicode_to_name =3D {}
         name_to_unicode =3D {}
=20
         short_entities =3D set()
         long_entities_by_first_character =3D defaultdict(set)
-       =20
+
         for name_with_semicolon, character in sorted(html5.items()):
             # "It is intentional, for legacy compatibility, that many
             # code points have multiple character reference names. For
@@ -101,7 +173,7 @@ class EntitySubstitution(object):
             # The parsers are in charge of handling (or not) character
             # references with no trailing semicolon, so we remove the
             # semicolon whenever it appears.
-            if name_with_semicolon.endswith(';'):
+            if name_with_semicolon.endswith(";"):
                 name =3D name_with_semicolon[:-1]
             else:
                 name =3D name_with_semicolon
@@ -123,11 +195,10 @@ class EntitySubstitution(object):
             #
             # This is tricky, for two reasons.
=20
-            if (len(character) =3D=3D 1 and ord(character) < 128
-                and character not in '<>&'):
+            if len(character) =3D=3D 1 and ord(character) < 128 and char=
acter not in "<>":
                 # First, it would be annoying to turn single ASCII
                 # characters like | into named entities like
-                # &verbar;. The exceptions are <>&, which we _must_
+                # &verbar;. The exceptions are <>, which we _must_
                 # turn into named entities to produce valid HTML.
                 continue
=20
@@ -150,7 +221,7 @@ class EntitySubstitution(object):
             # we won't know exactly what the regular expression needs
             # to look like until we've gone through the entire list of
             # named entities.
-            if len(character) =3D=3D 1:
+            if len(character) =3D=3D 1 and character !=3D "&":
                 short_entities.add(character)
             else:
                 long_entities_by_first_character[character[0]].add(chara=
cter)
@@ -167,13 +238,16 @@ class EntitySubstitution(object):
                 # This finds, e.g. \u2267 but only if it is _not_
                 # followed by \u0338.
                 particles.add("%s(?![%s])" % (short, ignore))
-       =20
+
         for long_entities in list(long_entities_by_first_character.value=
s()):
             for long_entity in long_entities:
                 particles.add(long_entity)
=20
         re_definition =3D "(%s)" % "|".join(particles)
-               =20
+
+        particles.add("&")
+        re_definition_with_ampersand =3D "(%s)" % "|".join(particles)
+
         # If an entity shows up in both html5 and codepoint2name, it's
         # likely that HTML5 gives it several different names, such as
         # 'rsquo' and 'rsquor'. When converting Unicode characters to
@@ -184,40 +258,74 @@ class EntitySubstitution(object):
             character =3D chr(codepoint)
             unicode_to_name[character] =3D name
=20
-        return unicode_to_name, name_to_unicode, re.compile(re_definitio=
n)
-    (CHARACTER_TO_HTML_ENTITY, HTML_ENTITY_TO_CHARACTER,
-     CHARACTER_TO_HTML_ENTITY_RE) =3D _populate_class_variables()
+        self._CHARACTER_TO_HTML_ENTITY =3D unicode_to_name
+        self._HTML_ENTITY_TO_CHARACTER =3D name_to_unicode
+        self._CHARACTER_TO_HTML_ENTITY_RE =3D re.compile(re_definition)
+        self._CHARACTER_TO_HTML_ENTITY_WITH_AMPERSAND_RE =3D re.compile(
+            re_definition_with_ampersand
+        )
+        self._CLASS_VARIABLES_POPULATED =3D True
=20
-    CHARACTER_TO_XML_ENTITY =3D {
+class EntitySubstitution(metaclass=3DEntitySubstitutionMeta):
+    """The ability to substitute XML or HTML entities for certain charac=
ters."""
+
+    #: A map of Unicode strings to the corresponding named XML entities.
+    #:
+    #: :meta hide-value:
+    CHARACTER_TO_XML_ENTITY: Dict[str, str] =3D {
         "'": "apos",
         '"': "quot",
         "&": "amp",
         "<": "lt",
         ">": "gt",
-        }
+    }
+
+    # Matches any named or numeric HTML entity.
+    ANY_ENTITY_RE =3D re.compile("&(#\\d+|#x[0-9a-fA-F]+|\\w+);", re.I)
=20
-    BARE_AMPERSAND_OR_BRACKET =3D re.compile("([<>]|"
-                                           "&(?!#\\d+;|#x[0-9a-fA-F]+;|\=
\w+;)"
-                                           ")")
+    #: A regular expression matching an angle bracket or an ampersand th=
at
+    #: is not part of an XML or HTML entity.
+    #:
+    #: :meta hide-value:
+    BARE_AMPERSAND_OR_BRACKET: Pattern[str] =3D re.compile(
+        "([<>]|" "&(?!#\\d+;|#x[0-9a-fA-F]+;|\\w+;)" ")"
+    )
=20
-    AMPERSAND_OR_BRACKET =3D re.compile("([<>&])")
+    #: A regular expression matching an angle bracket or an ampersand.
+    #:
+    #: :meta hide-value:
+    AMPERSAND_OR_BRACKET: Pattern[str] =3D re.compile("([<>&])")
=20
     @classmethod
-    def _substitute_html_entity(cls, matchobj):
+    def _substitute_html_entity(cls, matchobj: re.Match) -> str:
         """Used with a regular expression to substitute the
         appropriate HTML entity for a special character string."""
-        entity =3D cls.CHARACTER_TO_HTML_ENTITY.get(matchobj.group(0))
+        original_entity =3D matchobj.group(0)
+        entity =3D cls.CHARACTER_TO_HTML_ENTITY.get(original_entity)
+        if entity is None:
+            return "&amp;%s;" % original_entity
         return "&%s;" % entity
=20
     @classmethod
-    def _substitute_xml_entity(cls, matchobj):
+    def _substitute_xml_entity(cls, matchobj: re.Match) -> str:
         """Used with a regular expression to substitute the
         appropriate XML entity for a special character string."""
         entity =3D cls.CHARACTER_TO_XML_ENTITY[matchobj.group(0)]
         return "&%s;" % entity
=20
     @classmethod
-    def quoted_attribute_value(self, value):
+    def _escape_entity_name(cls, matchobj: re.Match) -> str:
+        return "&amp;%s;" % matchobj.group(1)
+
+    @classmethod
+    def _escape_unrecognized_entity_name(cls, matchobj: re.Match) -> str=
:
+        possible_entity =3D matchobj.group(1)
+        if possible_entity in cls.HTML_ENTITY_TO_CHARACTER:
+            return "&%s;" % possible_entity
+        return "&amp;%s;" % possible_entity
+
+    @classmethod
+    def quoted_attribute_value(cls, value: str) -> str:
         """Make a value into a quoted XML attribute, possibly escaping i=
t.
=20
          Most strings will be quoted using double quotes.
@@ -233,7 +341,10 @@ class EntitySubstitution(object):
          double quotes will be escaped, and the string will be quoted
          using double quotes.
=20
-          Welcome to "Bob's Bar" -> "Welcome to &quot;Bob's bar&quot;
+          Welcome to "Bob's Bar" -> Welcome to &quot;Bob's bar&quot;
+
+        :param value: The XML attribute value to quote
+        :return: The quoted value
         """
         quote_with =3D '"'
         if '"' in value:
@@ -254,21 +365,25 @@ class EntitySubstitution(object):
         return quote_with + value + quote_with
=20
     @classmethod
-    def substitute_xml(cls, value, make_quoted_attribute=3DFalse):
-        """Substitute XML entities for special XML characters.
+    def substitute_xml(cls, value: str, make_quoted_attribute: bool =3D =
False) -> str:
+        """Replace special XML characters with named XML entities.
=20
-        :param value: A string to be substituted. The less-than sign
-          will become &lt;, the greater-than sign will become &gt;,
-          and any ampersands will become &amp;. If you want ampersands
-          that appear to be part of an entity definition to be left
-          alone, use substitute_xml_containing_entities() instead.
+        The less-than sign will become &lt;, the greater-than sign
+        will become &gt;, and any ampersands will become &amp;. If you
+        want ampersands that seem to be part of an entity definition
+        to be left alone, use `substitute_xml_containing_entities`
+        instead.
+
+        :param value: A string to be substituted.
=20
         :param make_quoted_attribute: If True, then the string will be
          quoted, as befits an attribute value.
+
+        :return: A version of ``value`` with special characters replaced
+         with named entities.
         """
         # Escape angle brackets and ampersands.
-        value =3D cls.AMPERSAND_OR_BRACKET.sub(
-            cls._substitute_xml_entity, value)
+        value =3D cls.AMPERSAND_OR_BRACKET.sub(cls._substitute_xml_entit=
y, value)
=20
         if make_quoted_attribute:
             value =3D cls.quoted_attribute_value(value)
@@ -276,7 +391,8 @@ class EntitySubstitution(object):
=20
     @classmethod
     def substitute_xml_containing_entities(
-        cls, value, make_quoted_attribute=3DFalse):
+        cls, value: str, make_quoted_attribute: bool =3D False
+    ) -> str:
         """Substitute XML entities for special XML characters.
=20
         :param value: A string to be substituted. The less-than sign wil=
l
@@ -289,18 +405,17 @@ class EntitySubstitution(object):
         """
         # Escape angle brackets, and ampersands that aren't part of
         # entities.
-        value =3D cls.BARE_AMPERSAND_OR_BRACKET.sub(
-            cls._substitute_xml_entity, value)
+        value =3D cls.BARE_AMPERSAND_OR_BRACKET.sub(cls._substitute_xml_=
entity, value)
=20
         if make_quoted_attribute:
             value =3D cls.quoted_attribute_value(value)
         return value
=20
     @classmethod
-    def substitute_html(cls, s):
+    def substitute_html(cls, s: str) -> str:
         """Replace certain Unicode characters with named HTML entities.
=20
-        This differs from data.encode(encoding, 'xmlcharrefreplace')
+        This differs from ``data.encode(encoding, 'xmlcharrefreplace')``
         in that the goal is to make the result more readable (to those
         with ASCII displays) rather than to recover from
         errors. There's absolutely nothing wrong with a UTF-8 string
@@ -308,109 +423,190 @@ class EntitySubstitution(object):
         character with "&eacute;" will make it more readable to some
         people.
=20
-        :param s: A Unicode string.
+        :param s: The string to be modified.
+        :return: The string with some Unicode characters replaced with
+           HTML entities.
+        """
+        # Convert any appropriate characters to HTML entities.
+        return cls.CHARACTER_TO_HTML_ENTITY_WITH_AMPERSAND_RE.sub(
+            cls._substitute_html_entity, s
+        )
+
+    @classmethod
+    def substitute_html5(cls, s: str) -> str:
+        """Replace certain Unicode characters with named HTML entities
+        using HTML5 rules.
+
+        Specifically, this method is much less aggressive about
+        escaping ampersands than substitute_html. Only ambiguous
+        ampersands are escaped, per the HTML5 standard:
+
+        "An ambiguous ampersand is a U+0026 AMPERSAND character (&)
+        that is followed by one or more ASCII alphanumerics, followed
+        by a U+003B SEMICOLON character (;), where these characters do
+        not match any of the names given in the named character
+        references section."
+
+        Unlike substitute_html5_raw, this method assumes HTML entities
+        were converted to Unicode characters on the way in, as
+        Beautiful Soup does. By the time Beautiful Soup does its work,
+        the only ambiguous ampersands that need to be escaped are the
+        ones that were escaped in the original markup when mentioning
+        HTML entities.
+
+        :param s: The string to be modified.
+        :return: The string with some Unicode characters replaced with
+           HTML entities.
+        """
+        # First, escape any HTML entities found in the markup.
+        s =3D cls.ANY_ENTITY_RE.sub(cls._escape_entity_name, s)
+
+        # Next, convert any appropriate characters to unescaped HTML ent=
ities.
+        s =3D cls.CHARACTER_TO_HTML_ENTITY_RE.sub(cls._substitute_html_e=
ntity, s)
+
+        return s
+
+    @classmethod
+    def substitute_html5_raw(cls, s: str) -> str:
+        """Replace certain Unicode characters with named HTML entities
+        using HTML5 rules.
+
+        substitute_html5_raw is similar to substitute_html5 but it is
+        designed for standalone use (whereas substitute_html5 is
+        designed for use with Beautiful Soup).
+
+        :param s: The string to be modified.
+        :return: The string with some Unicode characters replaced with
+           HTML entities.
         """
-        return cls.CHARACTER_TO_HTML_ENTITY_RE.sub(
-            cls._substitute_html_entity, s)
+        # First, escape the ampersand for anything that looks like an
+        # entity but isn't in the list of recognized entities. All other
+        # ampersands can be left alone.
+        s =3D cls.ANY_ENTITY_RE.sub(cls._escape_unrecognized_entity_name=
, s)
+
+        # Then, convert a range of Unicode characters to unescaped
+        # HTML entities.
+        s =3D cls.CHARACTER_TO_HTML_ENTITY_RE.sub(cls._substitute_html_e=
ntity, s)
+
+        return s
=20
=20
 class EncodingDetector:
-    """Suggests a number of possible encodings for a bytestring.
+    """This class is capable of guessing a number of possible encodings
+    for a bytestring.
=20
     Order of precedence:
=20
     1. Encodings you specifically tell EncodingDetector to try first
-    (the known_definite_encodings argument to the constructor).
+       (the ``known_definite_encodings`` argument to the constructor).
=20
     2. An encoding determined by sniffing the document's byte-order mark.
=20
     3. Encodings you specifically tell EncodingDetector to try if
-    byte-order mark sniffing fails (the user_encodings argument to the
-    constructor).
+       byte-order mark sniffing fails (the ``user_encodings`` argument t=
o the
+       constructor).
=20
     4. An encoding declared within the bytestring itself, either in an
-    XML declaration (if the bytestring is to be interpreted as an XML
-    document), or in a <meta> tag (if the bytestring is to be
-    interpreted as an HTML document.)
+       XML declaration (if the bytestring is to be interpreted as an XML
+       document), or in a <meta> tag (if the bytestring is to be
+       interpreted as an HTML document.)
=20
     5. An encoding detected through textual analysis by chardet,
-    cchardet, or a similar external library.
+       cchardet, or a similar external library.
+
+    6. UTF-8.
+
+    7. Windows-1252.
+
+    :param markup: Some markup in an unknown encoding.
+
+    :param known_definite_encodings: When determining the encoding
+        of ``markup``, these encodings will be tried first, in
+        order. In HTML terms, this corresponds to the "known
+        definite encoding" step defined in `section 13.2.3.1 of the HTML=
 standard <https://html.spec.whatwg.org/multipage/parsing.html#parsing-wi=
th-a-known-character-encoding>`_.
+
+    :param user_encodings: These encodings will be tried after the
+        ``known_definite_encodings`` have been tried and failed, and
+        after an attempt to sniff the encoding by looking at a
+        byte order mark has failed. In HTML terms, this
+        corresponds to the step "user has explicitly instructed
+        the user agent to override the document's character
+        encoding", defined in `section 13.2.3.2 of the HTML standard <ht=
tps://html.spec.whatwg.org/multipage/parsing.html#determining-the-charact=
er-encoding>`_.
=20
-    4. UTF-8.
+    :param override_encodings: A **deprecated** alias for
+        ``known_definite_encodings``. Any encodings here will be tried
+        immediately after the encodings in
+        ``known_definite_encodings``.
=20
-    5. Windows-1252.
+    :param is_html: If True, this markup is considered to be
+        HTML. Otherwise it's assumed to be XML.
+
+    :param exclude_encodings: These encodings will not be tried,
+        even if they otherwise would be.
=20
     """
-    def __init__(self, markup, known_definite_encodings=3DNone,
-                 is_html=3DFalse, exclude_encodings=3DNone,
-                 user_encodings=3DNone, override_encodings=3DNone):
-        """Constructor.
-
-        :param markup: Some markup in an unknown encoding.
-
-        :param known_definite_encodings: When determining the encoding
-            of `markup`, these encodings will be tried first, in
-            order. In HTML terms, this corresponds to the "known
-            definite encoding" step defined here:
-            https://html.spec.whatwg.org/multipage/parsing.html#parsing-=
with-a-known-character-encoding
-
-        :param user_encodings: These encodings will be tried after the
-            `known_definite_encodings` have been tried and failed, and
-            after an attempt to sniff the encoding by looking at a
-            byte order mark has failed. In HTML terms, this
-            corresponds to the step "user has explicitly instructed
-            the user agent to override the document's character
-            encoding", defined here:
-            https://html.spec.whatwg.org/multipage/parsing.html#determin=
ing-the-character-encoding
-
-        :param override_encodings: A deprecated alias for
-            known_definite_encodings. Any encodings here will be tried
-            immediately after the encodings in
-            known_definite_encodings.
-
-        :param is_html: If True, this markup is considered to be
-            HTML. Otherwise it's assumed to be XML.
-
-        :param exclude_encodings: These encodings will not be tried,
-            even if they otherwise would be.
=20
-        """
+    def __init__(
+        self,
+        markup: bytes,
+        known_definite_encodings: Optional[_Encodings] =3D None,
+        is_html: Optional[bool] =3D False,
+        exclude_encodings: Optional[_Encodings] =3D None,
+        user_encodings: Optional[_Encodings] =3D None,
+        override_encodings: Optional[_Encodings] =3D None,
+    ):
         self.known_definite_encodings =3D list(known_definite_encodings =
or [])
         if override_encodings:
+            warnings.warn(
+                "The 'override_encodings' argument was deprecated in 4.1=
0.0. Use 'known_definite_encodings' instead.",
+                DeprecationWarning,
+                stacklevel=3D3,
+            )
             self.known_definite_encodings +=3D override_encodings
         self.user_encodings =3D user_encodings or []
         exclude_encodings =3D exclude_encodings or []
         self.exclude_encodings =3D set([x.lower() for x in exclude_encod=
ings])
         self.chardet_encoding =3D None
-        self.is_html =3D is_html
-        self.declared_encoding =3D None
+        self.is_html =3D False if is_html is None else is_html
+        self.declared_encoding: Optional[str] =3D None
=20
         # First order of business: strip a byte-order mark.
         self.markup, self.sniffed_encoding =3D self.strip_byte_order_mar=
k(markup)
=20
-    def _usable(self, encoding, tried):
+    known_definite_encodings: _Encodings
+    user_encodings: _Encodings
+    exclude_encodings: _Encodings
+    chardet_encoding: Optional[_Encoding]
+    is_html: bool
+    declared_encoding: Optional[_Encoding]
+    markup: bytes
+    sniffed_encoding: Optional[_Encoding]
+
+    def _usable(self, encoding: Optional[_Encoding], tried: Set[_Encodin=
g]) -> bool:
         """Should we even bother to try this encoding?
=20
         :param encoding: Name of an encoding.
-        :param tried: Encodings that have already been tried. This will =
be modified
-            as a side effect.
+        :param tried: Encodings that have already been tried. This
+            will be modified as a side effect.
         """
-        if encoding is not None:
-            encoding =3D encoding.lower()
-            if encoding in self.exclude_encodings:
-                return False
-            if encoding not in tried:
-                tried.add(encoding)
-                return True
+        if encoding is None:
+            return False
+        encoding =3D encoding.lower()
+        if encoding in self.exclude_encodings:
+            return False
+        if encoding not in tried:
+            tried.add(encoding)
+            return True
         return False
=20
     @property
-    def encodings(self):
+    def encodings(self) -> Iterator[_Encoding]:
         """Yield a number of encodings that might work for this markup.
=20
-        :yield: A sequence of strings.
+        :yield: A sequence of strings. Each is the name of an encoding
+           that *might* work to convert a bytestring into Unicode.
         """
-        tried =3D set()
+        tried: Set[_Encoding] =3D set()
=20
         # First, try the known definite encodings
         for e in self.known_definite_encodings:
@@ -419,7 +615,9 @@ class EncodingDetector:
=20
         # Did the document originally start with a byte-order mark
         # that indicated its encoding?
-        if self._usable(self.sniffed_encoding, tried):
+        if self.sniffed_encoding is not None and self._usable(
+            self.sniffed_encoding, tried
+        ):
             yield self.sniffed_encoding
=20
         # Sniffing the byte-order mark did nothing; try the user
@@ -427,60 +625,79 @@ class EncodingDetector:
         for e in self.user_encodings:
             if self._usable(e, tried):
                 yield e
-           =20
+
         # Look within the document for an XML or HTML encoding
         # declaration.
         if self.declared_encoding is None:
             self.declared_encoding =3D self.find_declared_encoding(
-                self.markup, self.is_html)
-        if self._usable(self.declared_encoding, tried):
+                self.markup, self.is_html
+            )
+        if self.declared_encoding is not None and self._usable(
+            self.declared_encoding, tried
+        ):
             yield self.declared_encoding
=20
         # Use third-party character set detection to guess at the
         # encoding.
         if self.chardet_encoding is None:
-            self.chardet_encoding =3D chardet_dammit(self.markup)
-        if self._usable(self.chardet_encoding, tried):
+            self.chardet_encoding =3D _chardet_dammit(self.markup)
+        if self.chardet_encoding is not None and self._usable(
+            self.chardet_encoding, tried
+        ):
             yield self.chardet_encoding
=20
         # As a last-ditch effort, try utf-8 and windows-1252.
-        for e in ('utf-8', 'windows-1252'):
+        for e in ("utf-8", "windows-1252"):
             if self._usable(e, tried):
                 yield e
=20
     @classmethod
-    def strip_byte_order_mark(cls, data):
+    def strip_byte_order_mark(cls, data: bytes) -> Tuple[bytes, Optional=
[_Encoding]]:
         """If a byte-order mark is present, strip it and return the enco=
ding it implies.
=20
-        :param data: Some markup.
-        :return: A 2-tuple (modified data, implied encoding)
+        :param data: A bytestring that may or may not begin with a
+           byte-order mark.
+
+        :return: A 2-tuple (data stripped of byte-order mark, encoding i=
mplied by byte-order mark)
         """
         encoding =3D None
         if isinstance(data, str):
             # Unicode data cannot have a byte-order mark.
             return data, encoding
-        if (len(data) >=3D 4) and (data[:2] =3D=3D b'\xfe\xff') \
-               and (data[2:4] !=3D '\x00\x00'):
-            encoding =3D 'utf-16be'
+        if (
+            (len(data) >=3D 4)
+            and (data[:2] =3D=3D b"\xfe\xff")
+            and (data[2:4] !=3D b"\x00\x00")
+        ):
+            encoding =3D "utf-16be"
             data =3D data[2:]
-        elif (len(data) >=3D 4) and (data[:2] =3D=3D b'\xff\xfe') \
-                 and (data[2:4] !=3D '\x00\x00'):
-            encoding =3D 'utf-16le'
+        elif (
+            (len(data) >=3D 4)
+            and (data[:2] =3D=3D b"\xff\xfe")
+            and (data[2:4] !=3D b"\x00\x00")
+        ):
+            encoding =3D "utf-16le"
             data =3D data[2:]
-        elif data[:3] =3D=3D b'\xef\xbb\xbf':
-            encoding =3D 'utf-8'
+        elif data[:3] =3D=3D b"\xef\xbb\xbf":
+            encoding =3D "utf-8"
             data =3D data[3:]
-        elif data[:4] =3D=3D b'\x00\x00\xfe\xff':
-            encoding =3D 'utf-32be'
+        elif data[:4] =3D=3D b"\x00\x00\xfe\xff":
+            encoding =3D "utf-32be"
             data =3D data[4:]
-        elif data[:4] =3D=3D b'\xff\xfe\x00\x00':
-            encoding =3D 'utf-32le'
+        elif data[:4] =3D=3D b"\xff\xfe\x00\x00":
+            encoding =3D "utf-32le"
             data =3D data[4:]
         return data, encoding
=20
     @classmethod
-    def find_declared_encoding(cls, markup, is_html=3DFalse, search_enti=
re_document=3DFalse):
-        """Given a document, tries to find its declared encoding.
+    def find_declared_encoding(
+        cls,
+        markup: Union[bytes, str],
+        is_html: bool =3D False,
+        search_entire_document: bool =3D False,
+    ) -> Optional[_Encoding]:
+        """Given a document, tries to find an encoding declared within t=
he
+        text of the document itself.
=20
         An XML encoding is declared at the beginning of the document.
=20
@@ -490,9 +707,12 @@ class EncodingDetector:
         :param markup: Some markup.
         :param is_html: If True, this markup is considered to be HTML. O=
therwise
             it's assumed to be XML.
-        :param search_entire_document: Since an encoding is supposed to =
declared near the beginning
-            of the document, most of the time it's only necessary to sea=
rch a few kilobytes of data.
-            Set this to True to force this method to search the entire d=
ocument.
+        :param search_entire_document: Since an encoding is supposed
+            to declared near the beginning of the document, most of
+            the time it's only necessary to search a few kilobytes of
+            data.  Set this to True to force this method to search the
+            entire document.
+        :return: The declared encoding, if one is found.
         """
         if search_entire_document:
             xml_endpos =3D html_endpos =3D len(markup)
@@ -505,9 +725,9 @@ class EncodingDetector:
         else:
             res =3D encoding_res[str]
=20
-        xml_re =3D res['xml']
-        html_re =3D res['html']
-        declared_encoding =3D None
+        xml_re =3D res["xml"]
+        html_re =3D res["html"]
+        declared_encoding: Optional[_Encoding] =3D None
         declared_encoding_match =3D xml_re.search(markup, endpos=3Dxml_e=
ndpos)
         if not declared_encoding_match and is_html:
             declared_encoding_match =3D html_re.search(markup, endpos=3D=
html_endpos)
@@ -515,81 +735,80 @@ class EncodingDetector:
             declared_encoding =3D declared_encoding_match.groups()[0]
         if declared_encoding:
             if isinstance(declared_encoding, bytes):
-                declared_encoding =3D declared_encoding.decode('ascii', =
'replace')
+                declared_encoding =3D declared_encoding.decode("ascii", =
"replace")
             return declared_encoding.lower()
         return None
=20
+
 class UnicodeDammit:
-    """A class for detecting the encoding of a *ML document and
-    converting it to a Unicode string. If the source encoding is
-    windows-1252, can replace MS smart quotes with their HTML or XML
-    equivalents."""
-
-    # This dictionary maps commonly seen values for "charset" in HTML
-    # meta tags to the corresponding Python codec names. It only covers
-    # values that aren't in Python's aliases and can't be determined
-    # by the heuristics in find_codec.
-    CHARSET_ALIASES =3D {"macintosh": "mac-roman",
-                       "x-sjis": "shift-jis"}
-
-    ENCODINGS_WITH_SMART_QUOTES =3D [
-        "windows-1252",
-        "iso-8859-1",
-        "iso-8859-2",
-        ]
+    """A class for detecting the encoding of a bytestring containing an
+    HTML or XML document, and decoding it to Unicode. If the source
+    encoding is windows-1252, `UnicodeDammit` can also replace
+    Microsoft smart quotes with their HTML or XML equivalents.
+
+    :param markup: HTML or XML markup in an unknown encoding.
+
+    :param known_definite_encodings: When determining the encoding
+        of ``markup``, these encodings will be tried first, in
+        order. In HTML terms, this corresponds to the "known
+        definite encoding" step defined in `section 13.2.3.1 of the HTML=
 standard <https://html.spec.whatwg.org/multipage/parsing.html#parsing-wi=
th-a-known-character-encoding>`_.
+
+    :param user_encodings: These encodings will be tried after the
+        ``known_definite_encodings`` have been tried and failed, and
+        after an attempt to sniff the encoding by looking at a
+        byte order mark has failed. In HTML terms, this
+        corresponds to the step "user has explicitly instructed
+        the user agent to override the document's character
+        encoding", defined in `section 13.2.3.2 of the HTML standard <ht=
tps://html.spec.whatwg.org/multipage/parsing.html#determining-the-charact=
er-encoding>`_.
+
+    :param override_encodings: A **deprecated** alias for
+        ``known_definite_encodings``. Any encodings here will be tried
+        immediately after the encodings in
+        ``known_definite_encodings``.
+
+    :param smart_quotes_to: By default, Microsoft smart quotes will,
+       like all other characters, be converted to Unicode
+       characters. Setting this to ``ascii`` will convert them to ASCII
+       quotes instead.  Setting it to ``xml`` will convert them to XML
+       entity references, and setting it to ``html`` will convert them
+       to HTML entity references.
+
+    :param is_html: If True, ``markup`` is treated as an HTML
+       document. Otherwise it's treated as an XML document.
+
+    :param exclude_encodings: These encodings will not be considered,
+       even if the sniffing code thinks they might make sense.
=20
-    def __init__(self, markup, known_definite_encodings=3D[],
-                 smart_quotes_to=3DNone, is_html=3DFalse, exclude_encodi=
ngs=3D[],
-                 user_encodings=3DNone, override_encodings=3DNone
-    ):
-        """Constructor.
-
-        :param markup: A bytestring representing markup in an unknown en=
coding.
-
-        :param known_definite_encodings: When determining the encoding
-            of `markup`, these encodings will be tried first, in
-            order. In HTML terms, this corresponds to the "known
-            definite encoding" step defined here:
-            https://html.spec.whatwg.org/multipage/parsing.html#parsing-=
with-a-known-character-encoding
-
-        :param user_encodings: These encodings will be tried after the
-            `known_definite_encodings` have been tried and failed, and
-            after an attempt to sniff the encoding by looking at a
-            byte order mark has failed. In HTML terms, this
-            corresponds to the step "user has explicitly instructed
-            the user agent to override the document's character
-            encoding", defined here:
-            https://html.spec.whatwg.org/multipage/parsing.html#determin=
ing-the-character-encoding
-
-        :param override_encodings: A deprecated alias for
-            known_definite_encodings. Any encodings here will be tried
-            immediately after the encodings in
-            known_definite_encodings.
-
-        :param smart_quotes_to: By default, Microsoft smart quotes will,=
 like all other characters, be converted
-           to Unicode characters. Setting this to 'ascii' will convert t=
hem to ASCII quotes instead.
-           Setting it to 'xml' will convert them to XML entity reference=
s, and setting it to 'html'
-           will convert them to HTML entity references.
-        :param is_html: If True, this markup is considered to be HTML. O=
therwise
-            it's assumed to be XML.
-        :param exclude_encodings: These encodings will not be considered=
, even
-            if the sniffing code thinks they might make sense.
+    """
=20
-        """
+    def __init__(
+        self,
+        markup: bytes,
+        known_definite_encodings: Optional[_Encodings] =3D [],
+        smart_quotes_to: Optional[Literal["ascii", "xml", "html"]] =3D N=
one,
+        is_html: bool =3D False,
+        exclude_encodings: Optional[_Encodings] =3D [],
+        user_encodings: Optional[_Encodings] =3D None,
+        override_encodings: Optional[_Encodings] =3D None,
+    ):
         self.smart_quotes_to =3D smart_quotes_to
         self.tried_encodings =3D []
         self.contains_replacement_characters =3D False
         self.is_html =3D is_html
-        self.log =3D logging.getLogger(__name__)
+        self.log =3D getLogger(__name__)
         self.detector =3D EncodingDetector(
-            markup, known_definite_encodings, is_html, exclude_encodings=
,
-            user_encodings, override_encodings
+            markup,
+            known_definite_encodings,
+            is_html,
+            exclude_encodings,
+            user_encodings,
+            override_encodings,
         )
=20
         # Short-circuit if the data is in Unicode to begin with.
-        if isinstance(markup, str) or markup =3D=3D '':
-            self.markup =3D markup
-            self.unicode_markup =3D str(markup)
+        if isinstance(markup, str):
+            self.markup =3D markup.encode("utf8")
+            self.unicode_markup =3D markup
             self.original_encoding =3D None
             return
=20
@@ -613,100 +832,186 @@ class UnicodeDammit:
                     u =3D self._convert_from(encoding, "replace")
                 if u is not None:
                     self.log.warning(
-                            "Some characters could not be decoded, and w=
ere "
-                            "replaced with REPLACEMENT CHARACTER."
+                        "Some characters could not be decoded, and were =
"
+                        "replaced with REPLACEMENT CHARACTER."
                     )
+
                     self.contains_replacement_characters =3D True
                     break
=20
         # If none of that worked, we could at this point force it to
         # ASCII, but that would destroy so much data that I think
         # giving up is better.
-        self.unicode_markup =3D u
-        if not u:
+        #
+        # Note that this is extremely unlikely, probably impossible,
+        # because the "replace" strategy is so powerful. Even running
+        # the Python binary through Unicode, Dammit gives you Unicode,
+        # albeit Unicode riddled with REPLACEMENT CHARACTER.
+        if u is None:
             self.original_encoding =3D None
+            self.unicode_markup =3D None
+        else:
+            self.unicode_markup =3D u
+
+    #: The original markup, before it was converted to Unicode.
+    #: This is not necessarily the same as what was passed in to the
+    #: constructor, since any byte-order mark will be stripped.
+    markup: bytes
+
+    #: The Unicode version of the markup, following conversion. This
+    #: is set to None if there was simply no way to convert the
+    #: bytestring to Unicode (as with binary data).
+    unicode_markup: Optional[str]
+
+    #: This is True if `UnicodeDammit.unicode_markup` contains
+    #: U+FFFD REPLACEMENT_CHARACTER characters which were not present
+    #: in `UnicodeDammit.markup`. These mark character sequences that
+    #: could not be represented in Unicode.
+    contains_replacement_characters: bool
+
+    #: Unicode, Dammit's best guess as to the original character
+    #: encoding of `UnicodeDammit.markup`.
+    original_encoding: Optional[_Encoding]
+
+    #: The strategy used to handle Microsoft smart quotes.
+    smart_quotes_to: Optional[str]
+
+    #: The (encoding, error handling strategy) 2-tuples that were used t=
o
+    #: try and convert the markup to Unicode.
+    tried_encodings: List[Tuple[_Encoding, str]]
=20
-    def _sub_ms_char(self, match):
+    log: Logger  #: :meta private:
+
+    def _sub_ms_char(self, match: re.Match) -> bytes:
         """Changes a MS smart quote character to an XML or HTML
-        entity, or an ASCII character."""
-        orig =3D match.group(1)
-        if self.smart_quotes_to =3D=3D 'ascii':
-            sub =3D self.MS_CHARS_TO_ASCII.get(orig).encode()
+        entity, or an ASCII character.
+
+        TODO: Since this is only used to convert smart quotes, it
+        could be simplified, and MS_CHARS_TO_ASCII made much less
+        parochial.
+        """
+        orig: bytes =3D match.group(1)
+        sub: bytes
+        if self.smart_quotes_to =3D=3D "ascii":
+            if orig in self.MS_CHARS_TO_ASCII:
+                sub =3D self.MS_CHARS_TO_ASCII[orig].encode()
+            else:
+                # Shouldn't happen; substitute the character
+                # with itself.
+                sub =3D orig
         else:
-            sub =3D self.MS_CHARS.get(orig)
-            if type(sub) =3D=3D tuple:
-                if self.smart_quotes_to =3D=3D 'xml':
-                    sub =3D '&#x'.encode() + sub[1].encode() + ';'.encod=
e()
+            if orig in self.MS_CHARS:
+                substitutions =3D self.MS_CHARS[orig]
+                if type(substitutions) is tuple:
+                    if self.smart_quotes_to =3D=3D "xml":
+                        sub =3D b"&#x" + substitutions[1].encode() + b";=
"
+                    else:
+                        sub =3D b"&" + substitutions[0].encode() + b";"
                 else:
-                    sub =3D '&'.encode() + sub[0].encode() + ';'.encode(=
)
+                    substitutions =3D cast(str, substitutions)
+                    sub =3D substitutions.encode()
             else:
-                sub =3D sub.encode()
+                # Shouldn't happen; substitute the character
+                # for itself.
+                sub =3D orig
         return sub
=20
-    def _convert_from(self, proposed, errors=3D"strict"):
+    #: This dictionary maps commonly seen values for "charset" in HTML
+    #: meta tags to the corresponding Python codec names. It only covers
+    #: values that aren't in Python's aliases and can't be determined
+    #: by the heuristics in `find_codec`.
+    #:
+    #: :meta hide-value:
+    CHARSET_ALIASES: Dict[str, _Encoding] =3D {
+        "macintosh": "mac-roman",
+        "x-sjis": "shift-jis",
+    }
+
+    #: A list of encodings that tend to contain Microsoft smart quotes.
+    #:
+    #: :meta hide-value:
+    ENCODINGS_WITH_SMART_QUOTES: _Encodings =3D [
+        "windows-1252",
+        "iso-8859-1",
+        "iso-8859-2",
+    ]
+
+    def _convert_from(
+        self, proposed: _Encoding, errors: str =3D "strict"
+    ) -> Optional[str]:
         """Attempt to convert the markup to the proposed encoding.
=20
         :param proposed: The name of a character encoding.
+        :param errors: An error handling strategy, used when calling `st=
r`.
+        :return: The converted markup, or `None` if the proposed
+           encoding/error handling strategy didn't work.
         """
-        proposed =3D self.find_codec(proposed)
-        if not proposed or (proposed, errors) in self.tried_encodings:
+        lookup_result =3D self.find_codec(proposed)
+        if lookup_result is None or (lookup_result, errors) in self.trie=
d_encodings:
             return None
+        proposed =3D lookup_result
         self.tried_encodings.append((proposed, errors))
         markup =3D self.markup
         # Convert smart quotes to HTML if coming from an encoding
         # that might have them.
-        if (self.smart_quotes_to is not None
-            and proposed in self.ENCODINGS_WITH_SMART_QUOTES):
+        if (
+            self.smart_quotes_to is not None
+            and proposed in self.ENCODINGS_WITH_SMART_QUOTES
+        ):
             smart_quotes_re =3D b"([\x80-\x9f])"
             smart_quotes_compiled =3D re.compile(smart_quotes_re)
             markup =3D smart_quotes_compiled.sub(self._sub_ms_char, mark=
up)
=20
         try:
-            #print("Trying to convert document to %s (errors=3D%s)" % (
+            # print("Trying to convert document to %s (errors=3D%s)" % (
             #    proposed, errors))
             u =3D self._to_unicode(markup, proposed, errors)
-            self.markup =3D u
+            self.unicode_markup =3D u
             self.original_encoding =3D proposed
-        except Exception as e:
-            #print("That didn't work!")
-            #print(e)
+        except Exception:
+            # print("That didn't work!")
+            # print(e)
             return None
-        #print("Correct encoding: %s" % proposed)
-        return self.markup
+        # print("Correct encoding: %s" % proposed)
+        return self.unicode_markup
=20
-    def _to_unicode(self, data, encoding, errors=3D"strict"):
-        """Given a string and its encoding, decodes the string into Unic=
ode.
+    def _to_unicode(
+        self, data: bytes, encoding: _Encoding, errors: str =3D "strict"
+    ) -> str:
+        """Given a bytestring and its encoding, decodes the string into =
Unicode.
=20
         :param encoding: The name of an encoding.
+        :param errors: An error handling strategy, used when calling `st=
r`.
         """
         return str(data, encoding, errors)
=20
     @property
-    def declared_html_encoding(self):
-        """If the markup is an HTML document, returns the encoding decla=
red _within_
-        the document.
+    def declared_html_encoding(self) -> Optional[_Encoding]:
+        """If the markup is an HTML document, returns the encoding, if a=
ny,
+        declared *inside* the document.
         """
         if not self.is_html:
             return None
         return self.detector.declared_encoding
=20
-    def find_codec(self, charset):
-        """Convert the name of a character set to a codec name.
+    def find_codec(self, charset: _Encoding) -> Optional[str]:
+        """Look up the Python codec corresponding to a given character s=
et.
=20
         :param charset: The name of a character set.
-        :return: The name of a codec.
+        :return: The name of a Python codec.
         """
-        value =3D (self._codec(self.CHARSET_ALIASES.get(charset, charset=
))
-               or (charset and self._codec(charset.replace("-", "")))
-               or (charset and self._codec(charset.replace("-", "_")))
-               or (charset and charset.lower())
-               or charset
-                )
+        value =3D (
+            self._codec(self.CHARSET_ALIASES.get(charset, charset))
+            or (charset and self._codec(charset.replace("-", "")))
+            or (charset and self._codec(charset.replace("-", "_")))
+            or (charset and charset.lower())
+            or charset
+        )
         if value:
             return value.lower()
         return None
=20
-    def _codec(self, charset):
+    def _codec(self, charset: _Encoding) -> Optional[str]:
         if not charset:
             return charset
         codec =3D None
@@ -717,343 +1022,473 @@ class UnicodeDammit:
             pass
         return codec
=20
-
-    # A partial mapping of ISO-Latin-1 to HTML entities/XML numeric enti=
ties.
-    MS_CHARS =3D {b'\x80': ('euro', '20AC'),
-                b'\x81': ' ',
-                b'\x82': ('sbquo', '201A'),
-                b'\x83': ('fnof', '192'),
-                b'\x84': ('bdquo', '201E'),
-                b'\x85': ('hellip', '2026'),
-                b'\x86': ('dagger', '2020'),
-                b'\x87': ('Dagger', '2021'),
-                b'\x88': ('circ', '2C6'),
-                b'\x89': ('permil', '2030'),
-                b'\x8A': ('Scaron', '160'),
-                b'\x8B': ('lsaquo', '2039'),
-                b'\x8C': ('OElig', '152'),
-                b'\x8D': '?',
-                b'\x8E': ('#x17D', '17D'),
-                b'\x8F': '?',
-                b'\x90': '?',
-                b'\x91': ('lsquo', '2018'),
-                b'\x92': ('rsquo', '2019'),
-                b'\x93': ('ldquo', '201C'),
-                b'\x94': ('rdquo', '201D'),
-                b'\x95': ('bull', '2022'),
-                b'\x96': ('ndash', '2013'),
-                b'\x97': ('mdash', '2014'),
-                b'\x98': ('tilde', '2DC'),
-                b'\x99': ('trade', '2122'),
-                b'\x9a': ('scaron', '161'),
-                b'\x9b': ('rsaquo', '203A'),
-                b'\x9c': ('oelig', '153'),
-                b'\x9d': '?',
-                b'\x9e': ('#x17E', '17E'),
-                b'\x9f': ('Yuml', ''),}
-
-    # A parochial partial mapping of ISO-Latin-1 to ASCII. Contains
-    # horrors like stripping diacritical marks to turn =C3=A1 into a, bu=
t also
-    # contains non-horrors like turning =E2=80=9C into ".
-    MS_CHARS_TO_ASCII =3D {
-        b'\x80' : 'EUR',
-        b'\x81' : ' ',
-        b'\x82' : ',',
-        b'\x83' : 'f',
-        b'\x84' : ',,',
-        b'\x85' : '...',
-        b'\x86' : '+',
-        b'\x87' : '++',
-        b'\x88' : '^',
-        b'\x89' : '%',
-        b'\x8a' : 'S',
-        b'\x8b' : '<',
-        b'\x8c' : 'OE',
-        b'\x8d' : '?',
-        b'\x8e' : 'Z',
-        b'\x8f' : '?',
-        b'\x90' : '?',
-        b'\x91' : "'",
-        b'\x92' : "'",
-        b'\x93' : '"',
-        b'\x94' : '"',
-        b'\x95' : '*',
-        b'\x96' : '-',
-        b'\x97' : '--',
-        b'\x98' : '~',
-        b'\x99' : '(TM)',
-        b'\x9a' : 's',
-        b'\x9b' : '>',
-        b'\x9c' : 'oe',
-        b'\x9d' : '?',
-        b'\x9e' : 'z',
-        b'\x9f' : 'Y',
-        b'\xa0' : ' ',
-        b'\xa1' : '!',
-        b'\xa2' : 'c',
-        b'\xa3' : 'GBP',
-        b'\xa4' : '$', #This approximation is especially parochial--this=
 is the
-                       #generic currency symbol.
-        b'\xa5' : 'YEN',
-        b'\xa6' : '|',
-        b'\xa7' : 'S',
-        b'\xa8' : '..',
-        b'\xa9' : '',
-        b'\xaa' : '(th)',
-        b'\xab' : '<<',
-        b'\xac' : '!',
-        b'\xad' : ' ',
-        b'\xae' : '(R)',
-        b'\xaf' : '-',
-        b'\xb0' : 'o',
-        b'\xb1' : '+-',
-        b'\xb2' : '2',
-        b'\xb3' : '3',
-        b'\xb4' : ("'", 'acute'),
-        b'\xb5' : 'u',
-        b'\xb6' : 'P',
-        b'\xb7' : '*',
-        b'\xb8' : ',',
-        b'\xb9' : '1',
-        b'\xba' : '(th)',
-        b'\xbb' : '>>',
-        b'\xbc' : '1/4',
-        b'\xbd' : '1/2',
-        b'\xbe' : '3/4',
-        b'\xbf' : '?',
-        b'\xc0' : 'A',
-        b'\xc1' : 'A',
-        b'\xc2' : 'A',
-        b'\xc3' : 'A',
-        b'\xc4' : 'A',
-        b'\xc5' : 'A',
-        b'\xc6' : 'AE',
-        b'\xc7' : 'C',
-        b'\xc8' : 'E',
-        b'\xc9' : 'E',
-        b'\xca' : 'E',
-        b'\xcb' : 'E',
-        b'\xcc' : 'I',
-        b'\xcd' : 'I',
-        b'\xce' : 'I',
-        b'\xcf' : 'I',
-        b'\xd0' : 'D',
-        b'\xd1' : 'N',
-        b'\xd2' : 'O',
-        b'\xd3' : 'O',
-        b'\xd4' : 'O',
-        b'\xd5' : 'O',
-        b'\xd6' : 'O',
-        b'\xd7' : '*',
-        b'\xd8' : 'O',
-        b'\xd9' : 'U',
-        b'\xda' : 'U',
-        b'\xdb' : 'U',
-        b'\xdc' : 'U',
-        b'\xdd' : 'Y',
-        b'\xde' : 'b',
-        b'\xdf' : 'B',
-        b'\xe0' : 'a',
-        b'\xe1' : 'a',
-        b'\xe2' : 'a',
-        b'\xe3' : 'a',
-        b'\xe4' : 'a',
-        b'\xe5' : 'a',
-        b'\xe6' : 'ae',
-        b'\xe7' : 'c',
-        b'\xe8' : 'e',
-        b'\xe9' : 'e',
-        b'\xea' : 'e',
-        b'\xeb' : 'e',
-        b'\xec' : 'i',
-        b'\xed' : 'i',
-        b'\xee' : 'i',
-        b'\xef' : 'i',
-        b'\xf0' : 'o',
-        b'\xf1' : 'n',
-        b'\xf2' : 'o',
-        b'\xf3' : 'o',
-        b'\xf4' : 'o',
-        b'\xf5' : 'o',
-        b'\xf6' : 'o',
-        b'\xf7' : '/',
-        b'\xf8' : 'o',
-        b'\xf9' : 'u',
-        b'\xfa' : 'u',
-        b'\xfb' : 'u',
-        b'\xfc' : 'u',
-        b'\xfd' : 'y',
-        b'\xfe' : 'b',
-        b'\xff' : 'y',
-        }
-
-    # A map used when removing rogue Windows-1252/ISO-8859-1
-    # characters in otherwise UTF-8 documents.
+    #: A partial mapping of ISO-Latin-1 to HTML entities/XML numeric ent=
ities.
+    #:
+    #: :meta hide-value:
+    MS_CHARS: Dict[bytes, Union[str, Tuple[str, str]]] =3D {
+        b"\x80": ("euro", "20AC"),
+        b"\x81": " ",
+        b"\x82": ("sbquo", "201A"),
+        b"\x83": ("fnof", "192"),
+        b"\x84": ("bdquo", "201E"),
+        b"\x85": ("hellip", "2026"),
+        b"\x86": ("dagger", "2020"),
+        b"\x87": ("Dagger", "2021"),
+        b"\x88": ("circ", "2C6"),
+        b"\x89": ("permil", "2030"),
+        b"\x8a": ("Scaron", "160"),
+        b"\x8b": ("lsaquo", "2039"),
+        b"\x8c": ("OElig", "152"),
+        b"\x8d": "?",
+        b"\x8e": ("#x17D", "17D"),
+        b"\x8f": "?",
+        b"\x90": "?",
+        b"\x91": ("lsquo", "2018"),
+        b"\x92": ("rsquo", "2019"),
+        b"\x93": ("ldquo", "201C"),
+        b"\x94": ("rdquo", "201D"),
+        b"\x95": ("bull", "2022"),
+        b"\x96": ("ndash", "2013"),
+        b"\x97": ("mdash", "2014"),
+        b"\x98": ("tilde", "2DC"),
+        b"\x99": ("trade", "2122"),
+        b"\x9a": ("scaron", "161"),
+        b"\x9b": ("rsaquo", "203A"),
+        b"\x9c": ("oelig", "153"),
+        b"\x9d": "?",
+        b"\x9e": ("#x17E", "17E"),
+        b"\x9f": ("Yuml", ""),
+    }
+
+    #: A parochial partial mapping of ISO-Latin-1 to ASCII. Contains
+    #: horrors like stripping diacritical marks to turn =C3=A1 into a, b=
ut also
+    #: contains non-horrors like turning =E2=80=9C into ".
+    #:
+    #: Seriously, don't use this for anything other than removing smart
+    #: quotes.
+    #:
+    #: :meta private:
+    MS_CHARS_TO_ASCII: Dict[bytes, str] =3D {
+        b"\x80": "EUR",
+        b"\x81": " ",
+        b"\x82": ",",
+        b"\x83": "f",
+        b"\x84": ",,",
+        b"\x85": "...",
+        b"\x86": "+",
+        b"\x87": "++",
+        b"\x88": "^",
+        b"\x89": "%",
+        b"\x8a": "S",
+        b"\x8b": "<",
+        b"\x8c": "OE",
+        b"\x8d": "?",
+        b"\x8e": "Z",
+        b"\x8f": "?",
+        b"\x90": "?",
+        b"\x91": "'",
+        b"\x92": "'",
+        b"\x93": '"',
+        b"\x94": '"',
+        b"\x95": "*",
+        b"\x96": "-",
+        b"\x97": "--",
+        b"\x98": "~",
+        b"\x99": "(TM)",
+        b"\x9a": "s",
+        b"\x9b": ">",
+        b"\x9c": "oe",
+        b"\x9d": "?",
+        b"\x9e": "z",
+        b"\x9f": "Y",
+        b"\xa0": " ",
+        b"\xa1": "!",
+        b"\xa2": "c",
+        b"\xa3": "GBP",
+        b"\xa4": "$",  # This approximation is especially parochial--thi=
s is the
+        # generic currency symbol.
+        b"\xa5": "YEN",
+        b"\xa6": "|",
+        b"\xa7": "S",
+        b"\xa8": "..",
+        b"\xa9": "",
+        b"\xaa": "(th)",
+        b"\xab": "<<",
+        b"\xac": "!",
+        b"\xad": " ",
+        b"\xae": "(R)",
+        b"\xaf": "-",
+        b"\xb0": "o",
+        b"\xb1": "+-",
+        b"\xb2": "2",
+        b"\xb3": "3",
+        b"\xb4": "'",
+        b"\xb5": "u",
+        b"\xb6": "P",
+        b"\xb7": "*",
+        b"\xb8": ",",
+        b"\xb9": "1",
+        b"\xba": "(th)",
+        b"\xbb": ">>",
+        b"\xbc": "1/4",
+        b"\xbd": "1/2",
+        b"\xbe": "3/4",
+        b"\xbf": "?",
+        b"\xc0": "A",
+        b"\xc1": "A",
+        b"\xc2": "A",
+        b"\xc3": "A",
+        b"\xc4": "A",
+        b"\xc5": "A",
+        b"\xc6": "AE",
+        b"\xc7": "C",
+        b"\xc8": "E",
+        b"\xc9": "E",
+        b"\xca": "E",
+        b"\xcb": "E",
+        b"\xcc": "I",
+        b"\xcd": "I",
+        b"\xce": "I",
+        b"\xcf": "I",
+        b"\xd0": "D",
+        b"\xd1": "N",
+        b"\xd2": "O",
+        b"\xd3": "O",
+        b"\xd4": "O",
+        b"\xd5": "O",
+        b"\xd6": "O",
+        b"\xd7": "*",
+        b"\xd8": "O",
+        b"\xd9": "U",
+        b"\xda": "U",
+        b"\xdb": "U",
+        b"\xdc": "U",
+        b"\xdd": "Y",
+        b"\xde": "b",
+        b"\xdf": "B",
+        b"\xe0": "a",
+        b"\xe1": "a",
+        b"\xe2": "a",
+        b"\xe3": "a",
+        b"\xe4": "a",
+        b"\xe5": "a",
+        b"\xe6": "ae",
+        b"\xe7": "c",
+        b"\xe8": "e",
+        b"\xe9": "e",
+        b"\xea": "e",
+        b"\xeb": "e",
+        b"\xec": "i",
+        b"\xed": "i",
+        b"\xee": "i",
+        b"\xef": "i",
+        b"\xf0": "o",
+        b"\xf1": "n",
+        b"\xf2": "o",
+        b"\xf3": "o",
+        b"\xf4": "o",
+        b"\xf5": "o",
+        b"\xf6": "o",
+        b"\xf7": "/",
+        b"\xf8": "o",
+        b"\xf9": "u",
+        b"\xfa": "u",
+        b"\xfb": "u",
+        b"\xfc": "u",
+        b"\xfd": "y",
+        b"\xfe": "b",
+        b"\xff": "y",
+    }
+
+    #: A map used when removing rogue Windows-1252/ISO-8859-1
+    #: characters in otherwise UTF-8 documents. Also used when a
+    #: numeric character entity has been incorrectly encoded using the
+    #: character's Windows-1252 encoding.
+    #:
+    #: Note that \\x81, \\x8d, \\x8f, \\x90, and \\x9d are undefined in
+    #: Windows-1252.
+    #:
+    #: :meta hide-value:
+    WINDOWS_1252_TO_UTF8: Dict[int, bytes] =3D {
+        0x80: b"\xe2\x82\xac",  # =E2=82=AC
+        0x82: b"\xe2\x80\x9a",  # =E2=80=9A
+        0x83: b"\xc6\x92",  # =C6=92
+        0x84: b"\xe2\x80\x9e",  # =E2=80=9E
+        0x85: b"\xe2\x80\xa6",  # =E2=80=A6
+        0x86: b"\xe2\x80\xa0",  # =E2=80=A0
+        0x87: b"\xe2\x80\xa1",  # =E2=80=A1
+        0x88: b"\xcb\x86",  # =CB=86
+        0x89: b"\xe2\x80\xb0",  # =E2=80=B0
+        0x8A: b"\xc5\xa0",  # =C5=A0
+        0x8B: b"\xe2\x80\xb9",  # =E2=80=B9
+        0x8C: b"\xc5\x92",  # =C5=92
+        0x8E: b"\xc5\xbd",  # =C5=BD
+        0x91: b"\xe2\x80\x98",  # =E2=80=98
+        0x92: b"\xe2\x80\x99",  # =E2=80=99
+        0x93: b"\xe2\x80\x9c",  # =E2=80=9C
+        0x94: b"\xe2\x80\x9d",  # =E2=80=9D
+        0x95: b"\xe2\x80\xa2",  # =E2=80=A2
+        0x96: b"\xe2\x80\x93",  # =E2=80=93
+        0x97: b"\xe2\x80\x94",  # =E2=80=94
+        0x98: b"\xcb\x9c",  # =CB=9C
+        0x99: b"\xe2\x84\xa2",  # =E2=84=A2
+        0x9A: b"\xc5\xa1",  # =C5=A1
+        0x9B: b"\xe2\x80\xba",  # =E2=80=BA
+        0x9C: b"\xc5\x93",  # =C5=93
+        0x9E: b"\xc5\xbe",  # =C5=BE
+        0x9F: b"\xc5\xb8",  # =C5=B8
+        0xA0: b"\xc2\xa0",  #
+        0xA1: b"\xc2\xa1",  # =C2=A1
+        0xA2: b"\xc2\xa2",  # =C2=A2
+        0xA3: b"\xc2\xa3",  # =C2=A3
+        0xA4: b"\xc2\xa4",  # =C2=A4
+        0xA5: b"\xc2\xa5",  # =C2=A5
+        0xA6: b"\xc2\xa6",  # =C2=A6
+        0xA7: b"\xc2\xa7",  # =C2=A7
+        0xA8: b"\xc2\xa8",  # =C2=A8
+        0xA9: b"\xc2\xa9",  # =C2=A9
+        0xAA: b"\xc2\xaa",  # =C2=AA
+        0xAB: b"\xc2\xab",  # =C2=AB
+        0xAC: b"\xc2\xac",  # =C2=AC
+        0xAD: b"\xc2\xad",  # =C2=AD
+        0xAE: b"\xc2\xae",  # =C2=AE
+        0xAF: b"\xc2\xaf",  # =C2=AF
+        0xB0: b"\xc2\xb0",  # =C2=B0
+        0xB1: b"\xc2\xb1",  # =C2=B1
+        0xB2: b"\xc2\xb2",  # =C2=B2
+        0xB3: b"\xc2\xb3",  # =C2=B3
+        0xB4: b"\xc2\xb4",  # =C2=B4
+        0xB5: b"\xc2\xb5",  # =C2=B5
+        0xB6: b"\xc2\xb6",  # =C2=B6
+        0xB7: b"\xc2\xb7",  # =C2=B7
+        0xB8: b"\xc2\xb8",  # =C2=B8
+        0xB9: b"\xc2\xb9",  # =C2=B9
+        0xBA: b"\xc2\xba",  # =C2=BA
+        0xBB: b"\xc2\xbb",  # =C2=BB
+        0xBC: b"\xc2\xbc",  # =C2=BC
+        0xBD: b"\xc2\xbd",  # =C2=BD
+        0xBE: b"\xc2\xbe",  # =C2=BE
+        0xBF: b"\xc2\xbf",  # =C2=BF
+        0xC0: b"\xc3\x80",  # =C3=80
+        0xC1: b"\xc3\x81",  # =C3=81
+        0xC2: b"\xc3\x82",  # =C3=82
+        0xC3: b"\xc3\x83",  # =C3=83
+        0xC4: b"\xc3\x84",  # =C3=84
+        0xC5: b"\xc3\x85",  # =C3=85
+        0xC6: b"\xc3\x86",  # =C3=86
+        0xC7: b"\xc3\x87",  # =C3=87
+        0xC8: b"\xc3\x88",  # =C3=88
+        0xC9: b"\xc3\x89",  # =C3=89
+        0xCA: b"\xc3\x8a",  # =C3=8A
+        0xCB: b"\xc3\x8b",  # =C3=8B
+        0xCC: b"\xc3\x8c",  # =C3=8C
+        0xCD: b"\xc3\x8d",  # =C3=8D
+        0xCE: b"\xc3\x8e",  # =C3=8E
+        0xCF: b"\xc3\x8f",  # =C3=8F
+        0xD0: b"\xc3\x90",  # =C3=90
+        0xD1: b"\xc3\x91",  # =C3=91
+        0xD2: b"\xc3\x92",  # =C3=92
+        0xD3: b"\xc3\x93",  # =C3=93
+        0xD4: b"\xc3\x94",  # =C3=94
+        0xD5: b"\xc3\x95",  # =C3=95
+        0xD6: b"\xc3\x96",  # =C3=96
+        0xD7: b"\xc3\x97",  # =C3=97
+        0xD8: b"\xc3\x98",  # =C3=98
+        0xD9: b"\xc3\x99",  # =C3=99
+        0xDA: b"\xc3\x9a",  # =C3=9A
+        0xDB: b"\xc3\x9b",  # =C3=9B
+        0xDC: b"\xc3\x9c",  # =C3=9C
+        0xDD: b"\xc3\x9d",  # =C3=9D
+        0xDE: b"\xc3\x9e",  # =C3=9E
+        0xDF: b"\xc3\x9f",  # =C3=9F
+        0xE0: b"\xc3\xa0",  # =C3=A0
+        0xE1: b"\xa1",  # =C3=A1
+        0xE2: b"\xc3\xa2",  # =C3=A2
+        0xE3: b"\xc3\xa3",  # =C3=A3
+        0xE4: b"\xc3\xa4",  # =C3=A4
+        0xE5: b"\xc3\xa5",  # =C3=A5
+        0xE6: b"\xc3\xa6",  # =C3=A6
+        0xE7: b"\xc3\xa7",  # =C3=A7
+        0xE8: b"\xc3\xa8",  # =C3=A8
+        0xE9: b"\xc3\xa9",  # =C3=A9
+        0xEA: b"\xc3\xaa",  # =C3=AA
+        0xEB: b"\xc3\xab",  # =C3=AB
+        0xEC: b"\xc3\xac",  # =C3=AC
+        0xED: b"\xc3\xad",  # =C3=AD
+        0xEE: b"\xc3\xae",  # =C3=AE
+        0xEF: b"\xc3\xaf",  # =C3=AF
+        0xF0: b"\xc3\xb0",  # =C3=B0
+        0xF1: b"\xc3\xb1",  # =C3=B1
+        0xF2: b"\xc3\xb2",  # =C3=B2
+        0xF3: b"\xc3\xb3",  # =C3=B3
+        0xF4: b"\xc3\xb4",  # =C3=B4
+        0xF5: b"\xc3\xb5",  # =C3=B5
+        0xF6: b"\xc3\xb6",  # =C3=B6
+        0xF7: b"\xc3\xb7",  # =C3=B7
+        0xF8: b"\xc3\xb8",  # =C3=B8
+        0xF9: b"\xc3\xb9",  # =C3=B9
+        0xFA: b"\xc3\xba",  # =C3=BA
+        0xFB: b"\xc3\xbb",  # =C3=BB
+        0xFC: b"\xc3\xbc",  # =C3=BC
+        0xFD: b"\xc3\xbd",  # =C3=BD
+        0xFE: b"\xc3\xbe",  # =C3=BE
+        0xFF: b"\xc3\xbf",  # =C3=BF
+    }
+
+    #: :meta private
+    # Note that this isn't all Unicode noncharacters, just the noncontig=
uous ones that need to be listed.
     #
-    # Note that \x81, \x8d, \x8f, \x90, and \x9d are undefined in
-    # Windows-1252.
-    WINDOWS_1252_TO_UTF8 =3D {
-        0x80 : b'\xe2\x82\xac', # =E2=82=AC
-        0x82 : b'\xe2\x80\x9a', # =E2=80=9A
-        0x83 : b'\xc6\x92',     # =C6=92
-        0x84 : b'\xe2\x80\x9e', # =E2=80=9E
-        0x85 : b'\xe2\x80\xa6', # =E2=80=A6
-        0x86 : b'\xe2\x80\xa0', # =E2=80=A0
-        0x87 : b'\xe2\x80\xa1', # =E2=80=A1
-        0x88 : b'\xcb\x86',     # =CB=86
-        0x89 : b'\xe2\x80\xb0', # =E2=80=B0
-        0x8a : b'\xc5\xa0',     # =C5=A0
-        0x8b : b'\xe2\x80\xb9', # =E2=80=B9
-        0x8c : b'\xc5\x92',     # =C5=92
-        0x8e : b'\xc5\xbd',     # =C5=BD
-        0x91 : b'\xe2\x80\x98', # =E2=80=98
-        0x92 : b'\xe2\x80\x99', # =E2=80=99
-        0x93 : b'\xe2\x80\x9c', # =E2=80=9C
-        0x94 : b'\xe2\x80\x9d', # =E2=80=9D
-        0x95 : b'\xe2\x80\xa2', # =E2=80=A2
-        0x96 : b'\xe2\x80\x93', # =E2=80=93
-        0x97 : b'\xe2\x80\x94', # =E2=80=94
-        0x98 : b'\xcb\x9c',     # =CB=9C
-        0x99 : b'\xe2\x84\xa2', # =E2=84=A2
-        0x9a : b'\xc5\xa1',     # =C5=A1
-        0x9b : b'\xe2\x80\xba', # =E2=80=BA
-        0x9c : b'\xc5\x93',     # =C5=93
-        0x9e : b'\xc5\xbe',     # =C5=BE
-        0x9f : b'\xc5\xb8',     # =C5=B8
-        0xa0 : b'\xc2\xa0',     # =C2=A0
-        0xa1 : b'\xc2\xa1',     # =C2=A1
-        0xa2 : b'\xc2\xa2',     # =C2=A2
-        0xa3 : b'\xc2\xa3',     # =C2=A3
-        0xa4 : b'\xc2\xa4',     # =C2=A4
-        0xa5 : b'\xc2\xa5',     # =C2=A5
-        0xa6 : b'\xc2\xa6',     # =C2=A6
-        0xa7 : b'\xc2\xa7',     # =C2=A7
-        0xa8 : b'\xc2\xa8',     # =C2=A8
-        0xa9 : b'\xc2\xa9',     # =C2=A9
-        0xaa : b'\xc2\xaa',     # =C2=AA
-        0xab : b'\xc2\xab',     # =C2=AB
-        0xac : b'\xc2\xac',     # =C2=AC
-        0xad : b'\xc2\xad',     # =C2=AD
-        0xae : b'\xc2\xae',     # =C2=AE
-        0xaf : b'\xc2\xaf',     # =C2=AF
-        0xb0 : b'\xc2\xb0',     # =C2=B0
-        0xb1 : b'\xc2\xb1',     # =C2=B1
-        0xb2 : b'\xc2\xb2',     # =C2=B2
-        0xb3 : b'\xc2\xb3',     # =C2=B3
-        0xb4 : b'\xc2\xb4',     # =C2=B4
-        0xb5 : b'\xc2\xb5',     # =C2=B5
-        0xb6 : b'\xc2\xb6',     # =C2=B6
-        0xb7 : b'\xc2\xb7',     # =C2=B7
-        0xb8 : b'\xc2\xb8',     # =C2=B8
-        0xb9 : b'\xc2\xb9',     # =C2=B9
-        0xba : b'\xc2\xba',     # =C2=BA
-        0xbb : b'\xc2\xbb',     # =C2=BB
-        0xbc : b'\xc2\xbc',     # =C2=BC
-        0xbd : b'\xc2\xbd',     # =C2=BD
-        0xbe : b'\xc2\xbe',     # =C2=BE
-        0xbf : b'\xc2\xbf',     # =C2=BF
-        0xc0 : b'\xc3\x80',     # =C3=80
-        0xc1 : b'\xc3\x81',     # =C3=81
-        0xc2 : b'\xc3\x82',     # =C3=82
-        0xc3 : b'\xc3\x83',     # =C3=83
-        0xc4 : b'\xc3\x84',     # =C3=84
-        0xc5 : b'\xc3\x85',     # =C3=85
-        0xc6 : b'\xc3\x86',     # =C3=86
-        0xc7 : b'\xc3\x87',     # =C3=87
-        0xc8 : b'\xc3\x88',     # =C3=88
-        0xc9 : b'\xc3\x89',     # =C3=89
-        0xca : b'\xc3\x8a',     # =C3=8A
-        0xcb : b'\xc3\x8b',     # =C3=8B
-        0xcc : b'\xc3\x8c',     # =C3=8C
-        0xcd : b'\xc3\x8d',     # =C3=8D
-        0xce : b'\xc3\x8e',     # =C3=8E
-        0xcf : b'\xc3\x8f',     # =C3=8F
-        0xd0 : b'\xc3\x90',     # =C3=90
-        0xd1 : b'\xc3\x91',     # =C3=91
-        0xd2 : b'\xc3\x92',     # =C3=92
-        0xd3 : b'\xc3\x93',     # =C3=93
-        0xd4 : b'\xc3\x94',     # =C3=94
-        0xd5 : b'\xc3\x95',     # =C3=95
-        0xd6 : b'\xc3\x96',     # =C3=96
-        0xd7 : b'\xc3\x97',     # =C3=97
-        0xd8 : b'\xc3\x98',     # =C3=98
-        0xd9 : b'\xc3\x99',     # =C3=99
-        0xda : b'\xc3\x9a',     # =C3=9A
-        0xdb : b'\xc3\x9b',     # =C3=9B
-        0xdc : b'\xc3\x9c',     # =C3=9C
-        0xdd : b'\xc3\x9d',     # =C3=9D
-        0xde : b'\xc3\x9e',     # =C3=9E
-        0xdf : b'\xc3\x9f',     # =C3=9F
-        0xe0 : b'\xc3\xa0',     # =C3=A0
-        0xe1 : b'\xa1',         # =C3=A1
-        0xe2 : b'\xc3\xa2',     # =C3=A2
-        0xe3 : b'\xc3\xa3',     # =C3=A3
-        0xe4 : b'\xc3\xa4',     # =C3=A4
-        0xe5 : b'\xc3\xa5',     # =C3=A5
-        0xe6 : b'\xc3\xa6',     # =C3=A6
-        0xe7 : b'\xc3\xa7',     # =C3=A7
-        0xe8 : b'\xc3\xa8',     # =C3=A8
-        0xe9 : b'\xc3\xa9',     # =C3=A9
-        0xea : b'\xc3\xaa',     # =C3=AA
-        0xeb : b'\xc3\xab',     # =C3=AB
-        0xec : b'\xc3\xac',     # =C3=AC
-        0xed : b'\xc3\xad',     # =C3=AD
-        0xee : b'\xc3\xae',     # =C3=AE
-        0xef : b'\xc3\xaf',     # =C3=AF
-        0xf0 : b'\xc3\xb0',     # =C3=B0
-        0xf1 : b'\xc3\xb1',     # =C3=B1
-        0xf2 : b'\xc3\xb2',     # =C3=B2
-        0xf3 : b'\xc3\xb3',     # =C3=B3
-        0xf4 : b'\xc3\xb4',     # =C3=B4
-        0xf5 : b'\xc3\xb5',     # =C3=B5
-        0xf6 : b'\xc3\xb6',     # =C3=B6
-        0xf7 : b'\xc3\xb7',     # =C3=B7
-        0xf8 : b'\xc3\xb8',     # =C3=B8
-        0xf9 : b'\xc3\xb9',     # =C3=B9
-        0xfa : b'\xc3\xba',     # =C3=BA
-        0xfb : b'\xc3\xbb',     # =C3=BB
-        0xfc : b'\xc3\xbc',     # =C3=BC
-        0xfd : b'\xc3\xbd',     # =C3=BD
-        0xfe : b'\xc3\xbe',     # =C3=BE
-        }
-
-    MULTIBYTE_MARKERS_AND_SIZES =3D [
-        (0xc2, 0xdf, 2), # 2-byte characters start with a byte C2-DF
-        (0xe0, 0xef, 3), # 3-byte characters start with E0-EF
-        (0xf0, 0xf4, 4), # 4-byte characters start with F0-F4
-        ]
-
-    FIRST_MULTIBYTE_MARKER =3D MULTIBYTE_MARKERS_AND_SIZES[0][0]
-    LAST_MULTIBYTE_MARKER =3D MULTIBYTE_MARKERS_AND_SIZES[-1][1]
+    # "A noncharacter is a code point that is in the range
+    # U+FDD0 to U+FDEF, inclusive, or U+FFFE, U+FFFF, U+1FFFE,
+    # U+1FFFF, U+2FFFE, U+2FFFF, U+3FFFE, U+3FFFF, U+4FFFE,
+    # U+4FFFF, U+5FFFE, U+5FFFF, U+6FFFE, U+6FFFF, U+7FFFE,
+    # U+7FFFF, U+8FFFE, U+8FFFF, U+9FFFE, U+9FFFF, U+AFFFE,
+    # U+AFFFF, U+BFFFE, U+BFFFF, U+CFFFE, U+CFFFF, U+DFFFE,
+    # U+DFFFF, U+EFFFE, U+EFFFF, U+FFFFE, U+FFFFF, U+10FFFE,
+    # or U+10FFFF."
+    ENUMERATED_NONCHARACTERS: Set[int] =3D set([0xfffe, 0xffff,
+                                              0x1fffe, 0x1ffff,
+                                              0x2fffe, 0x2ffff,
+                                              0x3fffe, 0x3ffff,
+                                              0x4fffe, 0x4ffff,
+                                              0x5fffe, 0x5ffff,
+                                              0x6fffe, 0x6ffff,
+                                              0x7fffe, 0x7ffff,
+                                              0x8fffe, 0x8ffff,
+                                              0x9fffe, 0x9ffff,
+                                              0xafffe, 0xaffff,
+                                              0xbfffe, 0xbffff,
+                                              0xcfffe, 0xcffff,
+                                              0xdfffe, 0xdffff,
+                                              0xefffe, 0xeffff,
+                                              0xffffe, 0xfffff,
+                                              0x10fffe, 0x10ffff])
+
+    #: :meta private:
+    MULTIBYTE_MARKERS_AND_SIZES: List[Tuple[int, int, int]] =3D [
+        (0xC2, 0xDF, 2),  # 2-byte characters start with a byte C2-DF
+        (0xE0, 0xEF, 3),  # 3-byte characters start with E0-EF
+        (0xF0, 0xF4, 4),  # 4-byte characters start with F0-F4
+    ]
+
+    #: :meta private:
+    FIRST_MULTIBYTE_MARKER: int =3D MULTIBYTE_MARKERS_AND_SIZES[0][0]
+
+    #: :meta private:
+    LAST_MULTIBYTE_MARKER: int =3D MULTIBYTE_MARKERS_AND_SIZES[-1][1]
=20
     @classmethod
-    def detwingle(cls, in_bytes, main_encoding=3D"utf8",
-                  embedded_encoding=3D"windows-1252"):
+    def numeric_character_reference(cls, numeric:int) -> Tuple[str, bool=
]:
+        """This (mostly) implements the algorithm described in "Numeric =
character
+        reference end state" from the HTML spec:
+        https://html.spec.whatwg.org/multipage/parsing.html#numeric-char=
acter-reference-end-state
+
+        The algorithm is designed to convert numeric character reference=
s like "&#9731;"
+        to Unicode characters like "=E2=98=83".
+
+        :return: A 2-tuple (character, replaced). `character` is the Uni=
code
+        character corresponding to the numeric reference and `replaced` =
is
+        whether or not an unresolvable character was replaced with REPLA=
CEMENT
+        CHARACTER.
+        """
+        replacement =3D "\ufffd"
+
+        if numeric =3D=3D 0x00:
+            # "If the number is 0x00, then this is a
+            # null-character-reference parse error. Set the character
+            # reference code to 0xFFFD."
+            return replacement, True
+
+        if numeric > 0x10ffff:
+            # "If the number is greater than 0x10FFFF, then this is a
+            # character-reference-outside-unicode-range parse
+            # error. Set the character reference code to 0xFFFD."
+            return replacement, True
+
+        if numeric >=3D 0xd800 and numeric <=3D 0xdfff:
+            # "If the number is a surrogate, then this is a
+            # surrogate-character-reference parse error. Set the
+            # character reference code to 0xFFFD."
+            return replacement, True
+
+        if (numeric >=3D 0xfdd0 and numeric <=3D 0xfdef) or numeric in c=
ls.ENUMERATED_NONCHARACTERS:
+            # "If the number is a noncharacter, then this is a
+            # noncharacter-character-reference parse error."
+            #
+            # "The parser resolves such character references as-is."
+            #
+            # I'm not sure what "as-is" means but I think it means that =
we act
+            # like there was no error condition.
+            return chr(numeric), False
+
+        # "If the number is 0x0D, or a control that's not ASCII whitespa=
ce,
+        # then this is a control-character-reference parse error."
+        #
+        # "A control is a C0 control or a code point in the range
+        # U+007F DELETE to U+009F APPLICATION PROGRAM COMMAND,
+        # inclusive."
+        #
+        # "A C0 control is a code point in the range U+0000 NULL to U+00=
1F INFORMATION SEPARATOR ONE, inclusive."
+        #
+        # "The parser resolves such character references as-is except C1=
 control references that are replaced."
+
+        # First, let's replace the control references that can be replac=
ed.
+        if numeric >=3D 0x80 and numeric <=3D 0x9f and numeric in cls.WI=
NDOWS_1252_TO_UTF8:
+            # "If the number is one of the numbers in the first column o=
f the
+            # following table, then find the row with that number in the=
 first
+            # column, and set the character reference code to the number=
 in the
+            # second column of that row."
+            #
+            # This is an attempt to catch characters that were encoded t=
o numeric
+            # entities using their Windows-1252 encodings rather than th=
eir UTF-8
+            # encodings.
+            return cls.WINDOWS_1252_TO_UTF8[numeric].decode("utf8"), Fal=
se
+
+        # Now all that's left are references that should be resolved as-=
is. This
+        # is also the default path for non-weird character references.
+        try:
+            return chr(numeric), False
+        except (ValueError, OverflowError):
+            # This shouldn't happen, since these cases should have been =
handled
+            # above, but if it does, return REPLACEMENT CHARACTER
+            return replacement, True
+
+    @classmethod
+    def detwingle(
+        cls,
+        in_bytes: bytes,
+        main_encoding: _Encoding =3D "utf8",
+        embedded_encoding: _Encoding =3D "windows-1252",
+    ) -> bytes:
         """Fix characters from one encoding embedded in some other encod=
ing.
=20
         Currently the only situation supported is Windows-1252 (or its
         subset ISO-8859-1), embedded in UTF-8.
=20
         :param in_bytes: A bytestring that you suspect contains
-            characters from multiple encodings. Note that this _must_
+            characters from multiple encodings. Note that this *must*
             be a bytestring. If you've already converted the document
             to Unicode, you're too late.
-        :param main_encoding: The primary encoding of `in_bytes`.
+        :param main_encoding: The primary encoding of ``in_bytes``.
         :param embedded_encoding: The encoding that was used to embed ch=
aracters
             in the main document.
-        :return: A bytestring in which `embedded_encoding`
-          characters have been converted to their `main_encoding`
-          equivalents.
+        :return: A bytestring similar to ``in_bytes``, in which
+          ``embedded_encoding`` characters have been converted to
+          their ``main_encoding`` equivalents.
         """
-        if embedded_encoding.replace('_', '-').lower() not in (
-            'windows-1252', 'windows_1252'):
+        if embedded_encoding.replace("_", "-").lower() not in (
+            "windows-1252",
+            "windows_1252",
+        ):
             raise NotImplementedError(
                 "Windows-1252 and ISO-8859-1 are the only currently supp=
orted "
-                "embedded encodings.")
+                "embedded encodings."
+            )
=20
-        if main_encoding.lower() not in ('utf8', 'utf-8'):
+        if main_encoding.lower() not in ("utf8", "utf-8"):
             raise NotImplementedError(
-                "UTF-8 is the only currently supported main encoding.")
+                "UTF-8 is the only currently supported main encoding."
+            )
=20
         byte_chunks =3D []
=20
@@ -1061,11 +1496,7 @@ class UnicodeDammit:
         pos =3D 0
         while pos < len(in_bytes):
             byte =3D in_bytes[pos]
-            if not isinstance(byte, int):
-                # Python 2.x
-                byte =3D ord(byte)
-            if (byte >=3D cls.FIRST_MULTIBYTE_MARKER
-                and byte <=3D cls.LAST_MULTIBYTE_MARKER):
+            if byte >=3D cls.FIRST_MULTIBYTE_MARKER and byte <=3D cls.LA=
ST_MULTIBYTE_MARKER:
                 # This is the start of a UTF-8 multibyte character. Skip
                 # to the end.
                 for start, end, size in cls.MULTIBYTE_MARKERS_AND_SIZES:
@@ -1091,5 +1522,4 @@ class UnicodeDammit:
         else:
             # Store the final chunk.
             byte_chunks.append(in_bytes[chunk_start:])
-        return b''.join(byte_chunks)
-
+        return b"".join(byte_chunks)
diff --git a/lib/bb/_vendor/bs4/diagnose.py b/lib/bb/_vendor/bs4/diagnose=
.py
index 76d0be8f1..7c487b3c9 100644
--- a/lib/bb/_vendor/bs4/diagnose.py
+++ b/lib/bb/_vendor/bs4/diagnose.py
@@ -6,10 +6,21 @@ __license__ =3D "MIT"
 import cProfile
 from io import BytesIO
 from html.parser import HTMLParser
-from . import BeautifulSoup, __version__
-from .builder import builder_registry
+from bb._vendor import bs4
+from bb._vendor.bs4 import BeautifulSoup, __version__
+from bb._vendor.bs4.builder import builder_registry
+from typing import (
+    Any,
+    IO,
+    List,
+    Optional,
+    Tuple,
+    TYPE_CHECKING,
+)
+
+if TYPE_CHECKING:
+    from bb._vendor.bs4._typing import _IncomingMarkup
=20
-import os
 import pstats
 import random
 import tempfile
@@ -17,10 +28,11 @@ import time
 import traceback
 import sys
=20
-def diagnose(data):
+
+def diagnose(data: "_IncomingMarkup") -> None:
     """Diagnostic suite for isolating common problems.
=20
-    :param data: A string containing markup that needs to be explained.
+    :param data: Some markup that needs to be explained.
     :return: None; diagnostics are printed to standard output.
     """
     print(("Diagnostic running on Beautiful Soup %s" % __version__))
@@ -33,29 +45,28 @@ def diagnose(data):
                 break
         else:
             basic_parsers.remove(name)
-            print((
-                "I noticed that %s is not installed. Installing it may h=
elp." %
-                name))
+            print(
+                ("I noticed that %s is not installed. Installing it may =
help." % name)
+            )
=20
-    if 'lxml' in basic_parsers:
+    if "lxml" in basic_parsers:
         basic_parsers.append("lxml-xml")
         try:
-            from lxml import etree
-            print(("Found lxml version %s" % ".".join(map(str,etree.LXML=
_VERSION))))
-        except ImportError as e:
-            print(
-                "lxml is not installed or couldn't be imported.")
+            from lxml import etree # type:ignore
=20
+            print(("Found lxml version %s" % ".".join(map(str, etree.LXM=
L_VERSION))))
+        except ImportError:
+            print("lxml is not installed or couldn't be imported.")
=20
-    if 'html5lib' in basic_parsers:
+    if "html5lib" in basic_parsers:
         try:
             import html5lib
+
             print(("Found html5lib version %s" % html5lib.__version__))
-        except ImportError as e:
-            print(
-                "html5lib is not installed or couldn't be imported.")
+        except ImportError:
+            print("html5lib is not installed or couldn't be imported.")
=20
-    if hasattr(data, 'read'):
+    if hasattr(data, "read"):
         data =3D data.read()
=20
     for parser in basic_parsers:
@@ -64,7 +75,7 @@ def diagnose(data):
         try:
             soup =3D BeautifulSoup(data, features=3Dparser)
             success =3D True
-        except Exception as e:
+        except Exception:
             print(("%s could not parse the markup." % parser))
             traceback.print_exc()
         if success:
@@ -73,7 +84,8 @@ def diagnose(data):
=20
         print(("-" * 80))
=20
-def lxml_trace(data, html=3DTrue, **kwargs):
+
+def lxml_trace(data: "_IncomingMarkup", html: bool =3D True, **kwargs: A=
ny) -> None:
     """Print out the lxml events that occur during parsing.
=20
     This lets you see how lxml parses a document when no Beautiful
@@ -86,15 +98,16 @@ def lxml_trace(data, html=3DTrue, **kwargs):
        if False, lxml's XML parser will be used.
     """
     from lxml import etree
-    recover =3D kwargs.pop('recover', True)
+
+    recover =3D kwargs.pop("recover", True)
     if isinstance(data, str):
         data =3D data.encode("utf8")
-    reader =3D BytesIO(data)
-    for event, element in etree.iterparse(
-        reader, html=3Dhtml, recover=3Drecover, **kwargs
-    ):
+    if not isinstance(data, IO):
+        reader =3D BytesIO(data)
+    for event, element in etree.iterparse(reader, html=3Dhtml, recover=3D=
recover, **kwargs):
         print(("%s, %4s, %s" % (event, element.tag, element.text)))
=20
+
 class AnnouncingParser(HTMLParser):
     """Subclass of HTMLParser that announces parse events, without doing
     anything else.
@@ -103,37 +116,43 @@ class AnnouncingParser(HTMLParser):
     document. The easiest way to do this is to call `htmlparser_trace`.
     """
=20
-    def _p(self, s):
+    def _p(self, s: str) -> None:
         print(s)
=20
-    def handle_starttag(self, name, attrs):
-        self._p("%s START" % name)
+    def handle_starttag(
+        self,
+        name: str,
+        attrs: List[Tuple[str, Optional[str]]],
+        handle_empty_element: bool =3D True,
+    ) -> None:
+        self._p(f"{name} {attrs} START")
=20
-    def handle_endtag(self, name):
+    def handle_endtag(self, name: str, check_already_closed: bool =3D Tr=
ue) -> None:
         self._p("%s END" % name)
=20
-    def handle_data(self, data):
+    def handle_data(self, data: str) -> None:
         self._p("%s DATA" % data)
=20
-    def handle_charref(self, name):
+    def handle_charref(self, name: str) -> None:
         self._p("%s CHARREF" % name)
=20
-    def handle_entityref(self, name):
+    def handle_entityref(self, name: str) -> None:
         self._p("%s ENTITYREF" % name)
=20
-    def handle_comment(self, data):
+    def handle_comment(self, data: str) -> None:
         self._p("%s COMMENT" % data)
=20
-    def handle_decl(self, data):
+    def handle_decl(self, data: str) -> None:
         self._p("%s DECL" % data)
=20
-    def unknown_decl(self, data):
+    def unknown_decl(self, data: str) -> None:
         self._p("%s UNKNOWN-DECL" % data)
=20
-    def handle_pi(self, data):
+    def handle_pi(self, data: str) -> None:
         self._p("%s PI" % data)
=20
-def htmlparser_trace(data):
+
+def htmlparser_trace(data: str) -> None:
     """Print out the HTMLParser events that occur during parsing.
=20
     This lets you see how HTMLParser parses a document when no
@@ -144,12 +163,17 @@ def htmlparser_trace(data):
     parser =3D AnnouncingParser()
     parser.feed(data)
=20
-_vowels =3D "aeiou"
-_consonants =3D "bcdfghjklmnpqrstvwxyz"
=20
-def rword(length=3D5):
-    "Generate a random word-like string."
-    s =3D ''
+_vowels: str =3D "aeiou"
+_consonants: str =3D "bcdfghjklmnpqrstvwxyz"
+
+
+def rword(length: int =3D 5) -> str:
+    """Generate a random word-like string.
+
+    :meta private:
+    """
+    s =3D ""
     for i in range(length):
         if i % 2 =3D=3D 0:
             t =3D _consonants
@@ -158,74 +182,87 @@ def rword(length=3D5):
         s +=3D random.choice(t)
     return s
=20
-def rsentence(length=3D4):
-    "Generate a random sentence-like string."
-    return " ".join(rword(random.randint(4,9)) for i in range(length))
-       =20
-def rdoc(num_elements=3D1000):
-    """Randomly generate an invalid HTML document."""
-    tag_names =3D ['p', 'div', 'span', 'i', 'b', 'script', 'table']
+
+def rsentence(length: int =3D 4) -> str:
+    """Generate a random sentence-like string.
+
+    :meta private:
+    """
+    return " ".join(rword(random.randint(4, 9)) for i in range(length))
+
+
+def rdoc(num_elements: int =3D 1000) -> str:
+    """Randomly generate an invalid HTML document.
+
+    :meta private:
+    """
+    tag_names =3D ["p", "div", "span", "i", "b", "script", "table"]
     elements =3D []
     for i in range(num_elements):
-        choice =3D random.randint(0,3)
+        choice =3D random.randint(0, 3)
         if choice =3D=3D 0:
             # New tag.
             tag_name =3D random.choice(tag_names)
             elements.append("<%s>" % tag_name)
         elif choice =3D=3D 1:
-            elements.append(rsentence(random.randint(1,4)))
+            elements.append(rsentence(random.randint(1, 4)))
         elif choice =3D=3D 2:
             # Close a tag.
             tag_name =3D random.choice(tag_names)
             elements.append("</%s>" % tag_name)
     return "<html>" + "\n".join(elements) + "</html>"
=20
-def benchmark_parsers(num_elements=3D100000):
+
+def benchmark_parsers(num_elements: int =3D 100000) -> None:
     """Very basic head-to-head performance benchmark."""
     print(("Comparative parser benchmark on Beautiful Soup %s" % __versi=
on__))
     data =3D rdoc(num_elements)
     print(("Generated a large invalid HTML document (%d bytes)." % len(d=
ata)))
-   =20
-    for parser in ["lxml", ["lxml", "html"], "html5lib", "html.parser"]:
+
+    for parser_name in ["lxml", ["lxml", "html"], "html5lib", "html.pars=
er"]:
         success =3D False
         try:
             a =3D time.time()
-            soup =3D BeautifulSoup(data, parser)
+            BeautifulSoup(data, parser_name)
             b =3D time.time()
             success =3D True
-        except Exception as e:
-            print(("%s could not parse the markup." % parser))
+        except Exception:
+            print(("%s could not parse the markup." % parser_name))
             traceback.print_exc()
         if success:
-            print(("BS4+%s parsed the markup in %.2fs." % (parser, b-a))=
)
+            print(("BS4+%s parsed the markup in %.2fs." % (parser_name, =
b - a)))
=20
     from lxml import etree
+
     a =3D time.time()
     etree.HTML(data)
     b =3D time.time()
-    print(("Raw lxml parsed the markup in %.2fs." % (b-a)))
+    print(("Raw lxml parsed the markup in %.2fs." % (b - a)))
=20
     import html5lib
+
     parser =3D html5lib.HTMLParser()
     a =3D time.time()
     parser.parse(data)
     b =3D time.time()
-    print(("Raw html5lib parsed the markup in %.2fs." % (b-a)))
+    print(("Raw html5lib parsed the markup in %.2fs." % (b - a)))
+
=20
-def profile(num_elements=3D100000, parser=3D"lxml"):
+def profile(num_elements: int =3D 100000, parser: str =3D "lxml") -> Non=
e:
     """Use Python's profiler on a randomly generated document."""
     filehandle =3D tempfile.NamedTemporaryFile()
     filename =3D filehandle.name
=20
     data =3D rdoc(num_elements)
-    vars =3D dict(BeautifulSoup=3DBeautifulSoup, data=3Ddata, parser=3Dp=
arser)
-    cProfile.runctx('BeautifulSoup(data, parser)' , vars, vars, filename=
)
+    vars =3D dict(bs4=3Dbs4, data=3Ddata, parser=3Dparser)
+    cProfile.runctx("bs4.BeautifulSoup(data, parser)", vars, vars, filen=
ame)
=20
     stats =3D pstats.Stats(filename)
     # stats.strip_dirs()
     stats.sort_stats("cumulative")
-    stats.print_stats('_html5lib|bs4', 50)
+    stats.print_stats("_html5lib|bs4", 50)
+
=20
 # If this file is run as a script, standard input is diagnosed.
-if __name__ =3D=3D '__main__':
+if __name__ =3D=3D "__main__":
     diagnose(sys.stdin.read())
diff --git a/lib/bb/_vendor/bs4/element.py b/lib/bb/_vendor/bs4/element.p=
y
index 38ca2dc27..8e63ecd73 100644
--- a/lib/bb/_vendor/bs4/element.py
+++ b/lib/bb/_vendor/bs4/element.py
@@ -1,76 +1,159 @@
+from __future__ import annotations
+
 # Use of this source code is governed by the MIT license.
 __license__ =3D "MIT"
=20
-try:
-    from collections.abc import Callable # Python 3.6
-except ImportError as e:
-    from collections import Callable
+import inspect
 import re
-import sys
 import warnings
=20
-from .css import CSS
-from .formatter import (
+from bb._vendor.bs4.css import CSS
+from bb._vendor.bs4._deprecation import (
+    _deprecated,
+    _deprecated_alias,
+    _deprecated_function_alias,
+)
+from bb._vendor.bs4.formatter import (
     Formatter,
     HTMLFormatter,
     XMLFormatter,
 )
+from bb._vendor.bs4._warnings import AttributeResemblesVariableWarning
+
+from typing import (
+    Any,
+    Callable,
+    Dict,
+    Generic,
+    Iterable,
+    Iterator,
+    List,
+    Mapping,
+    MutableSequence,
+    Optional,
+    Pattern,
+    Set,
+    TYPE_CHECKING,
+    Tuple,
+    Type,
+    TypeVar,
+    Union,
+    cast,
+    overload,
+)
+from typing_extensions import (
+    Self,
+    TypeAlias,
+)
=20
-DEFAULT_OUTPUT_ENCODING =3D "utf-8"
-
-nonwhitespace_re =3D re.compile(r"\S+")
-
-# NOTE: This isn't used as of 4.7.0. I'm leaving it for a little bit on
-# the off chance someone imported it for their own use.
-whitespace_re =3D re.compile(r"\s+")
-
-def _alias(attr):
-    """Alias one attribute name to another for backward compatibility"""
-    @property
-    def alias(self):
-        return getattr(self, attr)
-
-    @alias.setter
-    def alias(self):
-        return setattr(self, attr)
-    return alias
-
-
-# These encodings are recognized by Python (so PageElement.encode
-# could theoretically support them) but XML and HTML don't recognize
-# them (so they should not show up in an XML or HTML document as that
-# document's encoding).
-#
-# If an XML document is encoded in one of these encodings, no encoding
-# will be mentioned in the XML declaration. If an HTML document is
-# encoded in one of these encodings, and the HTML document has a
-# <meta> tag that mentions an encoding, the encoding will be given as
-# the empty string.
-#
-# Source:
-# https://docs.python.org/3/library/codecs.html#python-specific-encoding=
s
-PYTHON_SPECIFIC_ENCODINGS =3D set([
-    "idna",
-    "mbcs",
-    "oem",
-    "palmos",
-    "punycode",
-    "raw_unicode_escape",
-    "undefined",
-    "unicode_escape",
-    "raw-unicode-escape",
-    "unicode-escape",
-    "string-escape",
-    "string_escape",
-])
+if TYPE_CHECKING:
+    from bb._vendor.bs4 import BeautifulSoup
+    from bb._vendor.bs4.builder import TreeBuilder
+    from bb._vendor.bs4.filter import ElementFilter
+    from bb._vendor.bs4.formatter import (
+        _EntitySubstitutionFunction,
+        _FormatterOrName,
+    )
+    from bb._vendor.bs4._typing import (
+        _AtMostOneElement,
+        _AtMostOneNavigableString,
+        _AtMostOneTag,
+        _AttributeValue,
+        _AttributeValues,
+        _Encoding,
+        _InsertableElement,
+        _OneElement,
+        _QueryResults,
+        _RawAttributeValue,
+        _RawAttributeValues,
+        _RawOrProcessedAttributeValues,
+        _SomeNavigableStrings,
+        _SomeTags,
+        _StrainableAttribute,
+        _StrainableAttributes,
+        _StrainableElement,
+        _StrainableString,
+    )
+
+_OneOrMoreStringTypes: TypeAlias =3D Union[
+    Type["NavigableString"], Iterable[Type["NavigableString"]]
+]
+
+_FindMethodName: TypeAlias =3D Union["_StrainableElement", "ElementFilte=
r"]
+_OptionalFindMethodName: TypeAlias =3D Optional[_FindMethodName]
+
+# Deprecated module-level attributes.
+# See https://peps.python.org/pep-0562/
+_deprecated_names =3D dict(
+    whitespace_re=3D"The {name} attribute was deprecated in version 4.7.=
0. If you need it, make your own copy."
+)
+#: :meta private:
+_deprecated_whitespace_re: Pattern[str] =3D re.compile(r"\s+")
+
+
+def __getattr__(name: str) -> Any:
+    if name in _deprecated_names:
+        message =3D _deprecated_names[name]
+        warnings.warn(message.format(name=3Dname), DeprecationWarning, s=
tacklevel=3D2)
+
+        return globals()[f"_deprecated_{name}"]
+    raise AttributeError(f"module {__name__!r} has no attribute {name!r}=
")
+
+
+#: Documents output by Beautiful Soup will be encoded with
+#: this encoding unless you specify otherwise.
+DEFAULT_OUTPUT_ENCODING: str =3D "utf-8"
+
+#: A regular expression that can be used to split on whitespace.
+nonwhitespace_re: Pattern[str] =3D re.compile(r"\S+")
+
+#: These encodings are recognized by Python (so `Tag.encode`
+#: could theoretically support them) but XML and HTML don't recognize
+#: them (so they should not show up in an XML or HTML document as that
+#: document's encoding).
+#:
+#: If an XML document is encoded in one of these encodings, no encoding
+#: will be mentioned in the XML declaration. If an HTML document is
+#: encoded in one of these encodings, and the HTML document has a
+#: <meta> tag that mentions an encoding, the encoding will be given as
+#: the empty string.
+#:
+#: Source:
+#: Python documentation, `Python Specific Encodings <https://docs.python=
.org/3/library/codecs.html#python-specific-encodings>`_
+PYTHON_SPECIFIC_ENCODINGS: Set[_Encoding] =3D set(
+    [
+        "idna",
+        "mbcs",
+        "oem",
+        "palmos",
+        "punycode",
+        "raw_unicode_escape",
+        "undefined",
+        "unicode_escape",
+        "raw-unicode-escape",
+        "unicode-escape",
+        "string-escape",
+        "string_escape",
+    ]
+)
=20
=20
 class NamespacedAttribute(str):
-    """A namespaced string (e.g. 'xml:lang') that remembers the namespac=
e
-    ('xml') and the name ('lang') that were used to create it.
+    """A namespaced attribute (e.g. the 'xml:lang' in 'xml:lang=3D"en"')
+    which remembers the namespace prefix ('xml') and the name ('lang')
+    that were used to create it.
     """
=20
-    def __new__(cls, prefix, name=3DNone, namespace=3DNone):
+    prefix: Optional[str]
+    name: Optional[str]
+    namespace: Optional[str]
+
+    def __new__(
+        cls,
+        prefix: Optional[str],
+        name: Optional[str] =3D None,
+        namespace: Optional[str] =3D None,
+    ) -> Self:
         if not name:
             # This is the default namespace. Its name "has no value"
             # per https://www.w3.org/TR/xml-names/#defaulting
@@ -88,73 +171,226 @@ class NamespacedAttribute(str):
         obj.namespace =3D namespace
         return obj
=20
+
 class AttributeValueWithCharsetSubstitution(str):
-    """A stand-in object for a character encoding specified in HTML."""
+    """An abstract class standing in for a character encoding specified
+    inside an HTML ``<meta>`` tag.
+
+    Subclasses exist for each place such a character encoding might be
+    found: either inside the ``charset`` attribute
+    (`CharsetMetaAttributeValue`) or inside the ``content`` attribute
+    (`ContentMetaAttributeValue`)
+
+    This allows Beautiful Soup to replace that part of the HTML file
+    with a different encoding when ouputting a tree as a string.
+    """
+
+    # The original, un-encoded value of the ``content`` attribute.
+    #: :meta private:
+    original_value: str
+
+    def substitute_encoding(self, eventual_encoding: str) -> str:
+        """Do whatever's necessary in this implementation-specific
+        portion an HTML document to substitute in a specific encoding.
+        """
+        raise NotImplementedError()
+
=20
 class CharsetMetaAttributeValue(AttributeValueWithCharsetSubstitution):
-    """A generic stand-in for the value of a meta tag's 'charset' attrib=
ute.
+    """A generic stand-in for the value of a ``<meta>`` tag's ``charset`=
`
+    attribute.
=20
-    When Beautiful Soup parses the markup '<meta charset=3D"utf8">', the
-    value of the 'charset' attribute will be one of these objects.
+    When Beautiful Soup parses the markup ``<meta charset=3D"utf8">``, t=
he
+    value of the ``charset`` attribute will become one of these objects.
+
+    If the document is later encoded to an encoding other than UTF-8, it=
s
+    ``<meta>`` tag will mention the new encoding instead of ``utf8``.
     """
=20
-    def __new__(cls, original_value):
+    def __new__(cls, original_value: str) -> Self:
+        # We don't need to use the original value for anything, but
+        # it might be useful for the user to know.
         obj =3D str.__new__(cls, original_value)
         obj.original_value =3D original_value
         return obj
=20
-    def encode(self, encoding):
+    def substitute_encoding(self, eventual_encoding: _Encoding =3D "utf-=
8") -> str:
         """When an HTML document is being encoded to a given encoding, t=
he
-        value of a meta tag's 'charset' is the name of the encoding.
+        value of a ``<meta>`` tag's ``charset`` becomes the name of
+        the encoding.
+        """
+        if eventual_encoding in PYTHON_SPECIFIC_ENCODINGS:
+            return ""
+        return eventual_encoding
+
+
+class AttributeValueList(List[str]):
+    """Class for the list used to hold the values of attributes which
+    have multiple values (such as HTML's 'class'). It's just a regular
+    list, but you can subclass it and pass it in to the TreeBuilder
+    constructor as attribute_value_list_class, to have your subclass
+    instantiated instead.
+    """
+
+
+class AttributeDict(Dict[Any,Any]):
+    """Superclass for the dictionary used to hold a tag's
+    attributes. You can use this, but it's just a regular dict with no
+    special logic.
+    """
+
+
+class XMLAttributeDict(AttributeDict):
+    """A dictionary for holding a Tag's attributes, which processes
+    incoming values for consistency with the HTML spec.
+    """
+
+    def __setitem__(self, key: str, value: Any) -> None:
+        """Set an attribute value, possibly modifying it to comply with
+        the XML spec.
+
+        This just means converting common non-string values to
+        strings: XML attributes may have "any literal string as a
+        value."
+        """
+        if value is None:
+            value =3D ""
+        if isinstance(value, bool):
+            # XML does not define any rules for boolean attributes.
+            # Preserve the old Beautiful Soup behavior (a bool that
+            # gets converted to a string on output) rather than
+            # guessing what the value should be.
+            pass
+        elif isinstance(value, (int, float)):
+            # It's dangerous to convert _every_ attribute value into a
+            # plain string, since an attribute value may be a more
+            # sophisticated string-like object
+            # (e.g. CharsetMetaAttributeValue). But we can definitely
+            # convert numeric values and booleans, which are the most co=
mmon.
+            value =3D str(value)
+
+        super().__setitem__(key, value)
+
+
+class HTMLAttributeDict(AttributeDict):
+    """A dictionary for holding a Tag's attributes, which processes
+    incoming values for consistency with the HTML spec, which says
+    'Attribute values are a mixture of text and character
+    references...'
+
+    Basically, this means converting common non-string values into
+    strings, like XMLAttributeDict, though HTML also has some rules
+    around boolean attributes that XML doesn't have.
+    """
+
+    def __setitem__(self, key: str, value: Any) -> None:
+        """Set an attribute value, possibly modifying it to comply
+        with the HTML spec,
         """
-        if encoding in PYTHON_SPECIFIC_ENCODINGS:
-            return ''
-        return encoding
+        if value in (False, None):
+            # 'The values "true" and "false" are not allowed on
+            # boolean attributes. To represent a false value, the
+            # attribute has to be omitted altogether.'
+            if key in self:
+                del self[key]
+            return
+        if isinstance(value, bool):
+            # 'If the [boolean] attribute is present, its value must
+            # either be the empty string or a value that is an ASCII
+            # case-insensitive match for the attribute's canonical
+            # name, with no leading or trailing whitespace.'
+            #
+            # [fixme] It's not clear to me whether "canonical name"
+            # means fully-qualified name, unqualified name, or
+            # (probably not) name with namespace prefix. For now I'm
+            # going with unqualified name.
+            if isinstance(key, NamespacedAttribute):
+                value =3D key.name
+            else:
+                value =3D key
+        elif isinstance(value, (int, float)):
+            # See note in XMLAttributeDict for the reasoning why we
+            # only do this to numbers.
+            value =3D str(value)
+        super().__setitem__(key, value)
=20
=20
 class ContentMetaAttributeValue(AttributeValueWithCharsetSubstitution):
-    """A generic stand-in for the value of a meta tag's 'content' attrib=
ute.
+    """A generic stand-in for the value of a ``<meta>`` tag's ``content`=
`
+    attribute.
=20
     When Beautiful Soup parses the markup:
-     <meta http-equiv=3D"content-type" content=3D"text/html; charset=3Du=
tf8">
+     ``<meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf8">``
=20
-    The value of the 'content' attribute will be one of these objects.
-    """
+    The value of the ``content`` attribute will become one of these obje=
cts.
=20
-    CHARSET_RE =3D re.compile(r"((^|;)\s*charset=3D)([^;]*)", re.M)
+    If the document is later encoded to an encoding other than UTF-8, it=
s
+    ``<meta>`` tag will mention the new encoding instead of ``utf8``.
+    """
=20
-    def __new__(cls, original_value):
-        match =3D cls.CHARSET_RE.search(original_value)
-        if match is None:
-            # No substitution necessary.
-            return str.__new__(str, original_value)
+    #: Match the 'charset' argument inside the 'content' attribute
+    #: of a <meta> tag.
+    #: :meta private:
+    CHARSET_RE: Pattern[str] =3D re.compile(r"((^|;)\s*charset=3D)([^;]*=
)", re.M)
=20
+    def __new__(cls, original_value: str) -> Self:
+        cls.CHARSET_RE.search(original_value)
         obj =3D str.__new__(cls, original_value)
         obj.original_value =3D original_value
         return obj
=20
-    def encode(self, encoding):
-        if encoding in PYTHON_SPECIFIC_ENCODINGS:
-            return ''
-        def rewrite(match):
-            return match.group(1) + encoding
+    def substitute_encoding(self, eventual_encoding: _Encoding =3D "utf-=
8") -> str:
+        """When an HTML document is being encoded to a given encoding, t=
he
+        value of the ``charset=3D`` in a ``<meta>`` tag's ``content`` be=
comes
+        the name of the encoding.
+        """
+        if eventual_encoding in PYTHON_SPECIFIC_ENCODINGS:
+            return self.CHARSET_RE.sub("", self.original_value)
+
+        def rewrite(match: re.Match[str]) -> str:
+            return match.group(1) + eventual_encoding
+
         return self.CHARSET_RE.sub(rewrite, self.original_value)
=20
=20
 class PageElement(object):
-    """Contains the navigational information for some part of the page:
-    that is, its current location in the parse tree.
+    """An abstract class representing a single element in the parse tree.
=20
-    NavigableString, Tag, etc. are all subclasses of PageElement.
+    `NavigableString`, `Tag`, etc. are all subclasses of
+    `PageElement`. For this reason you'll see a lot of methods that
+    return `PageElement`, but you'll never see an actual `PageElement`
+    object. For the most part you can think of `PageElement` as
+    meaning "a `Tag` or a `NavigableString`."
     """
=20
-    # In general, we can't tell just by looking at an element whether
-    # it's contained in an XML document or an HTML document. But for
-    # Tags (q.v.) we can store this information at parse time.
-    known_xml =3D None
-
-    def setup(self, parent=3DNone, previous_element=3DNone, next_element=
=3DNone,
-              previous_sibling=3DNone, next_sibling=3DNone):
+    #: In general, we can't tell just by looking at an element whether
+    #: it's contained in an XML document or an HTML document. But for
+    #: `Tag` objects (q.v.) we can store this information at parse time.
+    #: :meta private:
+    known_xml: Optional[bool] =3D None
+
+    #: Whether or not this element has been decomposed from the tree
+    #: it was created in.
+    _decomposed: bool
+
+    parent: Optional[Tag]
+    next_element: _AtMostOneElement
+    previous_element: _AtMostOneElement
+    next_sibling: _AtMostOneElement
+    previous_sibling: _AtMostOneElement
+
+    #: Whether or not this element is hidden from generated output.
+    #: Only the `BeautifulSoup` object itself is hidden.
+    hidden: bool =3D False
+
+    def setup(
+        self,
+        parent: Optional[Tag] =3D None,
+        previous_element: _AtMostOneElement =3D None,
+        next_element: _AtMostOneElement =3D None,
+        previous_sibling: _AtMostOneElement =3D None,
+        next_sibling: _AtMostOneElement =3D None,
+    ) -> None:
         """Sets up the initial relations between this element and
         other elements.
=20
@@ -163,7 +399,7 @@ class PageElement(object):
         :param previous_element: The element parsed immediately before
             this one.
=20
-        :param next_element: The element parsed immediately before
+        :param next_element: The element parsed immediately after
             this one.
=20
         :param previous_sibling: The most recently encountered element
@@ -175,7 +411,7 @@ class PageElement(object):
         self.parent =3D parent
=20
         self.previous_element =3D previous_element
-        if previous_element is not None:
+        if self.previous_element is not None:
             self.previous_element.next_element =3D self
=20
         self.next_element =3D next_element
@@ -186,15 +422,18 @@ class PageElement(object):
         if self.next_sibling is not None:
             self.next_sibling.previous_sibling =3D self
=20
-        if (previous_sibling is None
-            and self.parent is not None and self.parent.contents):
+        if (
+            previous_sibling is None
+            and self.parent is not None
+            and self.parent.contents
+        ):
             previous_sibling =3D self.parent.contents[-1]
=20
         self.previous_sibling =3D previous_sibling
-        if previous_sibling is not None:
+        if self.previous_sibling is not None:
             self.previous_sibling.next_sibling =3D self
=20
-    def format_string(self, s, formatter):
+    def format_string(self, s: str, formatter: Optional[_FormatterOrName=
]) -> str:
         """Format the given string using the given formatter.
=20
         :param s: A string.
@@ -207,28 +446,36 @@ class PageElement(object):
         output =3D formatter.substitute(s)
         return output
=20
-    def formatter_for_name(self, formatter):
+    def formatter_for_name(
+        self, formatter_name: Union[_FormatterOrName, _EntitySubstitutio=
nFunction]
+    ) -> Formatter:
         """Look up or create a Formatter for the given identifier,
         if necessary.
=20
-        :param formatter: Can be a Formatter object (used as-is), a
+        :param formatter: Can be a `Formatter` object (used as-is), a
             function (used as the entity substitution hook for an
-            XMLFormatter or HTMLFormatter), or a string (used to look
-            up an XMLFormatter or HTMLFormatter in the appropriate
-            registry.
+            `bs4.formatter.XMLFormatter` or
+            `bs4.formatter.HTMLFormatter`), or a string (used to look
+            up an `bs4.formatter.XMLFormatter` or
+            `bs4.formatter.HTMLFormatter` in the appropriate registry.
+
         """
-        if isinstance(formatter, Formatter):
-            return formatter
+        if isinstance(formatter_name, Formatter):
+            return formatter_name
+        c: type[Formatter]
+        registry: Mapping[Optional[str], Formatter]
         if self._is_xml:
             c =3D XMLFormatter
+            registry =3D XMLFormatter.REGISTRY
         else:
             c =3D HTMLFormatter
-        if isinstance(formatter, Callable):
-            return c(entity_substitution=3Dformatter)
-        return c.REGISTRY[formatter]
+            registry =3D HTMLFormatter.REGISTRY
+        if callable(formatter_name):
+            return c(entity_substitution=3Dformatter_name)
+        return registry[formatter_name]
=20
     @property
-    def _is_xml(self):
+    def _is_xml(self) -> bool:
         """Is this element part of an XML tree or an HTML tree?
=20
         This is used in formatter_for_name, when deciding whether an
@@ -247,31 +494,49 @@ class PageElement(object):
             # This is the top-level object. It should have .known_xml se=
t
             # from tree creation. If not, take a guess--BS is usually
             # used on HTML markup.
-            return getattr(self, 'is_xml', False)
+            return getattr(self, "is_xml", False)
         return self.parent._is_xml
=20
-    nextSibling =3D _alias("next_sibling")  # BS3
-    previousSibling =3D _alias("previous_sibling")  # BS3
+    nextSibling =3D _deprecated_alias("nextSibling", "next_sibling", "4.=
0.0")
+    previousSibling =3D _deprecated_alias("previousSibling", "previous_s=
ibling", "4.0.0")
+
+    def __deepcopy__(self, memo: Dict[Any, Any], recursive: bool =3D Fal=
se) -> Self:
+        raise NotImplementedError()
+
+    def __copy__(self) -> Self:
+        """A copy of a PageElement can only be a deep copy, because
+        only one PageElement can occupy a given place in a parse tree.
+        """
+        return self.__deepcopy__({})
+
+    default: Iterable[type[NavigableString]] =3D tuple()  #: :meta priva=
te:
=20
-    default =3D object()
-    def _all_strings(self, strip=3DFalse, types=3Ddefault):
+    def _all_strings(
+        self, strip: bool =3D False, types: Iterable[type[NavigableStrin=
g]] =3D default
+    ) -> Iterator[str]:
         """Yield all strings of certain classes, possibly stripping them.
=20
-        This is implemented differently in Tag and NavigableString.
+        This is implemented differently in `Tag` and `NavigableString`.
         """
         raise NotImplementedError()
=20
     @property
-    def stripped_strings(self):
-        """Yield all strings in this PageElement, stripping them first.
+    def stripped_strings(self) -> Iterator[str]:
+        """Yield all interesting strings in this PageElement, stripping =
them
+        first.
=20
-        :yield: A sequence of stripped strings.
+        See `Tag` for information on which strings are considered
+        interesting in a given context.
         """
         for string in self._all_strings(True):
             yield string
=20
-    def get_text(self, separator=3D"", strip=3DFalse,
-                 types=3Ddefault):
+    def get_text(
+        self,
+        separator: str =3D "",
+        strip: bool =3D False,
+        types: Iterable[Type[NavigableString]] =3D default,
+    ) -> str:
         """Get all child strings of this PageElement, concatenated using=
 the
         given separator.
=20
@@ -289,24 +554,28 @@ class PageElement(object):
=20
         :return: A string.
         """
-        return separator.join([s for s in self._all_strings(
-                    strip, types=3Dtypes)])
+        return separator.join([s for s in self._all_strings(strip, types=
=3Dtypes)])
+
     getText =3D get_text
-    text =3D property(get_text)
=20
-    def replace_with(self, *args):
-        """Replace this PageElement with one or more PageElements, keepi=
ng the
-        rest of the tree the same.
+    @property
+    def text(self) -> str:
+        return self.get_text()
+
+    def replace_with(self, *args: _InsertableElement) -> Self:
+        """Replace this `PageElement` with one or more other elements,
+        objects, keeping the rest of the tree the same.
=20
-        :param args: One or more PageElements.
-        :return: `self`, no longer part of the tree.
+        :return: This `PageElement`, no longer part of the tree.
         """
         if self.parent is None:
             raise ValueError(
                 "Cannot replace one element with another when the "
-                "element to be replaced is not part of a tree.")
+                "element to be replaced is not part of a tree."
+            )
         if len(args) =3D=3D 1 and args[0] is self:
-            return
+            # Replacing an element with itself is a no-op.
+            return self
         if any(x is self.parent for x in args):
             raise ValueError("Cannot replace a Tag with its parent.")
         old_parent =3D self.parent
@@ -315,81 +584,107 @@ class PageElement(object):
         for idx, replace_with in enumerate(args, start=3Dmy_index):
             old_parent.insert(idx, replace_with)
         return self
-    replaceWith =3D replace_with  # BS3
-
-    def unwrap(self):
-        """Replace this PageElement with its contents.
=20
-        :return: `self`, no longer part of the tree.
-        """
-        my_parent =3D self.parent
-        if self.parent is None:
-            raise ValueError(
-                "Cannot replace an element with its contents when that"
-                "element is not part of a tree.")
-        my_index =3D self.parent.index(self)
-        self.extract(_self_index=3Dmy_index)
-        for child in reversed(self.contents[:]):
-            my_parent.insert(my_index, child)
-        return self
-    replace_with_children =3D unwrap
-    replaceWithChildren =3D unwrap  # BS3
+    replaceWith =3D _deprecated_function_alias("replaceWith", "replace_w=
ith", "4.0.0")
=20
-    def wrap(self, wrap_inside):
-        """Wrap this PageElement inside another one.
+    def wrap(self, wrap_inside: Tag) -> Tag:
+        """Wrap this `PageElement` inside a `Tag`.
=20
-        :param wrap_inside: A PageElement.
-        :return: `wrap_inside`, occupying the position in the tree that =
used
-           to be occupied by `self`, and with `self` inside it.
+        :return: ``wrap_inside``, occupying the position in the tree tha=
t used
+           to be occupied by this object, and with this object now insid=
e it.
         """
         me =3D self.replace_with(wrap_inside)
         wrap_inside.append(me)
         return wrap_inside
=20
-    def extract(self, _self_index=3DNone):
+    def extract(self, _self_index: Optional[int] =3D None) -> Self:
         """Destructively rips this element out of the tree.
=20
         :param _self_index: The location of this element in its parent's
            .contents, if known. Passing this in allows for a performance
            optimization.
=20
-        :return: `self`, no longer part of the tree.
+        :return: this `PageElement`, no longer part of the tree.
         """
         if self.parent is not None:
             if _self_index is None:
                 _self_index =3D self.parent.index(self)
             del self.parent.contents[_self_index]
=20
-        #Find the two elements that would be next to each other if
-        #this element (and any children) hadn't been parsed. Connect
-        #the two.
+        # Find the two elements that would be next to each other if
+        # this element (and any children) hadn't been parsed. Connect
+        # the two.
         last_child =3D self._last_descendant()
+
+        # last_child can't be None because we passed accept_self=3DTrue
+        # into _last_descendant. Worst case, last_child will be
+        # self. Making this cast removes several mypy complaints later
+        # on as we manipulate last_child.
+        last_child =3D cast(PageElement, last_child)
         next_element =3D last_child.next_element
=20
-        if (self.previous_element is not None and
-            self.previous_element is not next_element):
-            self.previous_element.next_element =3D next_element
+        if self.previous_element is not None:
+            if self.previous_element is not next_element:
+                self.previous_element.next_element =3D next_element
         if next_element is not None and next_element is not self.previou=
s_element:
             next_element.previous_element =3D self.previous_element
         self.previous_element =3D None
         last_child.next_element =3D None
=20
         self.parent =3D None
-        if (self.previous_sibling is not None
-            and self.previous_sibling is not self.next_sibling):
+        if (
+            self.previous_sibling is not None
+            and self.previous_sibling is not self.next_sibling
+        ):
             self.previous_sibling.next_sibling =3D self.next_sibling
-        if (self.next_sibling is not None
-            and self.next_sibling is not self.previous_sibling):
+        if (
+            self.next_sibling is not None
+            and self.next_sibling is not self.previous_sibling
+        ):
             self.next_sibling.previous_sibling =3D self.previous_sibling
         self.previous_sibling =3D self.next_sibling =3D None
         return self
=20
-    def _last_descendant(self, is_initialized=3DTrue, accept_self=3DTrue=
):
+    def decompose(self) -> None:
+        """Recursively destroys this `PageElement` and its children.
+
+        The element will be removed from the tree and wiped out; so
+        will everything beneath it.
+
+        The behavior of a decomposed `PageElement` is undefined and you
+        should never use one for anything, but if you need to *check*
+        whether an element has been decomposed, you can use the
+        `PageElement.decomposed` property.
+        """
+        self.extract()
+        e: _AtMostOneElement =3D self
+        next_up: _AtMostOneElement =3D None
+        while e is not None:
+            next_up =3D e.next_element
+            e.__dict__.clear()
+            if isinstance(e, Tag):
+                e.name =3D ""
+                e.contents =3D []
+            e._decomposed =3D True
+            e =3D next_up
+
+    def _last_descendant(
+        self, is_initialized: bool =3D True, accept_self: bool =3D True
+    ) -> _AtMostOneElement:
         """Finds the last element beneath this object to be parsed.
=20
-        :param is_initialized: Has `setup` been called on this PageEleme=
nt
-            yet?
-        :param accept_self: Is `self` an acceptable answer to the questi=
on?
+        Special note to help you figure things out if your type
+        checking is tripped up by the fact that this method returns
+        _AtMostOneElement instead of PageElement: the only time
+        this method returns None is if `accept_self` is False and the
+        `PageElement` has no children--either it's a NavigableString
+        or an empty Tag.
+
+        :param is_initialized: Has `PageElement.setup` been called on
+            this `PageElement` yet?
+
+        :param accept_self: Is ``self`` an acceptable answer to the
+            question?
         """
         if is_initialized and self.next_sibling is not None:
             last_child =3D self.next_sibling.previous_element
@@ -400,163 +695,139 @@ class PageElement(object):
         if not accept_self and last_child is self:
             last_child =3D None
         return last_child
-    # BS3: Not part of the API!
-    _lastRecursiveChild =3D _last_descendant
-
-    def insert(self, position, new_child):
-        """Insert a new PageElement in the list of this PageElement's ch=
ildren.
-
-        This works the same way as `list.insert`.
-
-        :param position: The numeric position that should be occupied
-           in `self.children` by the new PageElement.
-        :param new_child: A PageElement.
-        """
-        if new_child is None:
-            raise ValueError("Cannot insert None into a tag.")
-        if new_child is self:
-            raise ValueError("Cannot insert a tag into itself.")
-        if (isinstance(new_child, str)
-            and not isinstance(new_child, NavigableString)):
-            new_child =3D NavigableString(new_child)
-
-        from . import BeautifulSoup
-        if isinstance(new_child, BeautifulSoup):
-            # We don't want to end up with a situation where one Beautif=
ulSoup
-            # object contains another. Insert the children one at a time.
-            for subchild in list(new_child.contents):
-                self.insert(position, subchild)
-                position +=3D 1
-            return
-        position =3D min(position, len(self.contents))
-        if hasattr(new_child, 'parent') and new_child.parent is not None=
:
-            # We're 'inserting' an element that's already one
-            # of this object's children.
-            if new_child.parent is self:
-                current_index =3D self.index(new_child)
-                if current_index < position:
-                    # We're moving this element further down the list
-                    # of this object's children. That means that when
-                    # we extract this element, our target index will
-                    # jump down one.
-                    position -=3D 1
-            new_child.extract()
-
-        new_child.parent =3D self
-        previous_child =3D None
-        if position =3D=3D 0:
-            new_child.previous_sibling =3D None
-            new_child.previous_element =3D self
-        else:
-            previous_child =3D self.contents[position - 1]
-            new_child.previous_sibling =3D previous_child
-            new_child.previous_sibling.next_sibling =3D new_child
-            new_child.previous_element =3D previous_child._last_descenda=
nt(False)
-        if new_child.previous_element is not None:
-            new_child.previous_element.next_element =3D new_child
-
-        new_childs_last_element =3D new_child._last_descendant(False)
-
-        if position >=3D len(self.contents):
-            new_child.next_sibling =3D None
-
-            parent =3D self
-            parents_next_sibling =3D None
-            while parents_next_sibling is None and parent is not None:
-                parents_next_sibling =3D parent.next_sibling
-                parent =3D parent.parent
-                if parents_next_sibling is not None:
-                    # We found the element that comes next in the docume=
nt.
-                    break
-            if parents_next_sibling is not None:
-                new_childs_last_element.next_element =3D parents_next_si=
bling
-            else:
-                # The last element of this tag is the last element in
-                # the document.
-                new_childs_last_element.next_element =3D None
-        else:
-            next_child =3D self.contents[position]
-            new_child.next_sibling =3D next_child
-            if new_child.next_sibling is not None:
-                new_child.next_sibling.previous_sibling =3D new_child
-            new_childs_last_element.next_element =3D next_child
-
-        if new_childs_last_element.next_element is not None:
-            new_childs_last_element.next_element.previous_element =3D ne=
w_childs_last_element
-        self.contents.insert(position, new_child)
-
-    def append(self, tag):
-        """Appends the given PageElement to the contents of this one.
-
-        :param tag: A PageElement.
-        """
-        self.insert(len(self.contents), tag)
=20
-    def extend(self, tags):
-        """Appends the given PageElements to this one's contents.
-
-        :param tags: A list of PageElements. If a single Tag is
-            provided instead, this PageElement's contents will be extend=
ed
-            with that Tag's contents.
-        """
-        if isinstance(tags, Tag):
-            tags =3D tags.contents
-        if isinstance(tags, list):
-            # Moving items around the tree may change their position in
-            # the original list. Make a list that won't change.
-            tags =3D list(tags)
-        for tag in tags:
-            self.append(tag)
+    _lastRecursiveChild =3D _deprecated_alias(
+        "_lastRecursiveChild", "_last_descendant", "4.0.0"
+    )
=20
-    def insert_before(self, *args):
+    def insert_before(self, *args: _InsertableElement) -> List[PageEleme=
nt]:
         """Makes the given element(s) the immediate predecessor of this =
one.
=20
-        All the elements will have the same parent, and the given elemen=
ts
-        will be immediately before this one.
+        All the elements will have the same `PageElement.parent` as
+        this one, and the given elements will occur immediately before
+        this one.
=20
         :param args: One or more PageElements.
+
+        :return The list of PageElements that were inserted.
         """
         parent =3D self.parent
         if parent is None:
-            raise ValueError(
-                "Element has no parent, so 'before' has no meaning.")
+            raise ValueError("Element has no parent, so 'before' has no =
meaning.")
         if any(x is self for x in args):
-                raise ValueError("Can't insert an element before itself.=
")
+            raise ValueError("Can't insert an element before itself.")
+        results: List[PageElement] =3D []
         for predecessor in args:
             # Extract first so that the index won't be screwed up if the=
y
             # are siblings.
             if isinstance(predecessor, PageElement):
                 predecessor.extract()
             index =3D parent.index(self)
-            parent.insert(index, predecessor)
+            results.extend(parent.insert(index, predecessor))
+
+        return results
=20
-    def insert_after(self, *args):
+    def insert_after(self, *args: _InsertableElement) -> List[PageElemen=
t]:
         """Makes the given element(s) the immediate successor of this on=
e.
=20
-        The elements will have the same parent, and the given elements
-        will be immediately after this one.
+        The elements will have the same `PageElement.parent` as this
+        one, and the given elements will occur immediately after this
+        one.
=20
         :param args: One or more PageElements.
+
+        :return The list of PageElements that were inserted.
         """
         # Do all error checking before modifying the tree.
         parent =3D self.parent
         if parent is None:
-            raise ValueError(
-                "Element has no parent, so 'after' has no meaning.")
+            raise ValueError("Element has no parent, so 'after' has no m=
eaning.")
         if any(x is self for x in args):
             raise ValueError("Can't insert an element after itself.")
=20
         offset =3D 0
+        results: List[PageElement] =3D []
         for successor in args:
             # Extract first so that the index won't be screwed up if the=
y
             # are siblings.
             if isinstance(successor, PageElement):
                 successor.extract()
             index =3D parent.index(self)
-            parent.insert(index+1+offset, successor)
+            results.extend(parent.insert(index + 1 + offset, successor))
             offset +=3D 1
=20
-    def find_next(self, name=3DNone, attrs=3D{}, string=3DNone, **kwargs=
):
+        return results
+
+    def new_tag(
+        self,
+        name: str,
+        namespace: Optional[str] =3D None,
+        nsprefix: Optional[str] =3D None,
+        attrs: Optional[_RawAttributeValues] =3D None,
+        sourceline: Optional[int] =3D None,
+        sourcepos: Optional[int] =3D None,
+        string: Optional[str] =3D None,
+        **kwattrs: _RawAttributeValue,
+    ) -> Tag:
+        """Create a new Tag associated with the same BeautifulSoup objec=
t as this PageElement is."""
+        root =3D self._root_object
+        if root is None:
+            raise ValueError("Cannot call new_tag on a PageElement not c=
ontained in a BeautifulSoup object")
+        return root.new_tag(name, namespace, nsprefix, attrs, sourceline=
, sourcepos, string, **kwattrs)
+
+    def new_string(self, s: str, subclass: Optional[Type[NavigableString=
]] =3D None
+                   ) -> NavigableString:
+        """Create a new NavigableString associated with the same Beautif=
ulSoup object as this PageElement is."""
+        root =3D self._root_object
+        if root is None:
+            raise ValueError("Cannot call new_string on a PageElement no=
t contained in a BeautifulSoup object")
+        return root.new_string(s, subclass)
+
+    @property
+    def _root_object(self) -> Optional[BeautifulSoup]:
+        """Find the BeautifulSoup object used to create this PageElement=
, assuming it's still attached."""
+        parent:Optional[Tag] =3D self.parent
+        while parent is not None and not parent._is_root:
+            parent =3D parent.parent
+        if parent is None:
+            return parent
+        return cast('BeautifulSoup', parent)
+
+    @property
+    def _is_root(self) -> bool:
+        """No, this object is not the root of its parse tree; only a Bea=
utifulSoup object can be that."""
+        return False
+
+    # No name or attrs + string -> string
+    @overload
+    def find_next(
+            self,
+            name: None =3D None,
+            attrs: None =3D None,
+            *,
+            string: _StrainableString,
+            **kwargs: _StrainableAttribute,
+    ) -> _AtMostOneNavigableString:
+        ...
+
+    # No string -> tag
+    @overload
+    def find_next(
+            self,
+            name: _OptionalFindMethodName =3D None,
+            attrs: Optional[_StrainableAttributes] =3D None,
+            string: None=3DNone,
+            **kwargs: _StrainableAttribute,
+    ) -> _AtMostOneTag:
+        ...
+
+    def find_next(
+        self,
+        name: _OptionalFindMethodName =3D None,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        string: Optional[_StrainableString] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> Union[_AtMostOneTag,_AtMostOneNavigableString,_AtMostOneElement=
]:
         """Find the first PageElement that matches the given criteria an=
d
         appears later in the document than this PageElement.
=20
@@ -564,36 +835,100 @@ class PageElement(object):
         documentation for detailed explanations.
=20
         :param name: A filter on tag name.
-        :param attrs: A dictionary of filters on attribute values.
+        :param attrs: Additional filters on attribute values.
         :param string: A filter for a NavigableString with specific text.
-        :kwargs: A dictionary of filters on attribute values.
-        :return: A PageElement.
-        :rtype: bs4.element.Tag | bs4.element.NavigableString
+        :kwargs: Additional filters on attribute values.
         """
         return self._find_one(self.find_all_next, name, attrs, string, *=
*kwargs)
-    findNext =3D find_next  # BS3
=20
-    def find_all_next(self, name=3DNone, attrs=3D{}, string=3DNone, limi=
t=3DNone,
-                    **kwargs):
-        """Find all PageElements that match the given criteria and appea=
r
-        later in the document than this PageElement.
+    findNext =3D _deprecated_function_alias("findNext", "find_next", "4.=
0.0")
+
+    # No name or attrs + string -> strings
+    @overload
+    def find_all_next(
+        self,
+        name: None =3D None,
+        attrs: None =3D None,
+        *,
+        string: _StrainableString,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _SomeNavigableStrings:
+        ...
+
+    # No string -> tags
+    @overload
+    def find_all_next(
+        self,
+        name: _OptionalFindMethodName =3D None,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        string: None =3D None,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _SomeTags:
+        ...
+
+    def find_all_next(
+        self,
+        name: _OptionalFindMethodName =3D None,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        string: Optional[_StrainableString] =3D None,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> Union[_SomeTags,_SomeNavigableStrings,_QueryResults]:
+        """Find all `PageElement` objects that match the given criteria =
and
+        appear later in the document than this `PageElement`.
=20
         All find_* methods take a common set of arguments. See the onlin=
e
         documentation for detailed explanations.
=20
         :param name: A filter on tag name.
-        :param attrs: A dictionary of filters on attribute values.
+        :param attrs: Additional filters on attribute values.
         :param string: A filter for a NavigableString with specific text.
         :param limit: Stop looking after finding this many results.
-        :kwargs: A dictionary of filters on attribute values.
-        :return: A ResultSet containing PageElements.
+        :kwargs: Additional filters on attribute values.
         """
-        _stacklevel =3D kwargs.pop('_stacklevel', 2)
-        return self._find_all(name, attrs, string, limit, self.next_elem=
ents,
-                              _stacklevel=3D_stacklevel+1, **kwargs)
-    findAllNext =3D find_all_next  # BS3
+        return self._find_all(
+            name,
+            attrs,
+            string,
+            limit,
+            self.next_elements,
+            **kwargs,
+        )
=20
-    def find_next_sibling(self, name=3DNone, attrs=3D{}, string=3DNone, =
**kwargs):
+    findAllNext =3D _deprecated_function_alias("findAllNext", "find_all_=
next", "4.0.0")
+
+    # No name or attrs + string -> strings
+    @overload
+    def find_next_sibling(
+        self,
+        name: None =3D None,
+        attrs: None =3D None,
+        *,
+        string: _StrainableString,
+        **kwargs: _StrainableAttribute,
+    ) -> _AtMostOneNavigableString:
+        ...
+
+    # No string -> tags
+    @overload
+    def find_next_sibling(
+        self,
+        name: _OptionalFindMethodName =3D None,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        string: None =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _AtMostOneTag:
+        ...
+
+    def find_next_sibling(
+        self,
+        name: _OptionalFindMethodName =3D None,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        string: Optional[_StrainableString] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> Union[_AtMostOneTag,_AtMostOneNavigableString,_AtMostOneElement=
]:
         """Find the closest sibling to this PageElement that matches the
         given criteria and appears later in the document.
=20
@@ -601,102 +936,265 @@ class PageElement(object):
         online documentation for detailed explanations.
=20
         :param name: A filter on tag name.
-        :param attrs: A dictionary of filters on attribute values.
-        :param string: A filter for a NavigableString with specific text.
-        :kwargs: A dictionary of filters on attribute values.
-        :return: A PageElement.
-        :rtype: bs4.element.Tag | bs4.element.NavigableString
-        """
-        return self._find_one(self.find_next_siblings, name, attrs, stri=
ng,
-                             **kwargs)
-    findNextSibling =3D find_next_sibling  # BS3
-
-    def find_next_siblings(self, name=3DNone, attrs=3D{}, string=3DNone,=
 limit=3DNone,
-                           **kwargs):
-        """Find all siblings of this PageElement that match the given cr=
iteria
+        :param attrs: Additional filters on attribute values.
+        :param string: A filter for a `NavigableString` with specific te=
xt.
+        :kwargs: Additional filters on attribute values.
+        """
+        return self._find_one(self.find_next_siblings, name, attrs, stri=
ng, **kwargs)
+
+    findNextSibling =3D _deprecated_function_alias(
+        "findNextSibling", "find_next_sibling", "4.0.0"
+    )
+
+    # No name or attrs + string -> strings
+    @overload
+    def find_next_siblings(
+        self,
+        name: None =3D None,
+        attrs: None =3D None,
+        *,
+        string: _StrainableString,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _SomeNavigableStrings:
+        ...
+
+    # No string -> tags
+    @overload
+    def find_next_siblings(
+        self,
+        name: _OptionalFindMethodName =3D None,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        string: None =3D None,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _SomeTags:
+        ...
+
+    def find_next_siblings(
+        self,
+        name: _OptionalFindMethodName =3D None,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        string: Optional[_StrainableString] =3D None,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> Union[_SomeTags,_SomeNavigableStrings,_QueryResults]:
+        """Find all siblings of this `PageElement` that match the given =
criteria
         and appear later in the document.
=20
         All find_* methods take a common set of arguments. See the onlin=
e
         documentation for detailed explanations.
=20
         :param name: A filter on tag name.
-        :param attrs: A dictionary of filters on attribute values.
-        :param string: A filter for a NavigableString with specific text.
+        :param attrs: Additional filters on attribute values.
+        :param string: A filter for a `NavigableString` with specific te=
xt.
         :param limit: Stop looking after finding this many results.
-        :kwargs: A dictionary of filters on attribute values.
-        :return: A ResultSet of PageElements.
-        :rtype: bs4.element.ResultSet
+        :kwargs: Additional filters on attribute values.
         """
-        _stacklevel =3D kwargs.pop('_stacklevel', 2)
         return self._find_all(
-            name, attrs, string, limit,
-            self.next_siblings, _stacklevel=3D_stacklevel+1, **kwargs
+            name,
+            attrs,
+            string,
+            limit,
+            self.next_siblings,
+            **kwargs,
         )
-    findNextSiblings =3D find_next_siblings   # BS3
-    fetchNextSiblings =3D find_next_siblings  # BS2
=20
-    def find_previous(self, name=3DNone, attrs=3D{}, string=3DNone, **kw=
args):
-        """Look backwards in the document from this PageElement and find=
 the
-        first PageElement that matches the given criteria.
+    findNextSiblings =3D _deprecated_function_alias(
+        "findNextSiblings", "find_next_siblings", "4.0.0"
+    )
+    fetchNextSiblings =3D _deprecated_function_alias(
+        "fetchNextSiblings", "find_next_siblings", "3.0.0"
+    )
+
+    # No name or attrs + string -> string
+    @overload
+    def find_previous(
+            self,
+            name: None =3D None,
+            attrs: None =3D None,
+            *,
+            string: _StrainableString,
+            **kwargs: _StrainableAttribute,
+    ) -> _AtMostOneNavigableString:
+        ...
+
+    # No string -> tag
+    @overload
+    def find_previous(
+            self,
+            name: _OptionalFindMethodName =3D None,
+            attrs: Optional[_StrainableAttributes] =3D None,
+            string: None=3DNone,
+            **kwargs: _StrainableAttribute,
+    ) -> _AtMostOneTag:
+        ...
+
+    def find_previous(
+        self,
+        name: _OptionalFindMethodName =3D None,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        string: Optional[_StrainableString] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> Union[_AtMostOneTag,_AtMostOneNavigableString,_AtMostOneElement=
]:
+        """Look backwards in the document from this `PageElement` and fi=
nd the
+        first `PageElement` that matches the given criteria.
=20
         All find_* methods take a common set of arguments. See the onlin=
e
         documentation for detailed explanations.
=20
         :param name: A filter on tag name.
-        :param attrs: A dictionary of filters on attribute values.
-        :param string: A filter for a NavigableString with specific text.
-        :kwargs: A dictionary of filters on attribute values.
-        :return: A PageElement.
-        :rtype: bs4.element.Tag | bs4.element.NavigableString
-        """
-        return self._find_one(
-            self.find_all_previous, name, attrs, string, **kwargs)
-    findPrevious =3D find_previous  # BS3
-
-    def find_all_previous(self, name=3DNone, attrs=3D{}, string=3DNone, =
limit=3DNone,
-                        **kwargs):
-        """Look backwards in the document from this PageElement and find=
 all
-        PageElements that match the given criteria.
+        :param attrs: Additional filters on attribute values.
+        :param string: A filter for a `NavigableString` with specific te=
xt.
+        :kwargs: Additional filters on attribute values.
+        """
+        return self._find_one(self.find_all_previous, name, attrs, strin=
g, **kwargs)
+
+    findPrevious =3D _deprecated_function_alias("findPrevious", "find_pr=
evious", "3.0.0")
+
+    # No name or attrs + string -> strings
+    @overload
+    def find_all_previous(
+        self,
+        name: None =3D None,
+        attrs: None =3D None,
+        *,
+        string: _StrainableString,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _SomeNavigableStrings:
+        ...
+
+    # No string -> tags
+    @overload
+    def find_all_previous(
+        self,
+        name: _OptionalFindMethodName =3D None,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        string: None =3D None,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _SomeTags:
+        ...
+
+    def find_all_previous(
+        self,
+        name: _OptionalFindMethodName =3D None,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        string: Optional[_StrainableString] =3D None,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> Union[_SomeTags,_SomeNavigableStrings,_QueryResults]:
+        """Look backwards in the document from this `PageElement` and fi=
nd all
+        `PageElement` that match the given criteria.
=20
         All find_* methods take a common set of arguments. See the onlin=
e
         documentation for detailed explanations.
=20
         :param name: A filter on tag name.
-        :param attrs: A dictionary of filters on attribute values.
-        :param string: A filter for a NavigableString with specific text.
+        :param attrs: Additional filters on attribute values.
+        :param string: A filter for a `NavigableString` with specific te=
xt.
         :param limit: Stop looking after finding this many results.
-        :kwargs: A dictionary of filters on attribute values.
-        :return: A ResultSet of PageElements.
-        :rtype: bs4.element.ResultSet
+        :kwargs: Additional filters on attribute values.
         """
-        _stacklevel =3D kwargs.pop('_stacklevel', 2)
         return self._find_all(
-            name, attrs, string, limit, self.previous_elements,
-            _stacklevel=3D_stacklevel+1, **kwargs
+            name,
+            attrs,
+            string,
+            limit,
+            self.previous_elements,
+            **kwargs,
         )
-    findAllPrevious =3D find_all_previous  # BS3
-    fetchPrevious =3D find_all_previous    # BS2
=20
-    def find_previous_sibling(self, name=3DNone, attrs=3D{}, string=3DNo=
ne, **kwargs):
-        """Returns the closest sibling to this PageElement that matches =
the
+    findAllPrevious =3D _deprecated_function_alias(
+        "findAllPrevious", "find_all_previous", "4.0.0"
+    )
+    fetchAllPrevious =3D _deprecated_function_alias(
+        "fetchAllPrevious", "find_all_previous", "3.0.0"
+    )
+
+    # No name or attrs + string -> string
+    @overload
+    def find_previous_sibling(
+        self,
+        name: None =3D None,
+        attrs: None =3D None,
+        *,
+        string: _StrainableString,
+        **kwargs: _StrainableAttribute,
+    ) -> _AtMostOneNavigableString:
+        ...
+
+    # No string -> tag
+    @overload
+    def find_previous_sibling(
+        self,
+        name: _OptionalFindMethodName =3D None,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        string: None =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _AtMostOneTag:
+        ...
+
+    def find_previous_sibling(
+        self,
+        name: _OptionalFindMethodName =3D None,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        string: Optional[_StrainableString] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> Union[_AtMostOneTag,_AtMostOneNavigableString,_AtMostOneElement=
]:
+        """Returns the closest sibling to this `PageElement` that matche=
s the
         given criteria and appears earlier in the document.
=20
         All find_* methods take a common set of arguments. See the onlin=
e
         documentation for detailed explanations.
=20
         :param name: A filter on tag name.
-        :param attrs: A dictionary of filters on attribute values.
-        :param string: A filter for a NavigableString with specific text.
-        :kwargs: A dictionary of filters on attribute values.
-        :return: A PageElement.
-        :rtype: bs4.element.Tag | bs4.element.NavigableString
+        :param attrs: Additional filters on attribute values.
+        :param string: A filter for a `NavigableString` with specific te=
xt.
+        :kwargs: Additional filters on attribute values.
         """
-        return self._find_one(self.find_previous_siblings, name, attrs, =
string,
-                             **kwargs)
-    findPreviousSibling =3D find_previous_sibling  # BS3
+        return self._find_one(
+            self.find_previous_siblings, name, attrs, string, **kwargs
+        )
=20
-    def find_previous_siblings(self, name=3DNone, attrs=3D{}, string=3DN=
one,
-                               limit=3DNone, **kwargs):
+    findPreviousSibling =3D _deprecated_function_alias(
+        "findPreviousSibling", "find_previous_sibling", "4.0.0"
+    )
+
+    # No name or attrs + string -> strings
+    @overload
+    def find_previous_siblings(
+        self,
+        name: None =3D None,
+        attrs: None =3D None,
+        *,
+        string: _StrainableString,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _SomeNavigableStrings:
+        ...
+
+    # No string -> tags
+    @overload
+    def find_previous_siblings(
+        self,
+        name: _OptionalFindMethodName =3D None,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        string: None =3D None,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _SomeTags:
+        ...
+
+    def find_previous_siblings(
+        self,
+        name: _OptionalFindMethodName =3D None,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        string: Optional[_StrainableString] =3D None,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> Union[_SomeTags,_SomeNavigableStrings,_QueryResults]:
         """Returns all siblings to this PageElement that match the
         given criteria and appear earlier in the document.
=20
@@ -704,22 +1202,33 @@ class PageElement(object):
         documentation for detailed explanations.
=20
         :param name: A filter on tag name.
-        :param attrs: A dictionary of filters on attribute values.
+        :param attrs: Additional filters on attribute values.
         :param string: A filter for a NavigableString with specific text.
         :param limit: Stop looking after finding this many results.
-        :kwargs: A dictionary of filters on attribute values.
-        :return: A ResultSet of PageElements.
-        :rtype: bs4.element.ResultSet
+        :kwargs: Additional filters on attribute values.
         """
-        _stacklevel =3D kwargs.pop('_stacklevel', 2)
         return self._find_all(
-            name, attrs, string, limit,
-            self.previous_siblings, _stacklevel=3D_stacklevel+1, **kwarg=
s
+            name,
+            attrs,
+            string,
+            limit,
+            self.previous_siblings,
+            **kwargs,
         )
-    findPreviousSiblings =3D find_previous_siblings   # BS3
-    fetchPreviousSiblings =3D find_previous_siblings  # BS2
=20
-    def find_parent(self, name=3DNone, attrs=3D{}, **kwargs):
+    findPreviousSiblings =3D _deprecated_function_alias(
+        "findPreviousSiblings", "find_previous_siblings", "4.0.0"
+    )
+    fetchPreviousSiblings =3D _deprecated_function_alias(
+        "fetchPreviousSiblings", "find_previous_siblings", "3.0.0"
+    )
+
+    def find_parent(
+        self,
+        name: _OptionalFindMethodName =3D None,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _AtMostOneTag:
         """Find the closest parent of this PageElement that matches the =
given
         criteria.
=20
@@ -727,162 +1236,222 @@ class PageElement(object):
         documentation for detailed explanations.
=20
         :param name: A filter on tag name.
-        :param attrs: A dictionary of filters on attribute values.
-        :kwargs: A dictionary of filters on attribute values.
-
-        :return: A PageElement.
-        :rtype: bs4.element.Tag | bs4.element.NavigableString
+        :param attrs: Additional filters on attribute values.
+        :param self: Whether the PageElement itself should be considered
+           as one of its 'parents'.
+        :kwargs: Additional filters on attribute values.
         """
         # NOTE: We can't use _find_one because findParents takes a diffe=
rent
         # set of arguments.
         r =3D None
-        l =3D self.find_parents(name, attrs, 1, _stacklevel=3D3, **kwarg=
s)
-        if l:
-            r =3D l[0]
+        results =3D self.find_parents(
+            name, attrs, 1, **kwargs
+        )
+        if results:
+            r =3D results[0]
         return r
-    findParent =3D find_parent  # BS3
=20
-    def find_parents(self, name=3DNone, attrs=3D{}, limit=3DNone, **kwar=
gs):
-        """Find all parents of this PageElement that match the given cri=
teria.
+    findParent =3D _deprecated_function_alias("findParent", "find_parent=
", "4.0.0")
+
+    def find_parents(
+        self,
+        name: _OptionalFindMethodName =3D None,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _SomeTags:
+        """Find all parents of this `PageElement` that match the given c=
riteria.
=20
         All find_* methods take a common set of arguments. See the onlin=
e
         documentation for detailed explanations.
=20
         :param name: A filter on tag name.
-        :param attrs: A dictionary of filters on attribute values.
+        :param attrs: Additional filters on attribute values.
         :param limit: Stop looking after finding this many results.
-        :kwargs: A dictionary of filters on attribute values.
-
-        :return: A PageElement.
-        :rtype: bs4.element.Tag | bs4.element.NavigableString
+        :kwargs: Additional filters on attribute values.
         """
-        _stacklevel =3D kwargs.pop('_stacklevel', 2)
-        return self._find_all(name, attrs, None, limit, self.parents,
-                              _stacklevel=3D_stacklevel+1, **kwargs)
-    findParents =3D find_parents   # BS3
-    fetchParents =3D find_parents  # BS2
+        iterator =3D self.parents
+        # Only Tags can have children, so this ResultSet will contain
+        # nothing but Tags.
+        return cast(ResultSet[Tag], self._find_all(
+            name, attrs, None, limit, iterator, **kwargs
+        ))
=20
-    @property
-    def next(self):
-        """The PageElement, if any, that was parsed just after this one.
+    findParents =3D _deprecated_function_alias("findParents", "find_pare=
nts", "4.0.0")
+    fetchParents =3D _deprecated_function_alias("fetchParents", "find_pa=
rents", "3.0.0")
=20
-        :return: A PageElement.
-        :rtype: bs4.element.Tag | bs4.element.NavigableString
-        """
+    @property
+    def next(self) -> _AtMostOneElement:
+        """The `PageElement`, if any, that was parsed just after this on=
e."""
         return self.next_element
=20
     @property
-    def previous(self):
-        """The PageElement, if any, that was parsed just before this one.
-
-        :return: A PageElement.
-        :rtype: bs4.element.Tag | bs4.element.NavigableString
-        """
+    def previous(self) -> _AtMostOneElement:
+        """The `PageElement`, if any, that was parsed just before this o=
ne."""
         return self.previous_element
=20
-    #These methods do the real heavy lifting.
-
-    def _find_one(self, method, name, attrs, string, **kwargs):
-        r =3D None
-        l =3D method(name, attrs, string, 1, _stacklevel=3D4, **kwargs)
-        if l:
-            r =3D l[0]
+    # These methods do the real heavy lifting.
+
+    def _find_one(
+        self,
+        # TODO-TYPING: "There is no syntax to indicate optional or
+        # keyword arguments; such function types are rarely used
+        # as callback types." - So, not sure how to get more
+        # specific here.
+        method: Callable,
+        name: _OptionalFindMethodName,
+        attrs: Optional[_StrainableAttributes],
+        string: Optional[_StrainableString],
+        **kwargs: _StrainableAttribute,
+    ) -> _AtMostOneElement:
+        r: _AtMostOneElement =3D None
+        results: _QueryResults =3D method(name, attrs, string, 1, **kwar=
gs)
+        if results:
+            r =3D results[0]
         return r
=20
-    def _find_all(self, name, attrs, string, limit, generator, **kwargs)=
:
-        "Iterates over a generator looking for things that match."
-        _stacklevel =3D kwargs.pop('_stacklevel', 3)
-
-        if string is None and 'text' in kwargs:
-            string =3D kwargs.pop('text')
+    @property
+    def _warning_stack_level(self) -> int:
+        """Find the appropriate stack level to use when issuing a warnin=
g relating to one of the find* methods."""
+        # The find* methods call each other, which makes it
+        # difficult to track how deep we are in the stack
+        # vis-a-vis the caller's entry point into the bs4.element
+        # module. However, we know that all of the find* methods
+        # are in bs4.element, and there's no code in this module
+        # that triggers the warnings we need to issue.
+        #
+        # (There is _test_ code that triggers the warnings, but that's
+        # in bs4.tests.)
+        #
+        # Therefore we can go up the stack until we leave the
+        # bs4.element module, and use the distance between here and
+        # there as the stacklevel.
+        stacklevel =3D 0
+        for frameinfo in inspect.stack(context=3D0):
+            if (frameinfo.frame is not None
+                and frameinfo.frame.f_globals is not None
+                and frameinfo.frame.f_globals.get('__name__', '') !=3D "=
bs4.element"):
+                break
+            stacklevel +=3D 1
+        return stacklevel
+
+    def _find_all(
+        self,
+        name: _OptionalFindMethodName,
+        attrs: Optional[_StrainableAttributes],
+        string: Optional[_StrainableString],
+        limit: Optional[int],
+        generator: Iterator[PageElement],
+        **kwargs: _StrainableAttribute,
+    ) -> _QueryResults:
+        """Iterates over a generator looking for things that match."""
+
+        if string is None and "text" in kwargs:
+            string =3D kwargs.pop("text")
             warnings.warn(
                 "The 'text' argument to find()-type methods is deprecate=
d. Use 'string' instead.",
-                DeprecationWarning, stacklevel=3D_stacklevel
+                DeprecationWarning,
+                stacklevel=3Dself._warning_stack_level,
+            )
+
+        if "_class" in kwargs:
+            warnings.warn(
+                AttributeResemblesVariableWarning.MESSAGE
+                % dict(
+                    original=3D"_class",
+                    autocorrect=3D"class_",
+                ),
+                AttributeResemblesVariableWarning,
+                stacklevel=3Dself._warning_stack_level,
             )
=20
-        if isinstance(name, SoupStrainer):
-            strainer =3D name
+        from bb._vendor.bs4.filter import ElementFilter
+
+        if isinstance(name, ElementFilter):
+            matcher =3D name
         else:
-            strainer =3D SoupStrainer(name, attrs, string, **kwargs)
+            matcher =3D SoupStrainer(name, attrs, string, **kwargs)
=20
+        result: MutableSequence[_OneElement]
         if string is None and not limit and not attrs and not kwargs:
             if name is True or name is None:
                 # Optimization to find all tags.
-                result =3D (element for element in generator
-                          if isinstance(element, Tag))
-                return ResultSet(strainer, result)
+                result =3D [element for element in generator if isinstan=
ce(element, Tag)]
+                return ResultSet(matcher, result)
             elif isinstance(name, str):
                 # Optimization to find all tags with a given name.
-                if name.count(':') =3D=3D 1:
+                if name.count(":") =3D=3D 1:
                     # This is a name with a prefix. If this is a namespa=
ce-aware document,
                     # we need to match the local name against tag.name. =
If not,
                     # we need to match the fully-qualified name against =
tag.name.
-                    prefix, local_name =3D name.split(':', 1)
+                    prefix, local_name =3D name.split(":", 1)
                 else:
                     prefix =3D None
                     local_name =3D name
-                result =3D (element for element in generator
-                          if isinstance(element, Tag)
-                          and (
-                              element.name =3D=3D name
-                          ) or (
-                              element.name =3D=3D local_name
-                              and (prefix is None or element.prefix =3D=3D=
 prefix)
-                          )
-                )
-                return ResultSet(strainer, result)
-        results =3D ResultSet(strainer)
-        while True:
-            try:
-                i =3D next(generator)
-            except StopIteration:
-                break
-            if i:
-                found =3D strainer.search(i)
-                if found:
-                    results.append(found)
-                    if limit and len(results) >=3D limit:
-                        break
-        return results
+                result =3D []
+                for element in generator:
+                    if not isinstance(element, Tag):
+                        continue
+                    if element.name =3D=3D name or (
+                        element.name =3D=3D local_name
+                        and (prefix is None or element.prefix =3D=3D pre=
fix)
+                    ):
+                        result.append(element)
+                return ResultSet(matcher, result)
+        return matcher.find_all(generator, limit)
=20
-    #These generators can be used to navigate starting from both
-    #NavigableStrings and Tags.
+    # These generators can be used to navigate starting from both
+    # NavigableStrings and Tags.
     @property
-    def next_elements(self):
-        """All PageElements that were parsed after this one.
-
-        :yield: A sequence of PageElements.
-        """
+    def next_elements(self) -> Iterator[PageElement]:
+        """All PageElements that were parsed after this one."""
         i =3D self.next_element
         while i is not None:
+            successor =3D i.next_element
             yield i
-            i =3D i.next_element
+            i =3D successor
=20
     @property
-    def next_siblings(self):
+    def self_and_next_elements(self) -> Iterator[PageElement]:
+        """This PageElement, then all PageElements that were parsed afte=
r it."""
+        return self._self_and(self.next_elements)
+
+    @property
+    def next_siblings(self) -> Iterator[PageElement]:
         """All PageElements that are siblings of this one but were parse=
d
         later.
-
-        :yield: A sequence of PageElements.
         """
         i =3D self.next_sibling
         while i is not None:
+            successor =3D i.next_sibling
             yield i
-            i =3D i.next_sibling
+            i =3D successor
=20
     @property
-    def previous_elements(self):
+    def self_and_next_siblings(self) -> Iterator[PageElement]:
+        """This PageElement, then all of its siblings."""
+        return self._self_and(self.next_siblings)
+
+    @property
+    def previous_elements(self) -> Iterator[PageElement]:
         """All PageElements that were parsed before this one.
=20
         :yield: A sequence of PageElements.
         """
         i =3D self.previous_element
         while i is not None:
+            successor =3D i.previous_element
             yield i
-            i =3D i.previous_element
+            i =3D successor
+
+    @property
+    def self_and_previous_elements(self) -> Iterator[PageElement]:
+        """This PageElement, then all elements that were parsed
+        earlier."""
+        return self._self_and(self.previous_elements)
=20
     @property
-    def previous_siblings(self):
+    def previous_siblings(self) -> Iterator[PageElement]:
         """All PageElements that are siblings of this one but were parse=
d
         earlier.
=20
@@ -890,57 +1459,94 @@ class PageElement(object):
         """
         i =3D self.previous_sibling
         while i is not None:
+            successor =3D i.previous_sibling
             yield i
-            i =3D i.previous_sibling
+            i =3D successor
=20
     @property
-    def parents(self):
-        """All PageElements that are parents of this PageElement.
+    def self_and_previous_siblings(self) -> Iterator[PageElement]:
+        """This PageElement, then all of its siblings that were parsed
+        earlier."""
+        return self._self_and(self.previous_siblings)
=20
-        :yield: A sequence of PageElements.
+    @property
+    def parents(self) -> Iterator[Tag]:
+        """All elements that are parents of this PageElement.
+
+        :yield: A sequence of Tags, ending with a BeautifulSoup object.
         """
         i =3D self.parent
         while i is not None:
+            successor =3D i.parent
             yield i
-            i =3D i.parent
+            i =3D successor
=20
     @property
-    def decomposed(self):
-        """Check whether a PageElement has been decomposed.
+    def self_and_parents(self) -> Iterator[PageElement]:
+        """This element, then all of its parents.
+
+        :yield: A sequence of PageElements, ending with a BeautifulSoup =
object.
+        """
+        return self._self_and(self.parents)
=20
-        :rtype: bool
+    def _self_and(self, other_generator:Iterator[PageElement]) -> Iterat=
or[PageElement]:
+        """Modify a generator by yielding this element, then everything
+        yielded by the other generator.
         """
-        return getattr(self, '_decomposed', False) or False
-  =20
-    # Old non-property versions of the generators, for backwards
-    # compatibility with BS3.
-    def nextGenerator(self):
+        if not self.hidden:
+            yield self
+        for i in other_generator:
+            yield i
+
+    @property
+    def decomposed(self) -> bool:
+        """Check whether a PageElement has been decomposed."""
+        return getattr(self, "_decomposed", False) or False
+
+    @_deprecated("next_elements", "4.0.0")
+    def nextGenerator(self) -> Iterator[PageElement]:
+        ":meta private:"
         return self.next_elements
=20
-    def nextSiblingGenerator(self):
+    @_deprecated("next_siblings", "4.0.0")
+    def nextSiblingGenerator(self) -> Iterator[PageElement]:
+        ":meta private:"
         return self.next_siblings
=20
-    def previousGenerator(self):
+    @_deprecated("previous_elements", "4.0.0")
+    def previousGenerator(self) -> Iterator[PageElement]:
+        ":meta private:"
         return self.previous_elements
=20
-    def previousSiblingGenerator(self):
+    @_deprecated("previous_siblings", "4.0.0")
+    def previousSiblingGenerator(self) -> Iterator[PageElement]:
+        ":meta private:"
         return self.previous_siblings
=20
-    def parentGenerator(self):
+    @_deprecated("parents", "4.0.0")
+    def parentGenerator(self) -> Iterator[PageElement]:
+        ":meta private:"
         return self.parents
=20
=20
 class NavigableString(str, PageElement):
-    """A Python Unicode string that is part of a parse tree.
+    """A Python string that is part of a parse tree.
=20
-    When Beautiful Soup parses the markup <b>penguin</b>, it will
-    create a NavigableString for the string "penguin".
+    When Beautiful Soup parses the markup ``<b>penguin</b>``, it will
+    create a `NavigableString` for the string "penguin".
     """
=20
-    PREFIX =3D ''
-    SUFFIX =3D ''
+    #: A string prepended to the body of the 'real' string
+    #: when formatting it as part of a document, such as the '<!--'
+    #: in an HTML comment.
+    PREFIX: str =3D ""
+
+    #: A string appended to the body of the 'real' string
+    #: when formatting it as part of a document, such as the '-->'
+    #: in an HTML comment.
+    SUFFIX: str =3D ""
=20
-    def __new__(cls, value):
+    def __new__(cls, value: Union[str, bytes]) -> Self:
         """Create a new NavigableString.
=20
         When unpickling a NavigableString, this method is called with
@@ -952,10 +1558,11 @@ class NavigableString(str, PageElement):
             u =3D str.__new__(cls, value)
         else:
             u =3D str.__new__(cls, value, DEFAULT_OUTPUT_ENCODING)
+        u.hidden =3D False
         u.setup()
         return u
=20
-    def __deepcopy__(self, memo, recursive=3DFalse):
+    def __deepcopy__(self, memo: Dict[Any, Any], recursive: bool =3D Fal=
se) -> Self:
         """A copy of a NavigableString has the same contents and class
         as the original, but it is not connected to the parse tree.
=20
@@ -965,50 +1572,61 @@ class NavigableString(str, PageElement):
         """
         return type(self)(self)
=20
-    def __copy__(self):
-        """A copy of a NavigableString can only be a deep copy, because
-        only one PageElement can occupy a given place in a parse tree.
-        """
-        return self.__deepcopy__({})
-
-    def __getnewargs__(self):
+    def __getnewargs__(self) -> Tuple[str]:
         return (str(self),)
=20
-    def __getattr__(self, attr):
-        """text.string gives you text. This is for backwards
-        compatibility for Navigable*String, but for CData* it lets you
-        get the string without the CData wrapper."""
-        if attr =3D=3D 'string':
-            return self
-        else:
-            raise AttributeError(
-                "'%s' object has no attribute '%s'" % (
-                    self.__class__.__name__, attr))
+    # TODO-TYPING This should be SupportsIndex|slice but SupportsIndex
+    # is introduced in 3.8. This can be changed once 3.7 support is drop=
ped.
+    def __getitem__(self, key: Union[int|slice]) -> str: # type:ignore
+        """Raise an exception """
+        if isinstance(key, str):
+            raise TypeError("string indices must be integers, not '{0}'.=
 Are you treating a NavigableString like a Tag?".format(key.__class__.__n=
ame__))
+        return super(NavigableString, self).__getitem__(key)
+
+    @property
+    def string(self) -> str:
+        """Convenience property defined to match `Tag.string`.
=20
-    def output_ready(self, formatter=3D"minimal"):
-        """Run the string through the provided formatter.
+        :return: This property always returns the `NavigableString` it w=
as
+           called on.
=20
-        :param formatter: A Formatter object, or a string naming one of =
the standard formatters.
+        :meta private:
+        """
+        return self
+
+    def output_ready(self, formatter: _FormatterOrName =3D "minimal") ->=
 str:
+        """Run the string through the provided formatter, making it
+        ready for output as part of an HTML or XML document.
+
+        :param formatter: A `Formatter` object, or a string naming one
+            of the standard formatters.
         """
         output =3D self.format_string(self, formatter)
         return self.PREFIX + output + self.SUFFIX
=20
     @property
-    def name(self):
+    def name(self) -> None:
         """Since a NavigableString is not a Tag, it has no .name.
=20
         This property is implemented so that code like this doesn't cras=
h
         when run on a mixture of Tag and NavigableString objects:
             [x.name for x in tag.children]
+
+        :meta private:
         """
         return None
=20
     @name.setter
-    def name(self, name):
-        """Prevent NavigableString.name from ever being set."""
+    def name(self, name: str) -> None:
+        """Prevent NavigableString.name from ever being set.
+
+        :meta private:
+        """
         raise AttributeError("A NavigableString cannot be given a name."=
)
=20
-    def _all_strings(self, strip=3DFalse, types=3DPageElement.default):
+    def _all_strings(
+        self, strip: bool =3D False, types: _OneOrMoreStringTypes =3D Pa=
geElement.default
+    ) -> Iterator[str]:
         """Yield all strings of certain classes, possibly stripping them.
=20
         This makes it easy for NavigableString to implement methods
@@ -1025,12 +1643,11 @@ class NavigableString(str, PageElement):
             means no comments, processing instructions, etc.
=20
         :yield: A sequence that either contains this string, or is empty.
-
         """
         if types is self.default:
             # This is kept in Tag because it's full of subclasses of
             # this class, which aren't defined until later in the file.
-            types =3D Tag.DEFAULT_INTERESTING_STRING_TYPES
+            types =3D Tag.MAIN_CONTENT_STRING_TYPES
=20
         # Do nothing if the caller is looking for specific types of
         # string, and we're of a different type.
@@ -1051,70 +1668,94 @@ class NavigableString(str, PageElement):
=20
         value =3D self
         if strip:
-            value =3D value.strip()
-        if len(value) > 0:
-            yield value
-    strings =3D property(_all_strings)
+            final_value =3D value.strip()
+        else:
+            final_value =3D self
+        if len(final_value) > 0:
+            yield final_value
+
+    @property
+    def strings(self) -> Iterator[str]:
+        """Yield this string, but only if it is interesting.
+
+        This is defined the way it is for compatibility with
+        `Tag.strings`. See `Tag` for information on which strings are
+        interesting in a given context.
+
+        :yield: A sequence that either contains this string, or is empty.
+        """
+        return self._all_strings()
+
=20
 class PreformattedString(NavigableString):
-    """A NavigableString not subject to the normal formatting rules.
+    """A `NavigableString` not subject to the normal formatting rules.
=20
     This is an abstract class used for special kinds of strings such
-    as comments (the Comment class) and CDATA blocks (the CData
-    class).
+    as comments (`Comment`) and CDATA blocks (`CData`).
     """
=20
-    PREFIX =3D ''
-    SUFFIX =3D ''
+    PREFIX: str =3D ""
+    SUFFIX: str =3D ""
=20
-    def output_ready(self, formatter=3DNone):
+    def output_ready(self, formatter: Optional[_FormatterOrName] =3D Non=
e) -> str:
         """Make this string ready for output by adding any subclass-spec=
ific
             prefix or suffix.
=20
-        :param formatter: A Formatter object, or a string naming one
+        :param formatter: A `Formatter` object, or a string naming one
             of the standard formatters. The string will be passed into t=
he
-            Formatter, but only to trigger any side effects: the return
+            `Formatter`, but only to trigger any side effects: the retur=
n
             value is ignored.
=20
         :return: The string, with any subclass-specific prefix and
            suffix added on.
         """
         if formatter is not None:
-            ignore =3D self.format_string(self, formatter)
+            self.format_string(self, formatter)
         return self.PREFIX + self + self.SUFFIX
=20
+
 class CData(PreformattedString):
-    """A CDATA block."""
-    PREFIX =3D '<![CDATA['
-    SUFFIX =3D ']]>'
+    """A `CDATA section <https://dev.w3.org/html5/spec-LC/syntax.html#cd=
ata-sections>`_."""
+
+    PREFIX: str =3D "<![CDATA["
+    SUFFIX: str =3D "]]>"
+
=20
 class ProcessingInstruction(PreformattedString):
     """A SGML processing instruction."""
=20
-    PREFIX =3D '<?'
-    SUFFIX =3D '>'
+    PREFIX: str =3D "<?"
+    SUFFIX: str =3D ">"
+
=20
 class XMLProcessingInstruction(ProcessingInstruction):
-    """An XML processing instruction."""
-    PREFIX =3D '<?'
-    SUFFIX =3D '?>'
+    """An `XML processing instruction <https://www.w3.org/TR/REC-xml/#se=
c-pi>`_."""
+
+    PREFIX: str =3D "<?"
+    SUFFIX: str =3D "?>"
+
=20
 class Comment(PreformattedString):
-    """An HTML or XML comment."""
-    PREFIX =3D '<!--'
-    SUFFIX =3D '-->'
+    """An `HTML comment <https://dev.w3.org/html5/spec-LC/syntax.html#co=
mments>`_ or `XML comment <https://www.w3.org/TR/REC-xml/#sec-comments>`_=
."""
+
+    PREFIX: str =3D "<!--"
+    SUFFIX: str =3D "-->"
=20
=20
 class Declaration(PreformattedString):
-    """An XML declaration."""
-    PREFIX =3D '<?'
-    SUFFIX =3D '?>'
+    """An `XML declaration <https://www.w3.org/TR/REC-xml/#sec-prolog-dt=
d>`_."""
+
+    PREFIX: str =3D "<?"
+    SUFFIX: str =3D "?>"
=20
=20
 class Doctype(PreformattedString):
-    """A document type declaration."""
+    """A `document type declaration <https://www.w3.org/TR/REC-xml/#dt-d=
octype>`_."""
+
     @classmethod
-    def for_name_and_ids(cls, name, pub_id, system_id):
+    def for_name_and_ids(
+        cls, name: str, pub_id: Optional[str], system_id: Optional[str]
+    ) -> Doctype:
         """Generate an appropriate document type declaration for a given
         public ID and system ID.
=20
@@ -1123,122 +1764,145 @@ class Doctype(PreformattedString):
             e.g. '-//W3C//DTD XHTML 1.1//EN'
         :param system_id: The system identifier for this document type,
             e.g. 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dt=
d'
+        """
+        return Doctype(cls._string_for_name_and_ids(name, pub_id, system=
_id))
=20
-        :return: A Doctype.
+    @classmethod
+    def _string_for_name_and_ids(
+        cls, name: str, pub_id: Optional[str], system_id: Optional[str]
+    ) -> str:
+        """Generate a string to be used as the basis of a Doctype object.
+
+        This is a separate method from for_name_and_ids() because the lx=
ml
+        TreeBuilder needs to call it.
         """
-        value =3D name or ''
+        value =3D name or ""
         if pub_id is not None:
             value +=3D ' PUBLIC "%s"' % pub_id
             if system_id is not None:
                 value +=3D ' "%s"' % system_id
         elif system_id is not None:
             value +=3D ' SYSTEM "%s"' % system_id
+        return value
=20
-        return Doctype(value)
-
-    PREFIX =3D '<!DOCTYPE '
-    SUFFIX =3D '>\n'
+    PREFIX: str =3D "<!DOCTYPE "
+    SUFFIX: str =3D ">\n"
=20
=20
 class Stylesheet(NavigableString):
-    """A NavigableString representing an stylesheet (probably
-    CSS).
+    """A `NavigableString` representing the contents of a `<style> HTML
+    tag <https://dev.w3.org/html5/spec-LC/Overview.html#the-style-elemen=
t>`_
+    (probably CSS).
=20
     Used to distinguish embedded stylesheets from textual content.
     """
-    pass
=20
=20
 class Script(NavigableString):
-    """A NavigableString representing an executable script (probably
-    Javascript).
+    """A `NavigableString` representing the contents of a `<script>
+    HTML tag
+    <https://dev.w3.org/html5/spec-LC/Overview.html#the-script-element>`=
_
+    (probably Javascript).
=20
     Used to distinguish executable code from textual content.
     """
-    pass
=20
=20
 class TemplateString(NavigableString):
-    """A NavigableString representing a string found inside an HTML
-    template embedded in a larger document.
+    """A `NavigableString` representing a string found inside an `HTML
+    <template> tag <https://html.spec.whatwg.org/multipage/scripting.htm=
l#the-template-element>`_
+    embedded in a larger document.
=20
     Used to distinguish such strings from the main body of the document.
     """
-    pass
=20
=20
 class RubyTextString(NavigableString):
-    """A NavigableString representing the contents of the <rt> HTML
-    element.
-
-    https://dev.w3.org/html5/spec-LC/text-level-semantics.html#the-rt-el=
ement
+    """A NavigableString representing the contents of an `<rt> HTML
+    tag <https://dev.w3.org/html5/spec-LC/text-level-semantics.html#the-=
rt-element>`_.
=20
     Can be used to distinguish such strings from the strings they're
     annotating.
     """
-    pass
=20
=20
 class RubyParenthesisString(NavigableString):
-    """A NavigableString representing the contents of the <rp> HTML
-    element.
-
-    https://dev.w3.org/html5/spec-LC/text-level-semantics.html#the-rp-el=
ement
+    """A NavigableString representing the contents of an `<rp> HTML
+    tag <https://dev.w3.org/html5/spec-LC/text-level-semantics.html#the-=
rp-element>`_.
     """
-    pass
=20
=20
 class Tag(PageElement):
-    """Represents an HTML or XML tag that is part of a parse tree, along
-    with its attributes and contents.
+    """An HTML or XML tag that is part of a parse tree, along with its
+    attributes, contents, and relationships to other parts of the tree.
+
+    When Beautiful Soup parses the markup ``<b>penguin</b>``, it will
+    create a `Tag` object representing the ``<b>`` tag. You can
+    instantiate `Tag` objects directly, but it's not necessary unless
+    you're adding entirely new markup to a parsed document. Most of
+    the constructor arguments are intended for use by the `TreeBuilder`
+    that's parsing a document.
+
+    :param parser: A `BeautifulSoup` object representing the parse tree =
this
+        `Tag` will be part of.
+    :param builder: The `TreeBuilder` being used to build the tree.
+    :param name: The name of the tag.
+    :param namespace: The URI of this tag's XML namespace, if any.
+    :param prefix: The prefix for this tag's XML namespace, if any.
+    :param attrs: A dictionary of attribute values.
+    :param parent: The `Tag` to use as the parent of this `Tag`. May be
+       the `BeautifulSoup` object itself.
+    :param previous: The `PageElement` that was parsed immediately befor=
e
+        parsing this tag.
+    :param is_xml: If True, this is an XML tag. Otherwise, this is an
+        HTML tag.
+    :param sourceline: The line number where this tag was found in its
+        source document.
+    :param sourcepos: The character position within ``sourceline`` where=
 this
+        tag was found.
+    :param can_be_empty_element: If True, this tag should be
+        represented as <tag/>. If False, this tag should be represented
+        as <tag></tag>.
+    :param cdata_list_attributes: A dictionary of attributes whose value=
s should
+        be parsed as lists of strings if they ever show up on this tag.
+    :param preserve_whitespace_tags: Names of tags whose contents
+        should have their whitespace preserved if they are encountered i=
nside
+        this tag.
+    :param interesting_string_types: When iterating over this tag's
+        string contents in methods like `Tag.strings` or
+        `PageElement.get_text`, these are the types of strings that are
+        interesting enough to be considered. By default,
+        `NavigableString` (normal strings) and `CData` (CDATA
+        sections) are the only interesting string subtypes.
+    :param namespaces: A dictionary mapping currently active
+        namespace prefixes to URIs, as of the point in the parsing proce=
ss when
+        this tag was encountered. This can be used later to
+        construct CSS selectors.
=20
-    When Beautiful Soup parses the markup <b>penguin</b>, it will
-    create a Tag object representing the <b> tag.
     """
=20
-    def __init__(self, parser=3DNone, builder=3DNone, name=3DNone, names=
pace=3DNone,
-                 prefix=3DNone, attrs=3DNone, parent=3DNone, previous=3D=
None,
-                 is_xml=3DNone, sourceline=3DNone, sourcepos=3DNone,
-                 can_be_empty_element=3DNone, cdata_list_attributes=3DNo=
ne,
-                 preserve_whitespace_tags=3DNone,
-                 interesting_string_types=3DNone,
-                 namespaces=3DNone
+    def __init__(
+        self,
+        parser: Optional[BeautifulSoup] =3D None,
+        builder: Optional[TreeBuilder] =3D None,
+        name: Optional[str] =3D None,
+        namespace: Optional[str] =3D None,
+        prefix: Optional[str] =3D None,
+        attrs: Optional[_RawOrProcessedAttributeValues] =3D None,
+        parent: Optional[Union[BeautifulSoup, Tag]] =3D None,
+        previous: _AtMostOneElement =3D None,
+        is_xml: Optional[bool] =3D None,
+        sourceline: Optional[int] =3D None,
+        sourcepos: Optional[int] =3D None,
+        can_be_empty_element: Optional[bool] =3D None,
+        cdata_list_attributes: Optional[Dict[str, Set[str]]] =3D None,
+        preserve_whitespace_tags: Optional[Set[str]] =3D None,
+        interesting_string_types: Optional[Set[Type[NavigableString]]] =3D=
 None,
+        namespaces: Optional[Dict[str, str]] =3D None,
+        # NOTE: Any new arguments here need to be mirrored in
+        # Tag.copy_self, and potentially BeautifulSoup.new_tag
+        # as well.
     ):
-        """Basic constructor.
-
-        :param parser: A BeautifulSoup object.
-        :param builder: A TreeBuilder.
-        :param name: The name of the tag.
-        :param namespace: The URI of this Tag's XML namespace, if any.
-        :param prefix: The prefix for this Tag's XML namespace, if any.
-        :param attrs: A dictionary of this Tag's attribute values.
-        :param parent: The PageElement to use as this Tag's parent.
-        :param previous: The PageElement that was parsed immediately bef=
ore
-            this tag.
-        :param is_xml: If True, this is an XML tag. Otherwise, this is a=
n
-            HTML tag.
-        :param sourceline: The line number where this tag was found in i=
ts
-            source document.
-        :param sourcepos: The character position within `sourceline` whe=
re this
-            tag was found.
-        :param can_be_empty_element: If True, this tag should be
-            represented as <tag/>. If False, this tag should be represen=
ted
-            as <tag></tag>.
-        :param cdata_list_attributes: A list of attributes whose values =
should
-            be treated as CDATA if they ever show up on this tag.
-        :param preserve_whitespace_tags: A list of tag names whose conte=
nts
-            should have their whitespace preserved.
-        :param interesting_string_types: This is a NavigableString
-            subclass or a tuple of them. When iterating over this
-            Tag's strings in methods like Tag.strings or Tag.get_text,
-            these are the types of strings that are interesting enough
-            to be considered. The default is to consider
-            NavigableString and CData the only interesting string
-            subtypes.
-        :param namespaces: A dictionary mapping currently active
-            namespace prefixes to URIs. This can be used later to
-            construct CSS selectors.
-        """
         if parser is None:
             self.parser_class =3D None
         else:
@@ -1251,20 +1915,44 @@ class Tag(PageElement):
         self.namespace =3D namespace
         self._namespaces =3D namespaces or {}
         self.prefix =3D prefix
-        if ((not builder or builder.store_line_numbers)
-            and (sourceline is not None or sourcepos is not None)):
+        if (not builder or builder.store_line_numbers) and (
+            sourceline is not None or sourcepos is not None
+        ):
+            self.sourceline =3D sourceline
+            self.sourcepos =3D sourcepos
+        else:
             self.sourceline =3D sourceline
             self.sourcepos =3D sourcepos
+
+        attr_dict_class: type[AttributeDict]
+        attribute_value_list_class: type[AttributeValueList]
+        if builder is None:
+            if is_xml:
+                attr_dict_class =3D XMLAttributeDict
+            else:
+                attr_dict_class =3D HTMLAttributeDict
+            attribute_value_list_class =3D AttributeValueList
+        else:
+            attr_dict_class =3D builder.attribute_dict_class
+            attribute_value_list_class =3D builder.attribute_value_list_=
class
+        self.attribute_value_list_class =3D attribute_value_list_class
+
         if attrs is None:
-            attrs =3D {}
-        elif attrs:
+            self.attrs =3D attr_dict_class()
+        else:
             if builder is not None and builder.cdata_list_attributes:
-                attrs =3D builder._replace_cdata_list_attribute_values(
-                    self.name, attrs)
+                self.attrs =3D builder._replace_cdata_list_attribute_val=
ues(
+                    self.name, attrs
+                )
             else:
-                attrs =3D dict(attrs)
-        else:
-            attrs =3D dict(attrs)
+                self.attrs =3D attr_dict_class()
+                # Make sure that the values of any multi-valued
+                # attributes (e.g. when a Tag is copied) are stored in
+                # new lists.
+                for k, v in attrs.items():
+                    if isinstance(v, list):
+                        v =3D v.__class__(v)
+                    self.attrs[k] =3D v
=20
         # If possible, determine ahead of time whether this tag is an
         # XML tag.
@@ -1272,8 +1960,7 @@ class Tag(PageElement):
             self.known_xml =3D builder.is_xml
         else:
             self.known_xml =3D is_xml
-        self.attrs =3D attrs
-        self.contents =3D []
+        self.contents: List[PageElement] =3D []
         self.setup(parent, previous)
         self.hidden =3D False
=20
@@ -1287,6 +1974,7 @@ class Tag(PageElement):
             self.interesting_string_types =3D interesting_string_types
         else:
             # Set up any substitutions for this tag, such as the charset=
 in a META tag.
+            self.attribute_value_list_class =3D builder.attribute_value_=
list_class
             builder.set_up_substitutions(self)
=20
             # Ask the TreeBuilder whether this tag might be an empty-ele=
ment tag.
@@ -1308,113 +1996,149 @@ class Tag(PageElement):
=20
             if self.name in builder.string_containers:
                 # This sort of tag uses a special string container
-                # subclass for most of its strings. When we ask the
-                self.interesting_string_types =3D builder.string_contain=
ers[self.name]
+                # subclass for most of its strings. We need to be able
+                # to look up the proper container subclass.
+                self.interesting_string_types =3D {builder.string_contai=
ners[self.name]}
             else:
-                self.interesting_string_types =3D self.DEFAULT_INTERESTI=
NG_STRING_TYPES
-
-    parserClass =3D _alias("parser_class")  # BS3
-
-    def __deepcopy__(self, memo, recursive=3DTrue):
+                self.interesting_string_types =3D self.MAIN_CONTENT_STRI=
NG_TYPES
+
+    parser_class: Optional[type[BeautifulSoup]]
+    name: str
+    namespace: Optional[str]
+    prefix: Optional[str]
+    attrs: _AttributeValues
+    sourceline: Optional[int]
+    sourcepos: Optional[int]
+    known_xml: Optional[bool]
+    contents: List[PageElement]
+    hidden: bool
+    interesting_string_types: Optional[Set[Type[NavigableString]]]
+
+    can_be_empty_element: Optional[bool]
+    cdata_list_attributes: Optional[Dict[str, Set[str]]]
+    preserve_whitespace_tags: Optional[Set[str]]
+
+    #: :meta private:
+    parserClass =3D _deprecated_alias("parserClass", "parser_class", "4.=
0.0")
+
+    def __deepcopy__(self, memo: Dict[Any, Any], recursive: bool =3D Tru=
e) -> Self:
         """A deepcopy of a Tag is a new Tag, unconnected to the parse tr=
ee.
         Its contents are a copy of the old Tag's contents.
         """
-        clone =3D self._clone()
+        clone =3D self.copy_self()
=20
         if recursive:
             # Clone this tag's descendants recursively, but without
             # making any recursive function calls.
-            tag_stack =3D [clone]
+            tag_stack: List[Tag] =3D [clone]
             for event, element in self._event_stream(self.descendants):
                 if event is Tag.END_ELEMENT_EVENT:
                     # Stop appending incoming Tags to the Tag that was
                     # just closed.
                     tag_stack.pop()
                 else:
-                    descendant_clone =3D element.__deepcopy__(
-                        memo, recursive=3DFalse
-                    )
+                    descendant_clone =3D element.__deepcopy__(memo, recu=
rsive=3DFalse)
                     # Add to its parent's .contents
                     tag_stack[-1].append(descendant_clone)
=20
                     if event is Tag.START_ELEMENT_EVENT:
                         # Add the Tag itself to the stack so that its
                         # children will be .appended to it.
-                        tag_stack.append(descendant_clone)
+                        tag_stack.append(cast(Tag, descendant_clone))
         return clone
=20
-    def __copy__(self):
-        """A copy of a Tag must always be a deep copy, because a Tag's
-        children can only have one parent at a time.
-        """
-        return self.__deepcopy__({})
-
-    def _clone(self):
+    def copy_self(self) -> Self:
         """Create a new Tag just like this one, but with no
         contents and unattached to any parse tree.
=20
-        This is the first step in the deepcopy process.
+        This is the first step in the deepcopy process, but you can
+        call it on its own to create a copy of a Tag without copying its
+        contents.
         """
         clone =3D type(self)(
-            None, None, self.name, self.namespace,
-            self.prefix, self.attrs, is_xml=3Dself._is_xml,
-            sourceline=3Dself.sourceline, sourcepos=3Dself.sourcepos,
+            None,
+            None,
+            self.name,
+            self.namespace,
+            self.prefix,
+            self.attrs,
+            is_xml=3Dself._is_xml,
+            sourceline=3Dself.sourceline,
+            sourcepos=3Dself.sourcepos,
             can_be_empty_element=3Dself.can_be_empty_element,
             cdata_list_attributes=3Dself.cdata_list_attributes,
             preserve_whitespace_tags=3Dself.preserve_whitespace_tags,
-            interesting_string_types=3Dself.interesting_string_types
+            interesting_string_types=3Dself.interesting_string_types,
+            namespaces=3Dself._namespaces,
         )
-        for attr in ('can_be_empty_element', 'hidden'):
+        for attr in ("can_be_empty_element", "hidden"):
             setattr(clone, attr, getattr(self, attr))
         return clone
-   =20
+
     @property
-    def is_empty_element(self):
+    def is_empty_element(self) -> bool:
         """Is this tag an empty-element tag? (aka a self-closing tag)
=20
         A tag that has contents is never an empty-element tag.
=20
         A tag that has no contents may or may not be an empty-element
-        tag. It depends on the builder used to create the tag. If the
-        builder has a designated list of empty-element tags, then only
-        a tag whose name shows up in that list is considered an
-        empty-element tag.
+        tag. It depends on the `TreeBuilder` used to create the
+        tag. If the builder has a designated list of empty-element
+        tags, then only a tag whose name shows up in that list is
+        considered an empty-element tag. This is usually the case
+        for HTML documents.
=20
-        If the builder has no designated list of empty-element tags,
-        then any tag with no contents is an empty-element tag.
+        If the builder has no designated list of empty-element, then
+        any tag with no contents is an empty-element tag. This is usuall=
y
+        the case for XML documents.
         """
-        return len(self.contents) =3D=3D 0 and self.can_be_empty_element
-    isSelfClosing =3D is_empty_element  # BS3
+        return len(self.contents) =3D=3D 0 and self.can_be_empty_element=
 is True
+
+    @_deprecated("is_empty_element", "4.0.0")
+    def isSelfClosing(self) -> bool:
+        ": :meta private:"
+        return self.is_empty_element
=20
     @property
-    def string(self):
+    def string(self) -> Optional[str]:
         """Convenience property to get the single string within this
-        PageElement.
+        `Tag`, assuming there is just one.
=20
-        TODO It might make sense to have NavigableString.string return
-        itself.
+        :return: If this `Tag` has a single child that's a
+         `NavigableString`, the return value is that string. If this
+         element has one child `Tag`, the return value is that child's
+         `Tag.string`, recursively. If this `Tag` has no children,
+         or has more than one child, the return value is ``None``.
=20
-        :return: If this element has a single string child, return
-         value is that string. If this element has one child tag,
-         return value is the 'string' attribute of the child tag,
-         recursively. If this element is itself a string, has no
-         children, or has more than one child, return value is None.
+         If this property is unexpectedly returning ``None`` for you,
+         it's probably because your `Tag` has more than one thing
+         inside it.
         """
         if len(self.contents) !=3D 1:
             return None
         child =3D self.contents[0]
         if isinstance(child, NavigableString):
             return child
-        return child.string
+        elif isinstance(child, Tag):
+            return child.string
+        return None
=20
     @string.setter
-    def string(self, string):
-        """Replace this PageElement's contents with `string`."""
+    def string(self, string: str) -> None:
+        """Replace the `Tag.contents` of this `Tag` with a single string=
."""
         self.clear()
-        self.append(string.__class__(string))
+        if isinstance(string, NavigableString):
+            new_class =3D string.__class__
+        else:
+            new_class =3D NavigableString
+        self.append(new_class(string))
+
+    #: :meta private:
+    MAIN_CONTENT_STRING_TYPES =3D {NavigableString, CData}
=20
-    DEFAULT_INTERESTING_STRING_TYPES =3D (NavigableString, CData)
-    def _all_strings(self, strip=3DFalse, types=3DPageElement.default):
+    def _all_strings(
+        self, strip: bool =3D False, types: _OneOrMoreStringTypes =3D Pa=
geElement.default
+    ) -> Iterator[str]:
         """Yield all strings of certain classes, possibly stripping them.
=20
         :param strip: If True, all strings will be stripped before being
@@ -1427,15 +2151,15 @@ class Tag(PageElement):
             only NavigableString and CData objects will be
             considered. That means no comments, processing
             instructions, etc.
-
-        :yield: A sequence of strings.
-
         """
         if types is self.default:
-            types =3D self.interesting_string_types
+            if self.interesting_string_types is None:
+                types =3D self.MAIN_CONTENT_STRING_TYPES
+            else:
+                types =3D self.interesting_string_types
=20
         for descendant in self.descendants:
-            if (types is None and not isinstance(descendant, NavigableSt=
ring)):
+            if not isinstance(descendant, NavigableString):
                 continue
             descendant_type =3D type(descendant)
             if isinstance(types, type):
@@ -1446,55 +2170,225 @@ class Tag(PageElement):
                 # We're not interested in strings of this type.
                 continue
             if strip:
-                descendant =3D descendant.strip()
-                if len(descendant) =3D=3D 0:
+                stripped =3D descendant.strip()
+                if len(stripped) =3D=3D 0:
                     continue
-            yield descendant
+                yield stripped
+            else:
+                yield descendant
+
     strings =3D property(_all_strings)
=20
-    def decompose(self):
-        """Recursively destroys this PageElement and its children.
+    def insert(self, position: int, *new_children: _InsertableElement) -=
> List[PageElement]:
+        """Insert one or more new PageElements as a child of this `Tag`.
=20
-        This element will be removed from the tree and wiped out; so
-        will everything beneath it.
+        This works similarly to :py:meth:`list.insert`, except you can i=
nsert
+        multiple elements at once.
=20
-        The behavior of a decomposed PageElement is undefined and you
-        should never use one for anything, but if you need to _check_
-        whether an element has been decomposed, you can use the
-        `decomposed` property.
+        :param position: The numeric position that should be occupied
+           in this Tag's `Tag.children` by the first new `PageElement`.
+
+        :param new_children: The PageElements to insert.
+
+        :return The newly inserted PageElements.
         """
-        self.extract()
-        i =3D self
-        while i is not None:
-            n =3D i.next_element
-            i.__dict__.clear()
-            i.contents =3D []
-            i._decomposed =3D True
-            i =3D n
-
-    def clear(self, decompose=3DFalse):
-        """Wipe out all children of this PageElement by calling extract(=
)
-           on them.
-
-        :param decompose: If this is True, decompose() (a more
-            destructive method) will be called instead of extract().
-        """
-        if decompose:
-            for element in self.contents[:]:
-                if isinstance(element, Tag):
-                    element.decompose()
-                else:
-                    element.extract()
+        inserted: List[PageElement] =3D []
+        for new_child in new_children:
+            inserted.extend(self._insert(position, new_child))
+            position +=3D 1
+        return inserted
+
+    def _insert(self, position: int, new_child: _InsertableElement) -> L=
ist[PageElement]:
+        if new_child is None:
+            raise ValueError("Cannot insert None into a tag.")
+        if new_child is self:
+            raise ValueError("Cannot insert a tag into itself.")
+        if isinstance(new_child, str) and not isinstance(new_child, Navi=
gableString):
+            new_child =3D NavigableString(new_child)
+
+        from bb._vendor.bs4 import BeautifulSoup
+        if isinstance(new_child, BeautifulSoup):
+            # We don't want to end up with a situation where one Beautif=
ulSoup
+            # object contains another. Insert the BeautifulSoup's childr=
en and
+            # return them.
+            return self.insert(position, *list(new_child.contents))
+        position =3D min(position, len(self.contents))
+        if hasattr(new_child, "parent") and new_child.parent is not None=
:
+            # We're 'inserting' an element that's already one
+            # of this object's children.
+            if new_child.parent is self:
+                current_index =3D self.index(new_child)
+                if current_index < position:
+                    # We're moving this element further down the list
+                    # of this object's children. That means that when
+                    # we extract this element, our target index will
+                    # jump down one.
+                    position -=3D 1
+                elif current_index =3D=3D position:
+                    # We're 'inserting' an element into its current loca=
tion.
+                    # This is a no-op.
+                    return [new_child]
+            new_child.extract()
+
+        new_child.parent =3D self
+        previous_child =3D None
+        if position =3D=3D 0:
+            new_child.previous_sibling =3D None
+            new_child.previous_element =3D self
+        else:
+            previous_child =3D self.contents[position - 1]
+            new_child.previous_sibling =3D previous_child
+            new_child.previous_sibling.next_sibling =3D new_child
+            new_child.previous_element =3D previous_child._last_descenda=
nt(False)
+        if new_child.previous_element is not None:
+            new_child.previous_element.next_element =3D new_child
+
+        new_childs_last_element =3D new_child._last_descendant(
+            is_initialized=3DFalse, accept_self=3DTrue
+        )
+        # new_childs_last_element can't be None because we passed
+        # accept_self=3DTrue into _last_descendant. Worst case,
+        # new_childs_last_element will be new_child itself. Making
+        # this cast removes several mypy complaints later on as we
+        # manipulate new_childs_last_element.
+        new_childs_last_element =3D cast(PageElement, new_childs_last_el=
ement)
+
+        if position >=3D len(self.contents):
+            new_child.next_sibling =3D None
+
+            parent: Optional[Tag] =3D self
+            parents_next_sibling =3D None
+            while parents_next_sibling is None and parent is not None:
+                parents_next_sibling =3D parent.next_sibling
+                parent =3D parent.parent
+                if parents_next_sibling is not None:
+                    # We found the element that comes next in the docume=
nt.
+                    break
+            if parents_next_sibling is not None:
+                new_childs_last_element.next_element =3D parents_next_si=
bling
+            else:
+                # The last element of this tag is the last element in
+                # the document.
+                new_childs_last_element.next_element =3D None
+        else:
+            next_child =3D self.contents[position]
+            new_child.next_sibling =3D next_child
+            if new_child.next_sibling is not None:
+                new_child.next_sibling.previous_sibling =3D new_child
+            new_childs_last_element.next_element =3D next_child
+
+        if new_childs_last_element.next_element is not None:
+            new_childs_last_element.next_element.previous_element =3D (
+                new_childs_last_element
+            )
+        self.contents.insert(position, new_child)
+
+        return [new_child]
+
+    def unwrap(self) -> Self:
+        """Replace this `PageElement` with its contents.
+
+        :return: This object, no longer part of the tree.
+        """
+        my_parent =3D self.parent
+        if my_parent is None:
+            raise ValueError(
+                "Cannot replace an element with its contents when that "
+                "element is not part of a tree."
+            )
+        my_index =3D my_parent.index(self)
+        self.extract(_self_index=3Dmy_index)
+        for child in reversed(self.contents[:]):
+            my_parent.insert(my_index, child)
+        return self
+
+    replace_with_children =3D unwrap
+
+    @_deprecated("unwrap", "4.0.0")
+    def replaceWithChildren(self) -> _OneElement:
+        ": :meta private:"
+        return self.unwrap()
+
+    def append(self, tag: _InsertableElement) -> PageElement|List[PageEl=
ement]:
+        """Appends the given `PageElement` to the contents of this `Tag`.
+
+        :param tag: A PageElement. If this is another BeautifulSoup
+           object, all of its contents will be inserted into this
+           `Tag`, since one BeautifulSoup object can't contain another
+           one.
+
+        :return: The object that was just appended, or (if `tag` was a B=
eautifulSoup
+           object) all such objects.
+        """
+        inserted =3D self.insert(len(self.contents), tag)
+        if isinstance(tag, Tag) and tag.name =3D=3D "[document]": # TODO=
: can't reference BeautifulSoup class in this module
+            return inserted
         else:
-            for element in self.contents[:]:
+            return inserted[0]
+
+    def extend(self, tags: Union[Iterable[_InsertableElement], Tag]) -> =
List[PageElement]:
+        """Appends one or more objects to the contents of this
+        `Tag`.
+
+        :param tags: If a list of `PageElement` objects is provided,
+            they will be appended to this tag's contents, one at a time.
+            If a single `Tag` is provided, its `Tag.contents` will be
+            used to extend this object's `Tag.contents`.
+
+        :return The list of PageElements that were appended.
+        """
+        tag_list: Iterable[_InsertableElement]
+
+        if isinstance(tags, Tag):
+            tag_list =3D list(tags.contents)
+        elif isinstance(tags, (PageElement, str)):
+            # The caller should really be using append() instead,
+            # but we can make it work.
+            warnings.warn(
+                "A single non-Tag item was passed into Tag.extend. Use T=
ag.append instead.",
+                UserWarning,
+                stacklevel=3D2,
+            )
+            if isinstance(tags, str) and not isinstance(tags, PageElemen=
t):
+                tags =3D NavigableString(tags)
+            tag_list =3D [tags]
+        elif isinstance(tags, Iterable):
+            # Moving items around the tree may change their position in
+            # the original list. Make a list that won't change.
+            tag_list =3D list(tags)
+
+        results: List[PageElement] =3D []
+        for tag in tag_list:
+            appended =3D self.append(tag)
+            if isinstance(appended, list):
+                # This can happen if you pass in a mixture of Tag and Be=
autifulSoup objects.
+                results.extend(appended)
+            else:
+                results.append(appended)
+
+        return results
+
+    def clear(self, decompose: bool =3D False) -> None:
+        """Destroy all children of this `Tag` by calling
+           `PageElement.extract` on them.
+
+        :param decompose: If this is True, `PageElement.decompose` (a
+            more destructive method) will be called instead of
+            `PageElement.extract`.
+        """
+        for element in self.contents[:]:
+            if decompose:
+                element.decompose()
+            else:
                 element.extract()
=20
-    def smooth(self):
-        """Smooth out this element's children by consolidating consecuti=
ve
+    def smooth(self) -> None:
+        """Smooth out the children of this `Tag` by consolidating consec=
utive
         strings.
=20
-        This makes pretty-printed output look more natural following a
-        lot of operations that modified the tree.
+        If you perform a lot of operations that modify the tree,
+        calling this method afterwards can make pretty-printed output
+        look more natural.
         """
         # Mark the first position of every pair of children that need
         # to be consolidated.  Do this rather than making a copy of
@@ -1505,12 +2399,13 @@ class Tag(PageElement):
             if isinstance(a, Tag):
                 # Recursively smooth children.
                 a.smooth()
-            if i =3D=3D len(self.contents)-1:
+            if i =3D=3D len(self.contents) - 1:
                 # This is the last item in .contents, and it's not a
                 # tag. There's no chance it needs any work.
                 continue
-            b =3D self.contents[i+1]
-            if (isinstance(a, NavigableString)
+            b =3D self.contents[i + 1]
+            if (
+                isinstance(a, NavigableString)
                 and isinstance(b, NavigableString)
                 and not isinstance(a, PreformattedString)
                 and not isinstance(b, PreformattedString)
@@ -1521,175 +2416,276 @@ class Tag(PageElement):
         # removing items from .contents won't affect the remaining
         # positions.
         for i in reversed(marked):
-            a =3D self.contents[i]
-            b =3D self.contents[i+1]
+            a =3D cast(NavigableString, self.contents[i])
+            b =3D cast(NavigableString, self.contents[i + 1])
             b.extract()
-            n =3D NavigableString(a+b)
+            n =3D NavigableString(a + b)
             a.replace_with(n)
=20
-    def index(self, element):
-        """Find the index of a child by identity, not value.
+    def index(self, element: PageElement) -> int:
+        """Find the index of a child of this `Tag` (by identity, not val=
ue).
=20
-        Avoids issues with tag.contents.index(element) getting the
-        index of equal elements.
+        Doing this by identity avoids issues when a `Tag` contains two
+        children that have string equality.
=20
-        :param element: Look for this PageElement in `self.contents`.
+        :param element: Look for this `PageElement` in this object's con=
tents.
         """
         for i, child in enumerate(self.contents):
             if child is element:
                 return i
         raise ValueError("Tag.index: element not in tag")
=20
-    def get(self, key, default=3DNone):
+    def get(
+        self, key: str, default: Optional[_AttributeValue] =3D None
+    ) -> Optional[_AttributeValue]:
         """Returns the value of the 'key' attribute for the tag, or
         the value given for 'default' if it doesn't have that
-        attribute."""
+        attribute.
+
+        :param key: The attribute to look for.
+        :param default: Use this value if the attribute is not present
+            on this `Tag`.
+        """
         return self.attrs.get(key, default)
=20
-    def get_attribute_list(self, key, default=3DNone):
-        """The same as get(), but always returns a list.
+    def get_attribute_list(
+        self, key: str, default: Optional[AttributeValueList] =3D None
+    ) -> AttributeValueList:
+        """The same as get(), but always returns a (possibly empty) list.
=20
         :param key: The attribute to look for.
         :param default: Use this value if the attribute is not present
-            on this PageElement.
-        :return: A list of values, probably containing only a single
+            on this `Tag`.
+        :return: A list of strings, usually empty or containing only a s=
ingle
             value.
         """
+        list_value: AttributeValueList
         value =3D self.get(key, default)
-        if not isinstance(value, list):
-            value =3D [value]
-        return value
+        if value is None:
+            list_value =3D self.attribute_value_list_class()
+        elif isinstance(value, list):
+            list_value =3D value
+        else:
+            if not isinstance(value, str):
+                value =3D cast(str, value)
+            list_value =3D self.attribute_value_list_class([value])
+        return list_value
=20
-    def has_attr(self, key):
-        """Does this PageElement have an attribute with the given name?"=
""
+    def has_attr(self, key: str) -> bool:
+        """Does this `Tag` have an attribute with the given name?"""
         return key in self.attrs
=20
-    def __hash__(self):
+    def __hash__(self) -> int:
         return str(self).__hash__()
=20
-    def __getitem__(self, key):
+    def __getitem__(self, key: str) -> _AttributeValue:
         """tag[key] returns the value of the 'key' attribute for the Tag=
,
         and throws an exception if it's not there."""
         return self.attrs[key]
=20
-    def __iter__(self):
+    def __iter__(self) -> Iterator[PageElement]:
         "Iterating over a Tag iterates over its contents."
         return iter(self.contents)
=20
-    def __len__(self):
+    def __len__(self) -> int:
         "The length of a Tag is the length of its list of contents."
         return len(self.contents)
=20
-    def __contains__(self, x):
+    def __contains__(self, x: Any) -> bool:
         return x in self.contents
=20
-    def __bool__(self):
+    def __bool__(self) -> bool:
         "A tag is non-None even if it has no contents."
         return True
=20
-    def __setitem__(self, key, value):
+    def __setitem__(self, key: str, value: _AttributeValue) -> None:
         """Setting tag[key] sets the value of the 'key' attribute for th=
e
         tag."""
         self.attrs[key] =3D value
=20
-    def __delitem__(self, key):
+    def __delitem__(self, key: str) -> None:
         "Deleting tag[key] deletes all 'key' attributes for the tag."
         self.attrs.pop(key, None)
=20
-    def __call__(self, *args, **kwargs):
+    # Since Tag.__call__ is effectively the same as PageElement.find_all=
, see find_all for notes
+    # on these overloads.
+
+    @overload
+    def __call__(
+        self,
+        name: None =3D None,
+        attrs: None =3D None,
+        recursive: bool =3D True,
+        *,
+        string: _StrainableString,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _SomeNavigableStrings:
+        ...
+
+    @overload
+    def __call__(
+        self,
+        name: None =3D None,
+        attrs: None =3D None,
+        recursive: bool =3D True,
+        string: None =3D None,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _SomeTags:
+        ...
+
+    @overload
+    def __call__(
+        self,
+        name: None,
+        attrs: _StrainableAttributes,
+        recursive: bool =3D True,
+        string: None =3D None,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _SomeTags:
+        ...
+
+    @overload
+    def __call__(
+        self,
+        name: _FindMethodName,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        recursive: bool =3D True,
+        string: Optional[_StrainableString] =3D None,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _SomeTags:
+        ...
+
+    def __call__(
+        self,
+        name: _OptionalFindMethodName =3D None,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        recursive: bool =3D True,
+        string: Optional[_StrainableString] =3D None,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> Union[_SomeTags,_SomeNavigableStrings,_QueryResults]:
         """Calling a Tag like a function is the same as calling its
-        find_all() method. Eg. tag('a') returns a list of all the A tags
-        found within this tag."""
-        return self.find_all(*args, **kwargs)
+        find_all() method.
=20
-    def __getattr__(self, tag):
+        Eg. tag('a') returns a list of all the A tags found within this =
tag.
+        """
+        return self._find_all(name, attrs, string, limit, self._generato=
r_for_recursive(recursive), **kwargs)
+
+    def __getattr__(self, subtag: str) -> Optional[Tag]:
         """Calling tag.subtag is the same as calling tag.find(name=3D"su=
btag")"""
-        #print("Getattr %s.%s" % (self.__class__, tag))
-        if len(tag) > 3 and tag.endswith('Tag'):
+        # print("Getattr %s.%s" % (self.__class__, tag))
+        result: _AtMostOneElement
+        if len(subtag) > 3 and subtag.endswith("Tag"):
             # BS3: soup.aTag -> "soup.find("a")
-            tag_name =3D tag[:-3]
+            tag_name =3D subtag[:-3]
             warnings.warn(
-                '.%(name)sTag is deprecated, use .find("%(name)s") inste=
ad. If you really were looking for a tag called %(name)sTag, use .find("%=
(name)sTag")' % dict(
-                    name=3Dtag_name
-                ),
-                DeprecationWarning, stacklevel=3D2
+                '.%(name)sTag is deprecated, use .find("%(name)s") inste=
ad. If you really were looking for a tag called %(name)sTag, use .find("%=
(name)sTag")'
+                % dict(name=3Dtag_name),
+                DeprecationWarning,
+                stacklevel=3D2,
             )
-            return self.find(tag_name)
+            result =3D self.find(tag_name)
         # We special case contents to avoid recursion.
-        elif not tag.startswith("__") and not tag =3D=3D "contents":
-            return self.find(tag)
-        raise AttributeError(
-            "'%s' object has no attribute '%s'" % (self.__class__, tag))
+        elif not subtag.startswith("__") and not subtag =3D=3D "contents=
":
+            result =3D self.find(subtag)
+        else:
+            raise AttributeError(
+                "'%s' object has no attribute '%s'" % (self.__class__, s=
ubtag)
+            )
+        return result
=20
-    def __eq__(self, other):
+    def __eq__(self, other: Any) -> bool:
         """Returns true iff this Tag has the same name, the same attribu=
tes,
         and the same contents (recursively) as `other`."""
         if self is other:
             return True
-        if (not hasattr(other, 'name') or
-            not hasattr(other, 'attrs') or
-            not hasattr(other, 'contents') or
-            self.name !=3D other.name or
-            self.attrs !=3D other.attrs or
-            len(self) !=3D len(other)):
+        if not isinstance(other, Tag):
+            return False
+        if (
+            not hasattr(other, "name")
+            or not hasattr(other, "attrs")
+            or not hasattr(other, "contents")
+            or self.name !=3D other.name
+            or self.attrs !=3D other.attrs
+            or len(self) !=3D len(other)
+        ):
             return False
         for i, my_child in enumerate(self.contents):
             if my_child !=3D other.contents[i]:
                 return False
         return True
=20
-    def __ne__(self, other):
+    def __ne__(self, other: Any) -> bool:
         """Returns true iff this Tag is not identical to `other`,
         as defined in __eq__."""
         return not self =3D=3D other
=20
-    def __repr__(self, encoding=3D"unicode-escape"):
-        """Renders this PageElement as a string.
-
-        :param encoding: The encoding to use (Python 2 only).
-            TODO: This is now ignored and a warning should be issued
-            if a value is provided.
-        :return: A (Unicode) string.
-        """
-        # "The return value must be a string object", i.e. Unicode
-        return self.decode()
-
-    def __unicode__(self):
-        """Renders this PageElement as a Unicode string."""
+    def __repr__(self) -> str:
+        """Renders this `Tag` as a string."""
         return self.decode()
=20
-    __str__ =3D __repr__ =3D __unicode__
+    __str__ =3D __unicode__ =3D __repr__
=20
-    def encode(self, encoding=3DDEFAULT_OUTPUT_ENCODING,
-               indent_level=3DNone, formatter=3D"minimal",
-               errors=3D"xmlcharrefreplace"):
-        """Render a bytestring representation of this PageElement and it=
s
-        contents.
+    def encode(
+        self,
+        encoding: _Encoding =3D DEFAULT_OUTPUT_ENCODING,
+        indent_level: Optional[int] =3D None,
+        formatter: _FormatterOrName =3D "minimal",
+        errors: str =3D "xmlcharrefreplace",
+    ) -> bytes:
+        """Render this `Tag` and its contents as a bytestring.
=20
-        :param encoding: The destination encoding.
+        :param encoding: The encoding to use when converting to
+           a bytestring. This may also affect the text of the document,
+           specifically any encoding declarations within the document.
         :param indent_level: Each line of the rendering will be
-           indented this many levels. (The formatter decides what a
-           'level' means in terms of spaces or other characters
-           output.) Used internally in recursive calls while
+           indented this many levels. (The ``formatter`` decides what a
+           'level' means, in terms of spaces or other characters
+           output.) This is used internally in recursive calls while
            pretty-printing.
-        :param formatter: A Formatter object, or a string naming one of
+        :param formatter: Either a `Formatter` object, or a string namin=
g one of
             the standard formatters.
         :param errors: An error handling strategy such as
             'xmlcharrefreplace'. This value is passed along into
-            encode() and its value should be one of the constants
-            defined by Python.
-        :return: A bytestring.
-
+            :py:meth:`str.encode` and its value should be one of the `er=
ror
+            handling constants defined by Python's codecs module
+            <https://docs.python.org/3/library/codecs.html#error-handler=
s>`_.
         """
         # Turn the data structure into Unicode, then encode the
         # Unicode.
         u =3D self.decode(indent_level, encoding, formatter)
         return u.encode(encoding, errors)
=20
-    def decode(self, indent_level=3DNone,
-               eventual_encoding=3DDEFAULT_OUTPUT_ENCODING,
-               formatter=3D"minimal",
-               iterator=3DNone):
+    def decode(
+        self,
+        indent_level: Optional[int] =3D None,
+        eventual_encoding: _Encoding =3D DEFAULT_OUTPUT_ENCODING,
+        formatter: _FormatterOrName =3D "minimal",
+        iterator: Optional[Iterator[PageElement]] =3D None,
+    ) -> str:
+        """Render this `Tag` and its contents as a Unicode string.
+
+        :param indent_level: Each line of the rendering will be
+           indented this many levels. (The ``formatter`` decides what a
+           'level' means, in terms of spaces or other characters
+           output.) This is used internally in recursive calls while
+           pretty-printing.
+        :param encoding: The encoding you intend to use when
+           converting the string to a bytestring. decode() is *not*
+           responsible for performing that encoding. This information
+           is needed so that a real encoding can be substituted in if
+           the document contains an encoding declaration (e.g. in a
+           <meta> tag).
+        :param formatter: Either a `Formatter` object, or a string
+            naming one of the standard formatters.
+        :param iterator: The iterator to use when navigating over the
+            parse tree. This is only used by `Tag.decode_contents` and
+            you probably won't need to use it.
+        """
         pieces =3D []
         # First off, turn a non-Formatter `formatter` into a Formatter
         # object. This will stop the lookup from happening over and
@@ -1710,16 +2706,15 @@ class Tag(PageElement):
=20
         for event, element in self._event_stream(iterator):
             if event in (Tag.START_ELEMENT_EVENT, Tag.EMPTY_ELEMENT_EVEN=
T):
-                piece =3D element._format_tag(
-                    eventual_encoding, formatter, opening=3DTrue
-                )
+                element =3D cast(Tag, element)
+                piece =3D element._format_tag(eventual_encoding, formatt=
er, opening=3DTrue)
             elif event is Tag.END_ELEMENT_EVENT:
-                piece =3D element._format_tag(
-                    eventual_encoding, formatter, opening=3DFalse
-                )
+                element =3D cast(Tag, element)
+                piece =3D element._format_tag(eventual_encoding, formatt=
er, opening=3DFalse)
                 if indent_level is not None:
                     indent_level -=3D 1
             else:
+                element =3D cast(NavigableString, element)
                 piece =3D element.output_ready(formatter)
=20
             # Now we need to apply the 'prettiness' -- extra
@@ -1739,18 +2734,19 @@ class Tag(PageElement):
             # The only time the behavior is more complex than that is
             # when we encounter an opening or closing tag that might
             # put us into or out of string literal mode.
-            if (event is Tag.START_ELEMENT_EVENT
+            if (
+                event is Tag.START_ELEMENT_EVENT
                 and not string_literal_tag
-                and not element._should_pretty_print()):
-                    # We are about to enter string literal mode. Add
-                    # whitespace before this tag, but not after. We
-                    # will stay in string literal mode until this tag
-                    # is closed.
-                    indent_before =3D True
-                    indent_after =3D False
-                    string_literal_tag =3D element
-            elif (event is Tag.END_ELEMENT_EVENT
-                  and element is string_literal_tag):
+                and not cast(Tag, element)._should_pretty_print()
+            ):
+                # We are about to enter string literal mode. Add
+                # whitespace before this tag, but not after. We
+                # will stay in string literal mode until this tag
+                # is closed.
+                indent_before =3D True
+                indent_after =3D False
+                string_literal_tag =3D element
+            elif event is Tag.END_ELEMENT_EVENT and element is string_li=
teral_tag:
                 # We are about to exit string literal mode by closing
                 # the tag that sent us into that mode. Add whitespace
                 # after this tag, but not before.
@@ -1761,26 +2757,34 @@ class Tag(PageElement):
             # Now we know whether to add whitespace before and/or
             # after this element.
             if indent_level is not None:
-                if (indent_before or indent_after):
+                if indent_before or indent_after:
                     if isinstance(element, NavigableString):
                         piece =3D piece.strip()
                     if piece:
                         piece =3D self._indent_string(
-                            piece, indent_level, formatter,
-                            indent_before, indent_after
+                            piece, indent_level, formatter, indent_befor=
e, indent_after
                         )
                 if event =3D=3D Tag.START_ELEMENT_EVENT:
                     indent_level +=3D 1
             pieces.append(piece)
         return "".join(pieces)
=20
-    # Names for the different events yielded by _event_stream
-    START_ELEMENT_EVENT =3D object()
-    END_ELEMENT_EVENT =3D object()
-    EMPTY_ELEMENT_EVENT =3D object()
-    STRING_ELEMENT_EVENT =3D object()
+    class _TreeTraversalEvent(object):
+        """An internal class representing an event in the process
+        of traversing a parse tree.
=20
-    def _event_stream(self, iterator=3DNone):
+        :meta private:
+        """
+
+    # Stand-ins for the different events yielded by _event_stream
+    START_ELEMENT_EVENT =3D _TreeTraversalEvent()  #: :meta private:
+    END_ELEMENT_EVENT =3D _TreeTraversalEvent()  #: :meta private:
+    EMPTY_ELEMENT_EVENT =3D _TreeTraversalEvent()  #: :meta private:
+    STRING_ELEMENT_EVENT =3D _TreeTraversalEvent()  #: :meta private:
+
+    def _event_stream(
+        self, iterator: Optional[Iterator[PageElement]] =3D None
+    ) -> Iterator[Tuple[_TreeTraversalEvent, PageElement]]:
         """Yield a sequence of events that can be used to reconstruct th=
e DOM
         for this element.
=20
@@ -1796,7 +2800,7 @@ class Tag(PageElement):
         :param iterator: An alternate iterator to use when traversing
          the tree.
         """
-        tag_stack =3D []
+        tag_stack: List[Tag] =3D []
=20
         iterator =3D iterator or self.self_and_descendants
=20
@@ -1822,8 +2826,14 @@ class Tag(PageElement):
             now_closed_tag =3D tag_stack.pop()
             yield Tag.END_ELEMENT_EVENT, now_closed_tag
=20
-    def _indent_string(self, s, indent_level, formatter,
-                       indent_before, indent_after):
+    def _indent_string(
+        self,
+        s: str,
+        indent_level: int,
+        formatter: Formatter,
+        indent_before: bool,
+        indent_after: bool,
+    ) -> str:
         """Add indentation whitespace before and/or after a string.
=20
         :param s: The string to amend with whitespace.
@@ -1834,36 +2844,38 @@ class Tag(PageElement):
         :param indent_after: Whether or not to add whitespace
            (a newline) after the string.
         """
-        space_before =3D ''
+        space_before =3D ""
         if indent_before and indent_level:
-            space_before =3D (formatter.indent * indent_level)
+            space_before =3D formatter.indent * indent_level
=20
-        space_after =3D ''
+        space_after =3D ""
         if indent_after:
             space_after =3D "\n"
=20
         return space_before + s + space_after
=20
-    def _format_tag(self, eventual_encoding, formatter, opening):
+    def _format_tag(
+        self, eventual_encoding: str, formatter: Formatter, opening: boo=
l
+    ) -> str:
         if self.hidden:
             # A hidden tag is invisible, although its contents
             # are visible.
-            return ''
+            return ""
=20
         # A tag starts with the < character (see below).
=20
         # Then the / character, if this is a closing tag.
-        closing_slash =3D ''
+        closing_slash =3D ""
         if not opening:
-            closing_slash =3D '/'
+            closing_slash =3D "/"
=20
         # Then an optional namespace prefix.
-        prefix =3D ''
+        prefix =3D ""
         if self.prefix:
             prefix =3D self.prefix + ":"
=20
         # Then a list of attribute values, if this is an opening tag.
-        attribute_string =3D ''
+        attribute_string =3D ""
         if opening:
             attributes =3D formatter.attributes(self)
             attrs =3D []
@@ -1872,64 +2884,89 @@ class Tag(PageElement):
                     decoded =3D key
                 else:
                     if isinstance(val, list) or isinstance(val, tuple):
-                        val =3D ' '.join(val)
+                        val =3D " ".join(val)
                     elif not isinstance(val, str):
                         val =3D str(val)
                     elif (
-                            isinstance(val, AttributeValueWithCharsetSub=
stitution)
-                            and eventual_encoding is not None
+                        isinstance(val, AttributeValueWithCharsetSubstit=
ution)
+                        and eventual_encoding is not None
                     ):
-                        val =3D val.encode(eventual_encoding)
+                        val =3D val.substitute_encoding(eventual_encodin=
g)
=20
                     text =3D formatter.attribute_value(val)
-                    decoded =3D (
-                        str(key) + '=3D'
-                        + formatter.quoted_attribute_value(text))
+                    decoded =3D str(key) + "=3D" + formatter.quoted_attr=
ibute_value(text)
                 attrs.append(decoded)
             if attrs:
-                attribute_string =3D ' ' + ' '.join(attrs)
+                attribute_string =3D " " + " ".join(attrs)
=20
         # Then an optional closing slash (for a void element in an
         # XML document).
-        void_element_closing_slash =3D ''
+        void_element_closing_slash =3D ""
         if self.is_empty_element:
-            void_element_closing_slash =3D formatter.void_element_close_=
prefix or ''
+            void_element_closing_slash =3D formatter.void_element_close_=
prefix or ""
=20
         # Put it all together.
-        return '<' + closing_slash + prefix + self.name + attribute_stri=
ng + void_element_closing_slash + '>'
+        return (
+            "<"
+            + closing_slash
+            + prefix
+            + self.name
+            + attribute_string
+            + void_element_closing_slash
+            + ">"
+        )
=20
-    def _should_pretty_print(self, indent_level=3D1):
+    def _should_pretty_print(self, indent_level: int =3D 1) -> bool:
         """Should this tag be pretty-printed?
=20
         Most of them should, but some (such as <pre> in HTML
         documents) should not.
         """
-        return (
-            indent_level is not None
-            and (
-                not self.preserve_whitespace_tags
-                or self.name not in self.preserve_whitespace_tags
-            )
+        return indent_level is not None and (
+            not self.preserve_whitespace_tags
+            or self.name not in self.preserve_whitespace_tags
         )
=20
-    def prettify(self, encoding=3DNone, formatter=3D"minimal"):
-        """Pretty-print this PageElement as a string.
-
-        :param encoding: The eventual encoding of the string. If this is=
 None,
-            a Unicode string will be returned.
+    @overload
+    def prettify(
+        self,
+        encoding: None =3D None,
+        formatter: _FormatterOrName =3D "minimal",
+    ) -> str:
+        ...
+
+    @overload
+    def prettify(
+        self,
+        encoding: _Encoding,
+        formatter: _FormatterOrName =3D "minimal",
+    ) -> bytes:
+        ...
+
+    def prettify(
+        self,
+        encoding: Optional[_Encoding] =3D None,
+        formatter: _FormatterOrName =3D "minimal",
+    ) -> Union[str, bytes]:
+        """Pretty-print this `Tag` as a string or bytestring.
+
+        :param encoding: The encoding of the bytestring, or None if you =
want Unicode.
         :param formatter: A Formatter object, or a string naming one of
             the standard formatters.
-        :return: A Unicode string (if encoding=3D=3DNone) or a bytestrin=
g
+        :return: A string (if no ``encoding`` is provided) or a bytestri=
ng
             (otherwise).
         """
         if encoding is None:
-            return self.decode(True, formatter=3Dformatter)
+            return self.decode(indent_level=3D0, formatter=3Dformatter)
         else:
-            return self.encode(encoding, True, formatter=3Dformatter)
-
-    def decode_contents(self, indent_level=3DNone,
-                       eventual_encoding=3DDEFAULT_OUTPUT_ENCODING,
-                       formatter=3D"minimal"):
+            return self.encode(encoding=3Dencoding, indent_level=3D0, fo=
rmatter=3Dformatter)
+
+    def decode_contents(
+        self,
+        indent_level: Optional[int] =3D None,
+        eventual_encoding: _Encoding =3D DEFAULT_OUTPUT_ENCODING,
+        formatter: _FormatterOrName =3D "minimal",
+    ) -> str:
         """Renders the contents of this tag as a Unicode string.
=20
         :param indent_level: Each line of the rendering will be
@@ -1939,53 +2976,138 @@ class Tag(PageElement):
            pretty-printing.
=20
         :param eventual_encoding: The tag is destined to be
-           encoded into this encoding. decode_contents() is _not_
+           encoded into this encoding. decode_contents() is *not*
            responsible for performing that encoding. This information
-           is passed in so that it can be substituted in if the
-           document contains a <META> tag that mentions the document's
-           encoding.
+           is needed so that a real encoding can be substituted in if
+           the document contains an encoding declaration (e.g. in a
+           <meta> tag).
=20
-        :param formatter: A Formatter object, or a string naming one of
+        :param formatter: A `Formatter` object, or a string naming one o=
f
             the standard Formatters.
-
         """
-        return self.decode(indent_level, eventual_encoding, formatter,
-                           iterator=3Dself.descendants)
+        return self.decode(
+            indent_level, eventual_encoding, formatter, iterator=3Dself.=
descendants
+        )
=20
     def encode_contents(
-        self, indent_level=3DNone, encoding=3DDEFAULT_OUTPUT_ENCODING,
-        formatter=3D"minimal"):
+        self,
+        indent_level: Optional[int] =3D None,
+        encoding: _Encoding =3D DEFAULT_OUTPUT_ENCODING,
+        formatter: _FormatterOrName =3D "minimal",
+    ) -> bytes:
         """Renders the contents of this PageElement as a bytestring.
=20
         :param indent_level: Each line of the rendering will be
-           indented this many levels. (The formatter decides what a
-           'level' means in terms of spaces or other characters
-           output.) Used internally in recursive calls while
+           indented this many levels. (The ``formatter`` decides what a
+           'level' means, in terms of spaces or other characters
+           output.) This is used internally in recursive calls while
            pretty-printing.
-
-        :param eventual_encoding: The bytestring will be in this encodin=
g.
-
-        :param formatter: A Formatter object, or a string naming one of
-            the standard Formatters.
-
-        :return: A bytestring.
+        :param formatter: Either a `Formatter` object, or a string namin=
g one of
+            the standard formatters.
+        :param encoding: The bytestring will be in this encoding.
         """
         contents =3D self.decode_contents(indent_level, encoding, format=
ter)
         return contents.encode(encoding)
=20
-    # Old method for BS3 compatibility
-    def renderContents(self, encoding=3DDEFAULT_OUTPUT_ENCODING,
-                       prettyPrint=3DFalse, indentLevel=3D0):
-        """Deprecated method for BS3 compatibility."""
+    @_deprecated("encode_contents", "4.0.0")
+    def renderContents(
+        self,
+        encoding: _Encoding =3D DEFAULT_OUTPUT_ENCODING,
+        prettyPrint: bool =3D False,
+        indentLevel: Optional[int] =3D 0,
+    ) -> bytes:
+        """Deprecated method for BS3 compatibility.
+
+        :meta private:
+        """
         if not prettyPrint:
             indentLevel =3D None
-        return self.encode_contents(
-            indent_level=3DindentLevel, encoding=3Dencoding)
-
-    #Soup methods
-
-    def find(self, name=3DNone, attrs=3D{}, recursive=3DTrue, string=3DN=
one,
-             **kwargs):
+        return self.encode_contents(indent_level=3DindentLevel, encoding=
=3Dencoding)
+
+    # Soup methods
+    #
+
+    # People who call these methods in a type-safe environment
+    # basically want to know whether the call is going to return
+    # NavigableStrings or Tags. It's always one or the other, never
+    # both, but spelling it out requires a number of overloads for
+    # each method.
+    #
+    # If I had it to do over again I'd design this API differently (it
+    # would look more like ElementFilter), but that's life.
+    #
+    # The overloads all look for a clue in the input which restricts
+    # the method to returning either only strings or only tags. Only
+    # the most common cases are covered.
+
+    # e.g. find(string=3D"foo")
+    #   -> string information but no tag information
+    #     -> string
+    @overload
+    def find(
+        self,
+        name: None =3D None,
+        attrs: None =3D None,
+        recursive: bool =3D True,
+        *,
+        string: _StrainableString,
+        **kwargs: _StrainableAttribute,
+    ) -> _AtMostOneNavigableString:
+        ...
+
+    # e.g. find() -> default behavior -> tag
+    #      find(attr=3D"value") -> only tags have attrs -> tag
+    @overload
+    def find(
+            self,
+            name: None =3D None,
+            attrs: None =3D None,
+            recursive: bool =3D True,
+            string: None =3D None,
+            **kwargs: _StrainableAttribute,
+    ) -> _AtMostOneTag:
+        ...
+
+    # e.g. find(attrs=3Ddict(attr=3D"value"))
+    #   -> only tags have attrs
+    #      -> tag
+    @overload
+    def find(
+        self,
+        name: None,
+        attrs: _StrainableAttributes,
+        recursive: bool =3D True,
+        string: Optional[_StrainableString] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _AtMostOneTag:
+        ...
+
+    # e.g. find(name=3D"a")) -> only tags have names -> tag
+    #
+    # The confusing and controversial case of find(name=3D"a", string=3D=
"foo")
+    # also hits this overload.
+    @overload
+    def find(
+        self,
+        name: _FindMethodName,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        recursive: bool =3D True,
+        string: Optional[_StrainableString] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _AtMostOneTag:
+        ...
+
+    # Some lesser-used cases are not covered by the overrides. Those
+    # cases will hit this method directly and return a very general
+    # type which will need to be cast after the call.
+    def find(
+        self,
+        name: _OptionalFindMethodName =3D None,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        recursive: bool =3D True,
+        string: Optional[_StrainableString] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> Union[_AtMostOneTag,_AtMostOneNavigableString,_AtMostOneElement=
]:
         """Look in the children of this PageElement and find the first
         PageElement that matches the given criteria.
=20
@@ -1993,89 +3115,184 @@ class Tag(PageElement):
         documentation for detailed explanations.
=20
         :param name: A filter on tag name.
-        :param attrs: A dictionary of filters on attribute values.
+        :param attrs: Additional filters on attribute values.
         :param recursive: If this is True, find() will perform a
-            recursive search of this PageElement's children. Otherwise,
+            recursive search of this Tag's children. Otherwise,
             only the direct children will be considered.
-        :param limit: Stop looking after finding this many results.
-        :kwargs: A dictionary of filters on attribute values.
-        :return: A PageElement.
-        :rtype: bs4.element.Tag | bs4.element.NavigableString
+        :param string: A filter on the `Tag.string` attribute.
+        :kwargs: Additional filters on attribute values.
         """
-        r =3D None
-        l =3D self.find_all(name, attrs, recursive, string, 1, _stacklev=
el=3D3,
-                          **kwargs)
-        if l:
-            r =3D l[0]
-        return r
-    findChild =3D find #BS2
+        tags =3D self._find_all(name, attrs, string, 1, self._generator_=
for_recursive(recursive), **kwargs)
+        if tags:
+            return tags[0]
+        return None
=20
-    def find_all(self, name=3DNone, attrs=3D{}, recursive=3DTrue, string=
=3DNone,
-                 limit=3DNone, **kwargs):
-        """Look in the children of this PageElement and find all
-        PageElements that match the given criteria.
+    findChild =3D _deprecated_function_alias("findChild", "find", "3.0.0=
")
+
+    # e.g. find_all(string=3D"foo")
+    #   -> string information but no tag information
+    #     -> strings
+    #
+    # Also covers unlikely cases like find_all(name=3DNone, string=3D"fo=
o")
+    #
+    # "To mark parameters as keyword-only, indicating the parameters
+    #  must be passed by keyword argument, place an * in the arguments
+    #  list just before the first keyword-only parameter."
+    #
+    #    --https://peps.python.org/pep-0570/#keyword-only-arguments
+    @overload
+    def find_all(
+        self,
+        name: None =3D None,
+        attrs: None =3D None,
+        recursive: bool =3D True,
+        *,
+        string: _StrainableString,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _SomeNavigableStrings:
+        ...
+
+    # e.g. find_all() -> default behavior -> tags
+    #      find_all(attr=3D"value") -> only tags have attrs -> tags
+    @overload
+    def find_all(
+        self,
+        name: None =3D None,
+        attrs: None =3D None,
+        recursive: bool =3D True,
+        string: None =3D None,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _SomeTags:
+        ...
+
+    # e.g. find_all(attrs=3Ddict(attr=3D"value"))
+    #   -> only tags have attrs
+    #      -> tags
+    @overload
+    def find_all(
+        self,
+        name: None,
+        attrs: _StrainableAttributes,
+        recursive: bool =3D True,
+        string: Optional[_StrainableString] =3D None,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _SomeTags:
+        ...
+
+    # e.g. find_all(name=3D"a")) -> only tags have names -> tags
+    #
+    # The confusing and controversial case of find_all(name=3D"a", strin=
g=3D"foo")
+    # also hits this overload.
+    @overload
+    def find_all(
+        self,
+        name: _FindMethodName,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        recursive: bool =3D True,
+        string: Optional[_StrainableString] =3D None,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> _SomeTags:
+        ...
+
+    # Without the clues above, we don't know whether the method will
+    # return strings or tags. However every common case will trigger one
+    # of the overloads and give us the clue we need.
+    def find_all(
+        self,
+        name: _OptionalFindMethodName =3D None,
+        attrs: Optional[_StrainableAttributes] =3D None,
+        recursive: bool =3D True,
+        string: Optional[_StrainableString] =3D None,
+        limit: Optional[int] =3D None,
+        **kwargs: _StrainableAttribute,
+    ) -> Union[_SomeTags,_SomeNavigableStrings]:
+        """Look in the children of this `PageElement` and find all
+        `PageElement` objects that match the given criteria.
=20
         All find_* methods take a common set of arguments. See the onlin=
e
         documentation for detailed explanations.
=20
         :param name: A filter on tag name.
-        :param attrs: A dictionary of filters on attribute values.
+        :param attrs: Additional filters on attribute values.
         :param recursive: If this is True, find_all() will perform a
             recursive search of this PageElement's children. Otherwise,
             only the direct children will be considered.
         :param limit: Stop looking after finding this many results.
-        :kwargs: A dictionary of filters on attribute values.
-        :return: A ResultSet of PageElements.
-        :rtype: bs4.element.ResultSet
-        """
-        generator =3D self.descendants
-        if not recursive:
-            generator =3D self.children
-        _stacklevel =3D kwargs.pop('_stacklevel', 2)
-        return self._find_all(name, attrs, string, limit, generator,
-                              _stacklevel=3D_stacklevel+1, **kwargs)
-    findAll =3D find_all       # BS3
-    findChildren =3D find_all  # BS2
-
-    #Generator methods
-    @property
-    def children(self):
-        """Iterate over all direct children of this PageElement.
-
-        :yield: A sequence of PageElements.
+        :kwargs: Additional filters on attribute values.
         """
-        # return iter() to make the purpose of the method clear
-        return iter(self.contents)  # XXX This seems to be untested.
+        generator =3D self._generator_for_recursive(recursive)
+
+        if string is not None and (name is not None or attrs is not None=
 or kwargs):
+            # TODO: Using the @overload decorator to express the three w=
ays you
+            # could get into this path is way too much code for a rarely=
(?) used
+            # feature.
+            return cast(ResultSet[Tag],
+                        self._find_all(name, attrs, string, limit, gener=
ator,
+                                       **kwargs))
+
+        if string is None:
+            # If string is None, we're searching for tags.
+            return cast(ResultSet[Tag], self._find_all(
+                name, attrs, None, limit, generator, **kwargs
+            ))
+
+        # Otherwise, we're searching for strings.
+        return cast(ResultSet[NavigableString], self._find_all(
+            None, None, string, limit, generator, **kwargs
+        ))
=20
+    findAll =3D _deprecated_function_alias("findAll", "find_all", "4.0.0=
")
+    findChildren =3D _deprecated_function_alias("findChildren", "find_al=
l", "3.0.0")
+
+    # Generator methods
     @property
-    def self_and_descendants(self):
-        """Iterate over this PageElement and its children in a
-        breadth-first sequence.
+    def children(self) -> Iterator[PageElement]:
+        """Iterate over all direct children of this `PageElement`."""
+        return (x for x in self.contents)
=20
-        :yield: A sequence of PageElements.
+    @property
+    def self_and_descendants(self) -> Iterator[PageElement]:
+        """Iterate over this `Tag` and its children in a
+        breadth-first sequence.
         """
-        if not self.hidden:
-            yield self
-        for i in self.descendants:
-            yield i
+        return self._self_and(self.descendants)
=20
     @property
-    def descendants(self):
-        """Iterate over all children of this PageElement in a
+    def descendants(self) -> Iterator[PageElement]:
+        """Iterate over all children of this `Tag` in a
         breadth-first sequence.
-
-        :yield: A sequence of PageElements.
         """
         if not len(self.contents):
             return
-        stopNode =3D self._last_descendant().next_element
-        current =3D self.contents[0]
-        while current is not stopNode:
+        # _last_descendant() can't return None here because
+        # accept_self is True. Worst case, last_descendant will end up
+        # as self.
+        last_descendant =3D cast(PageElement, self._last_descendant(acce=
pt_self=3DTrue))
+        stopNode =3D last_descendant.next_element
+        current: _AtMostOneElement =3D self.contents[0]
+        while current is not stopNode and current is not None:
+            successor =3D current.next_element
             yield current
-            current =3D current.next_element
+            current =3D successor
+
+    def _generator_for_recursive(self, recursive:bool) -> Iterator[PageE=
lement]:
+        """Helper method to process the boolean `recursive` argument
+        for find* methods.
+
+        :return: the appropriate generator
+        """
+        if recursive:
+            return self.descendants
+        return self.children
=20
     # CSS selector code
-    def select_one(self, selector, namespaces=3DNone, **kwargs):
+    def select_one(
+        self, selector: str, namespaces: Optional[Dict[str, str]] =3D No=
ne, **kwargs: Any
+    ) -> Optional[Tag]:
         """Perform a CSS selection operation on the current element.
=20
         :param selector: A CSS selector.
@@ -2087,13 +3304,16 @@ class Tag(PageElement):
=20
         :param kwargs: Keyword arguments to be passed into Soup Sieve's
            soupsieve.select() method.
-
-        :return: A Tag.
-        :rtype: bs4.element.Tag
         """
         return self.css.select_one(selector, namespaces, **kwargs)
=20
-    def select(self, selector, namespaces=3DNone, limit=3DNone, **kwargs=
):
+    def select(
+        self,
+        selector: str,
+        namespaces: Optional[Dict[str, str]] =3D None,
+        limit: int =3D 0,
+        **kwargs: Any,
+    ) -> ResultSet[Tag]:
         """Perform a CSS selection operation on the current element.
=20
         This uses the SoupSieve library.
@@ -2109,327 +3329,67 @@ class Tag(PageElement):
=20
         :param kwargs: Keyword arguments to be passed into SoupSieve's
            soupsieve.select() method.
-
-        :return: A ResultSet of Tags.
-        :rtype: bs4.element.ResultSet
         """
         return self.css.select(selector, namespaces, limit, **kwargs)
=20
     @property
-    def css(self):
+    def css(self) -> CSS:
         """Return an interface to the CSS selector API."""
         return CSS(self)
=20
     # Old names for backwards compatibility
-    def childGenerator(self):
-        """Deprecated generator."""
+    @_deprecated("children", "4.0.0")
+    def childGenerator(self) -> Iterator[PageElement]:
+        """Deprecated generator.
+
+        :meta private:
+        """
         return self.children
=20
-    def recursiveChildGenerator(self):
-        """Deprecated generator."""
+    @_deprecated("descendants", "4.0.0")
+    def recursiveChildGenerator(self) -> Iterator[PageElement]:
+        """Deprecated generator.
+
+        :meta private:
+        """
         return self.descendants
=20
-    def has_key(self, key):
+    @_deprecated("has_attr", "4.0.0")
+    def has_key(self, key: str) -> bool:
         """Deprecated method. This was kind of misleading because has_ke=
y()
         (attributes) was different from __in__ (contents).
=20
         has_key() is gone in Python 3, anyway.
-        """
-        warnings.warn(
-            'has_key is deprecated. Use has_attr(key) instead.',
-            DeprecationWarning, stacklevel=3D2
-        )
-        return self.has_attr(key)
-
-# Next, a couple classes to represent queries and their results.
-class SoupStrainer(object):
-    """Encapsulates a number of ways of matching a markup element (tag o=
r
-    string).
-
-    This is primarily used to underpin the find_* methods, but you can
-    create one yourself and pass it in as `parse_only` to the
-    `BeautifulSoup` constructor, to parse a subset of a large
-    document.
-    """
-
-    def __init__(self, name=3DNone, attrs=3D{}, string=3DNone, **kwargs)=
:
-        """Constructor.
=20
-        The SoupStrainer constructor takes the same arguments passed
-        into the find_* methods. See the online documentation for
-        detailed explanations.
-
-        :param name: A filter on tag name.
-        :param attrs: A dictionary of filters on attribute values.
-        :param string: A filter for a NavigableString with specific text.
-        :kwargs: A dictionary of filters on attribute values.
+        :meta private:
         """
-        if string is None and 'text' in kwargs:
-            string =3D kwargs.pop('text')
-            warnings.warn(
-                "The 'text' argument to the SoupStrainer constructor is =
deprecated. Use 'string' instead.",
-                DeprecationWarning, stacklevel=3D2
-            )
-
-        self.name =3D self._normalize_search_value(name)
-        if not isinstance(attrs, dict):
-            # Treat a non-dict value for attrs as a search for the 'clas=
s'
-            # attribute.
-            kwargs['class'] =3D attrs
-            attrs =3D None
-
-        if 'class_' in kwargs:
-            # Treat class_=3D"foo" as a search for the 'class'
-            # attribute, overriding any non-dict value for attrs.
-            kwargs['class'] =3D kwargs['class_']
-            del kwargs['class_']
-
-        if kwargs:
-            if attrs:
-                attrs =3D attrs.copy()
-                attrs.update(kwargs)
-            else:
-                attrs =3D kwargs
-        normalized_attrs =3D {}
-        for key, value in list(attrs.items()):
-            normalized_attrs[key] =3D self._normalize_search_value(value=
)
-
-        self.attrs =3D normalized_attrs
-        self.string =3D self._normalize_search_value(string)
-
-        # DEPRECATED but just in case someone is checking this.
-        self.text =3D self.string
-
-    def _normalize_search_value(self, value):
-        # Leave it alone if it's a Unicode string, a callable, a
-        # regular expression, a boolean, or None.
-        if (isinstance(value, str) or isinstance(value, Callable) or has=
attr(value, 'match')
-            or isinstance(value, bool) or value is None):
-            return value
-
-        # If it's a bytestring, convert it to Unicode, treating it as UT=
F-8.
-        if isinstance(value, bytes):
-            return value.decode("utf8")
-
-        # If it's listlike, convert it into a list of strings.
-        if hasattr(value, '__iter__'):
-            new_value =3D []
-            for v in value:
-                if (hasattr(v, '__iter__') and not isinstance(v, bytes)
-                    and not isinstance(v, str)):
-                    # This is almost certainly the user's mistake. In th=
e
-                    # interests of avoiding infinite loops, we'll let
-                    # it through as-is rather than doing a recursive cal=
l.
-                    new_value.append(v)
-                else:
-                    new_value.append(self._normalize_search_value(v))
-            return new_value
-
-        # Otherwise, convert it into a Unicode string.
-        # The unicode(str()) thing is so this will do the same thing on =
Python 2
-        # and Python 3.
-        return str(str(value))
-
-    def __str__(self):
-        """A human-readable representation of this SoupStrainer."""
-        if self.string:
-            return self.string
-        else:
-            return "%s|%s" % (self.name, self.attrs)
-
-    def search_tag(self, markup_name=3DNone, markup_attrs=3D{}):
-        """Check whether a Tag with the given name and attributes would
-        match this SoupStrainer.
-
-        Used prospectively to decide whether to even bother creating a T=
ag
-        object.
-
-        :param markup_name: A tag name as found in some markup.
-        :param markup_attrs: A dictionary of attributes as found in some=
 markup.
-
-        :return: True if the prospective tag would match this SoupStrain=
er;
-            False otherwise.
-        """
-        found =3D None
-        markup =3D None
-        if isinstance(markup_name, Tag):
-            markup =3D markup_name
-            markup_attrs =3D markup
-
-        if isinstance(self.name, str):
-            # Optimization for a very common case where the user is
-            # searching for a tag with one specific name, and we're
-            # looking at a tag with a different name.
-            if markup and not markup.prefix and self.name !=3D markup.na=
me:
-                 return False
-
-        call_function_with_tag_data =3D (
-            isinstance(self.name, Callable)
-            and not isinstance(markup_name, Tag))
-
-        if ((not self.name)
-            or call_function_with_tag_data
-            or (markup and self._matches(markup, self.name))
-            or (not markup and self._matches(markup_name, self.name))):
-            if call_function_with_tag_data:
-                match =3D self.name(markup_name, markup_attrs)
-            else:
-                match =3D True
-                markup_attr_map =3D None
-                for attr, match_against in list(self.attrs.items()):
-                    if not markup_attr_map:
-                        if hasattr(markup_attrs, 'get'):
-                            markup_attr_map =3D markup_attrs
-                        else:
-                            markup_attr_map =3D {}
-                            for k, v in markup_attrs:
-                                markup_attr_map[k] =3D v
-                    attr_value =3D markup_attr_map.get(attr)
-                    if not self._matches(attr_value, match_against):
-                        match =3D False
-                        break
-            if match:
-                if markup:
-                    found =3D markup
-                else:
-                    found =3D markup_name
-        if found and self.string and not self._matches(found.string, sel=
f.string):
-            found =3D None
-        return found
-
-    # For BS3 compatibility.
-    searchTag =3D search_tag
-
-    def search(self, markup):
-        """Find all items in `markup` that match this SoupStrainer.
-
-        Used by the core _find_all() method, which is ultimately
-        called by all find_* methods.
-
-        :param markup: A PageElement or a list of them.
-        """
-        # print('looking for %s in %s' % (self, markup))
-        found =3D None
-        # If given a list of items, scan it for a text element that
-        # matches.
-        if hasattr(markup, '__iter__') and not isinstance(markup, (Tag, =
str)):
-            for element in markup:
-                if isinstance(element, NavigableString) \
-                       and self.search(element):
-                    found =3D element
-                    break
-        # If it's a Tag, make sure its name or attributes match.
-        # Don't bother with Tags if we're searching for text.
-        elif isinstance(markup, Tag):
-            if not self.string or self.name or self.attrs:
-                found =3D self.search_tag(markup)
-        # If it's text, make sure the text matches.
-        elif isinstance(markup, NavigableString) or \
-                 isinstance(markup, str):
-            if not self.name and not self.attrs and self._matches(markup=
, self.string):
-                found =3D markup
-        else:
-            raise Exception(
-                "I don't know how to match against a %s" % markup.__clas=
s__)
-        return found
-
-    def _matches(self, markup, match_against, already_tried=3DNone):
-        # print(u"Matching %s against %s" % (markup, match_against))
-        result =3D False
-        if isinstance(markup, list) or isinstance(markup, tuple):
-            # This should only happen when searching a multi-valued attr=
ibute
-            # like 'class'.
-            for item in markup:
-                if self._matches(item, match_against):
-                    return True
-            # We didn't match any particular value of the multivalue
-            # attribute, but maybe we match the attribute value when
-            # considered as a string.
-            if self._matches(' '.join(markup), match_against):
-                return True
-            return False
-
-        if match_against is True:
-            # True matches any non-None value.
-            return markup is not None
-
-        if isinstance(match_against, Callable):
-            return match_against(markup)
-
-        # Custom callables take the tag as an argument, but all
-        # other ways of matching match the tag name as a string.
-        original_markup =3D markup
-        if isinstance(markup, Tag):
-            markup =3D markup.name
-
-        # Ensure that `markup` is either a Unicode string, or None.
-        markup =3D self._normalize_search_value(markup)
-
-        if markup is None:
-            # None matches None, False, an empty string, an empty list, =
and so on.
-            return not match_against
-
-        if (hasattr(match_against, '__iter__')
-            and not isinstance(match_against, str)):
-            # We're asked to match against an iterable of items.
-            # The markup must be match at least one item in the
-            # iterable. We'll try each one in turn.
-            #
-            # To avoid infinite recursion we need to keep track of
-            # items we've already seen.
-            if not already_tried:
-                already_tried =3D set()
-            for item in match_against:
-                if item.__hash__:
-                    key =3D item
-                else:
-                    key =3D id(item)
-                if key in already_tried:
-                    continue
-                else:
-                    already_tried.add(key)
-                    if self._matches(original_markup, item, already_trie=
d):
-                        return True
-            else:
-                return False
-
-        # Beyond this point we might need to run the test twice: once ag=
ainst
-        # the tag's name and once against its prefixed name.
-        match =3D False
-
-        if not match and isinstance(match_against, str):
-            # Exact string match
-            match =3D markup =3D=3D match_against
-
-        if not match and hasattr(match_against, 'search'):
-            # Regexp match
-            return match_against.search(markup)
+        return self.has_attr(key)
=20
-        if (not match
-            and isinstance(original_markup, Tag)
-            and original_markup.prefix):
-            # Try the whole thing again with the prefixed tag name.
-            return self._matches(
-                original_markup.prefix + ':' + original_markup.name, mat=
ch_against
-            )
=20
-        return match
+_PageElementT =3D TypeVar("_PageElementT", bound=3DPageElement)
=20
+class ResultSet(List[_PageElementT], Generic[_PageElementT]):
+    """A ResultSet is a list of `PageElement` objects, gathered as the r=
esult
+    of matching an :py:class:`ElementFilter` against a parse tree. Basic=
ally, a list of
+    search results.
+    """
=20
-class ResultSet(list):
-    """A ResultSet is just a list that keeps track of the SoupStrainer
-    that created it."""
-    def __init__(self, source, result=3D()):
-        """Constructor.
+    source: Optional[ElementFilter]
=20
-        :param source: A SoupStrainer.
-        :param result: A list of PageElements.
-        """
+    def __init__(
+        self, source: Optional[ElementFilter], result: Iterable[_PageEle=
mentT] =3D ()
+    ) -> None:
         super(ResultSet, self).__init__(result)
         self.source =3D source
=20
-    def __getattr__(self, key):
+    def __getattr__(self, key: str) -> None:
         """Raise a helpful exception to explain a common code fix."""
         raise AttributeError(
-            "ResultSet object has no attribute '%s'. You're probably tre=
ating a list of elements like a single element. Did you call find_all() w=
hen you meant to call find()?" % key
+            f"""ResultSet object has no attribute "{key}". You're probab=
ly treating a list of elements like a single element. Did you call find_a=
ll() when you meant to call find()?"""
         )
+
+# Now that all the classes used by SoupStrainer have been defined,
+# import SoupStrainer itself into this module to preserve the
+# backwards compatibility of anyone who imports
+# bs4.element.SoupStrainer.
+from bb._vendor.bs4.filter import SoupStrainer # noqa: E402
diff --git a/lib/bb/_vendor/bs4/exceptions.py b/lib/bb/_vendor/bs4/except=
ions.py
new file mode 100644
index 000000000..1d1a8fb29
--- /dev/null
+++ b/lib/bb/_vendor/bs4/exceptions.py
@@ -0,0 +1,28 @@
+"""Exceptions defined by Beautiful Soup itself."""
+
+from typing import Union
+
+
+class StopParsing(Exception):
+    """Exception raised by a TreeBuilder if it's unable to continue pars=
ing."""
+
+
+class FeatureNotFound(ValueError):
+    """Exception raised by the BeautifulSoup constructor if no parser wi=
th the
+    requested features is found.
+    """
+
+
+class ParserRejectedMarkup(Exception):
+    """An Exception to be raised when the underlying parser simply
+    refuses to parse the given markup.
+    """
+
+    def __init__(self, message_or_exception: Union[str, Exception]):
+        """Explain why the parser rejected the given markup, either
+        with a textual explanation or another exception.
+        """
+        if isinstance(message_or_exception, Exception):
+            e =3D message_or_exception
+            message_or_exception =3D "%s: %s" % (e.__class__.__name__, s=
tr(e))
+        super(ParserRejectedMarkup, self).__init__(message_or_exception)
diff --git a/lib/bb/_vendor/bs4/filter.py b/lib/bb/_vendor/bs4/filter.py
new file mode 100644
index 000000000..1d467818e
--- /dev/null
+++ b/lib/bb/_vendor/bs4/filter.py
@@ -0,0 +1,764 @@
+from __future__ import annotations
+from collections import defaultdict
+import re
+from typing import (
+    Any,
+    Callable,
+    cast,
+    Dict,
+    Iterator,
+    Iterable,
+    List,
+    Optional,
+    Sequence,
+    Type,
+    Union,
+)
+import warnings
+
+from bb._vendor.bs4._deprecation import _deprecated
+from bb._vendor.bs4.element import (
+    AttributeDict,
+    NavigableString,
+    PageElement,
+    ResultSet,
+    Tag,
+)
+from bb._vendor.bs4._typing import (
+    _AtMostOneElement,
+    _AttributeValue,
+    _NullableStringMatchFunction,
+    _OneElement,
+    _PageElementMatchFunction,
+    _QueryResults,
+    _RawAttributeValues,
+    _RegularExpressionProtocol,
+    _StrainableAttribute,
+    _StrainableElement,
+    _StrainableString,
+    _StringMatchFunction,
+    _TagMatchFunction,
+)
+
+
+class ElementFilter(object):
+    """`ElementFilter` encapsulates the logic necessary to decide:
+
+    1. whether a `PageElement` (a `Tag` or a `NavigableString`) matches =
a
+    user-specified query.
+
+    2. whether a given sequence of markup found during initial parsing
+    should be turned into a `PageElement` at all, or simply discarded.
+
+    The base class is the simplest `ElementFilter`. By default, it
+    matches everything and allows all markup to become `PageElement`
+    objects. You can make it more selective by passing in a
+    user-defined match function, or defining a subclass.
+
+    Most users of Beautiful Soup will never need to use
+    `ElementFilter`, or its more capable subclass
+    `SoupStrainer`. Instead, they will use methods like
+    :py:meth:`Tag.find`, which will convert their arguments into
+    `SoupStrainer` objects and run them against the tree.
+
+    However, if you find yourself wanting to treat the arguments to
+    Beautiful Soup's find_*() methods as first-class objects, those
+    objects will be `SoupStrainer` objects. You can create them
+    yourself and then make use of functions like
+    `ElementFilter.filter()`.
+    """
+
+    match_function: Optional[_PageElementMatchFunction]
+
+    def __init__(self, match_function: Optional[_PageElementMatchFunctio=
n] =3D None):
+        """Pass in a match function to easily customize the behavior of
+        `ElementFilter.match` without needing to subclass.
+
+        :param match_function: A function that takes a `PageElement`
+          and returns `True` if that `PageElement` matches some criteria.
+        """
+        self.match_function =3D match_function
+
+    @property
+    def includes_everything(self) -> bool:
+        """Does this `ElementFilter` obviously include everything? If so=
,
+        the filter process can be made much faster.
+
+        The `ElementFilter` might turn out to include everything even
+        if this returns `False`, but it won't include everything in an
+        obvious way.
+
+        The base `ElementFilter` implementation includes things based on
+        the match function, so includes_everything is only true if
+        there is no match function.
+        """
+        return not self.match_function
+
+    @property
+    def excludes_everything(self) -> bool:
+        """Does this `ElementFilter` obviously exclude everything? If
+        so, Beautiful Soup will issue a warning if you try to use it
+        when parsing a document.
+
+        The `ElementFilter` might turn out to exclude everything even
+        if this returns `False`, but it won't exclude everything in an
+        obvious way.
+
+        The base `ElementFilter` implementation excludes things based
+        on a match function we can't inspect, so excludes_everything
+        is always false.
+        """
+        return False
+
+    def match(self, element: PageElement, _known_rules:bool=3DFalse) -> =
bool:
+        """Does the given PageElement match the rules set down by this
+        ElementFilter?
+
+        The base implementation delegates to the function passed in to
+        the constructor.
+
+        :param _known_rules: Defined for compatibility with
+            SoupStrainer._match(). Used more for consistency than becaus=
e
+            we need the performance optimization.
+        """
+        if not _known_rules and self.includes_everything:
+            return True
+        if not self.match_function:
+            return True
+        return self.match_function(element)
+
+    def filter(self, generator: Iterator[PageElement]) -> Iterator[_OneE=
lement]:
+        """The most generic search method offered by Beautiful Soup.
+
+        Acts like Python's built-in `filter`, using
+        `ElementFilter.match` as the filtering function.
+        """
+        # If there are no rules at all, don't bother filtering. Let
+        # anything through.
+        if self.includes_everything:
+            yield from generator
+        while True:
+            try:
+                i =3D next(generator)
+            except StopIteration:
+                break
+            if i:
+                if self.match(i, _known_rules=3DTrue):
+                    yield i
+
+    def find(self, generator: Iterator[PageElement]) -> _AtMostOneElemen=
t:
+        """A lower-level equivalent of :py:meth:`Tag.find`.
+
+        You can pass in your own generator for iterating over
+        `PageElement` objects. The first one that matches this
+        `ElementFilter` will be returned.
+
+        :param generator: A way of iterating over `PageElement`
+            objects.
+        """
+        for match in self.filter(generator):
+            return match
+        return None
+
+    def find_all(
+        self, generator: Iterator[PageElement], limit: Optional[int] =3D=
 None
+    ) -> _QueryResults:
+        """A lower-level equivalent of :py:meth:`Tag.find_all`.
+
+        You can pass in your own generator for iterating over
+        `PageElement` objects. Only elements that match this
+        `ElementFilter` will be returned in the :py:class:`ResultSet`.
+
+        :param generator: A way of iterating over `PageElement`
+            objects.
+
+        :param limit: Stop looking after finding this many results.
+        """
+        results =3D []
+        for match in self.filter(generator):
+            results.append(match)
+            if limit is not None and len(results) >=3D limit:
+                break
+        return ResultSet(self, results)
+
+    def allow_tag_creation(
+        self, nsprefix: Optional[str], name: str, attrs: Optional[_RawAt=
tributeValues]
+    ) -> bool:
+        """Based on the name and attributes of a tag, see whether this
+        `ElementFilter` will allow a `Tag` object to even be created.
+
+        By default, all tags are parsed. To change this, subclass
+        `ElementFilter`.
+
+        :param name: The name of the prospective tag.
+        :param attrs: The attributes of the prospective tag.
+        """
+        return True
+
+    def allow_string_creation(self, string: str) -> bool:
+        """Based on the content of a string, see whether this
+        `ElementFilter` will allow a `NavigableString` object based on
+        this string to be added to the parse tree.
+
+        By default, all strings are processed into `NavigableString`
+        objects. To change this, subclass `ElementFilter`.
+
+        :param str: The string under consideration.
+        """
+        return True
+
+
+class MatchRule(object):
+    """Each MatchRule encapsulates the logic behind a single argument
+    passed in to one of the Beautiful Soup find* methods.
+    """
+
+    string: Optional[str]
+    pattern: Optional[_RegularExpressionProtocol]
+    present: Optional[bool]
+    exclude_everything: Optional[bool]
+    # TODO-TYPING: All MatchRule objects also have an attribute
+    # ``function``, but the type of the function depends on the
+    # subclass.
+
+    def __init__(
+        self,
+        string: Optional[Union[str, bytes]] =3D None,
+        pattern: Optional[_RegularExpressionProtocol] =3D None,
+        function: Optional[Callable] =3D None,
+        present: Optional[bool] =3D None,
+        exclude_everything: Optional[bool] =3D None
+    ):
+        if isinstance(string, bytes):
+            string =3D string.decode("utf8")
+        self.string =3D string
+        if isinstance(pattern, bytes):
+            self.pattern =3D re.compile(pattern.decode("utf8"))
+        elif isinstance(pattern, str):
+            self.pattern =3D re.compile(pattern)
+        else:
+            self.pattern =3D pattern
+        self.function =3D function
+        self.present =3D present
+        self.exclude_everything =3D exclude_everything
+
+        values =3D [
+            x
+            for x in (self.string, self.pattern, self.function, self.pre=
sent, self.exclude_everything)
+            if x is not None
+        ]
+        if len(values) =3D=3D 0:
+            raise ValueError(
+                "Either string, pattern, function, present, or exclude_e=
verything must be provided."
+            )
+        if len(values) > 1:
+            raise ValueError(
+                "At most one of string, pattern, function, present, and =
exclude_everything must be provided."
+            )
+
+    def _base_match(self, string: Optional[str]) -> Optional[bool]:
+        """Run the 'cheap' portion of a match, trying to get an answer w=
ithout
+        calling a potentially expensive custom function.
+
+        :return: True or False if we have a (positive or negative)
+        match; None if we need to keep trying.
+        """
+        # self.exclude_everything matches nothing.
+        if self.exclude_everything:
+            return False
+
+        # self.present=3D=3DTrue matches everything except None.
+        if self.present is True:
+            return string is not None
+
+        # self.present=3D=3DFalse matches _only_ None.
+        if self.present is False:
+            return string is None
+
+        # self.string does an exact string match.
+        if self.string is not None:
+            # print(f"{self.string} ?=3D {string}")
+            return self.string =3D=3D string
+
+        # self.pattern does a regular expression search.
+        if self.pattern is not None:
+            # print(f"{self.pattern} ?~ {string}")
+            if string is None:
+                return False
+            return self.pattern.search(string) is not None
+
+        return None
+
+    def matches_string(self, string: Optional[str]) -> bool:
+        _base_result =3D self._base_match(string)
+        if _base_result is not None:
+            # No need to invoke the test function.
+            return _base_result
+        if self.function is not None and not self.function(string):
+            # print(f"{self.function}({string}) =3D=3D False")
+            return False
+        return True
+
+    def __repr__(self) -> str:
+        cls =3D type(self).__name__
+        return f"<{cls} string=3D{self.string} pattern=3D{self.pattern} =
function=3D{self.function} present=3D{self.present}>"
+
+    def __eq__(self, other: Any) -> bool:
+        return (
+            isinstance(other, MatchRule)
+            and self.string =3D=3D other.string
+            and self.pattern =3D=3D other.pattern
+            and self.function =3D=3D other.function
+            and self.present =3D=3D other.present
+        )
+
+
+class TagNameMatchRule(MatchRule):
+    """A MatchRule implementing the rules for matches against tag name."=
""
+
+    function: Optional[_TagMatchFunction]
+
+    def matches_tag(self, tag: Tag) -> bool:
+        base_value =3D self._base_match(tag.name)
+        if base_value is not None:
+            return base_value
+
+        # The only remaining possibility is that the match is determined
+        # by a function call. Call the function.
+        function =3D cast(_TagMatchFunction, self.function)
+        if function(tag):
+            return True
+        return False
+
+
+class AttributeValueMatchRule(MatchRule):
+    """A MatchRule implementing the rules for matches against attribute =
value."""
+
+    function: Optional[_NullableStringMatchFunction]
+
+
+class StringMatchRule(MatchRule):
+    """A MatchRule implementing the rules for matches against a Navigabl=
eString."""
+
+    function: Optional[_StringMatchFunction]
+
+
+class SoupStrainer(ElementFilter):
+    """The `ElementFilter` subclass used internally by Beautiful Soup.
+
+    A `SoupStrainer` encapsulates the logic necessary to perform the
+    kind of matches supported by methods such as
+    :py:meth:`Tag.find`. `SoupStrainer` objects are primarily created
+    internally, but you can create one yourself and pass it in as
+    ``parse_only`` to the `BeautifulSoup` constructor, to parse a
+    subset of a large document.
+
+    Internally, `SoupStrainer` objects work by converting the
+    constructor arguments into `MatchRule` objects. Incoming
+    tags/markup are matched against those rules.
+
+    :param name: One or more restrictions on the tags found in a documen=
t.
+
+    :param attrs: A dictionary that maps attribute names to
+      restrictions on tags that use those attributes.
+
+    :param string: One or more restrictions on the strings found in a
+      document.
+
+    :param kwargs: A dictionary that maps attribute names to restriction=
s
+      on tags that use those attributes. These restrictions are additive=
 to
+      any specified in ``attrs``.
+
+    """
+
+    name_rules: List[TagNameMatchRule]
+    attribute_rules: Dict[str, List[AttributeValueMatchRule]]
+    string_rules: List[StringMatchRule]
+
+    def __init__(
+        self,
+        name: Optional[_StrainableElement] =3D None,
+        attrs: Optional[Dict[str, _StrainableAttribute]] =3D None,
+        string: Optional[_StrainableString] =3D None,
+        **kwargs: _StrainableAttribute,
+    ):
+        if string is None and "text" in kwargs:
+            string =3D cast(Optional[_StrainableString], kwargs.pop("tex=
t"))
+            warnings.warn(
+                "As of version 4.11.0, the 'text' argument to the SoupSt=
rainer constructor is deprecated. Use 'string' instead.",
+                DeprecationWarning,
+                stacklevel=3D2,
+            )
+
+        if name is None and not attrs and not string and not kwargs:
+            # Special case for backwards compatibility. Instantiating
+            # a SoupStrainer with no arguments whatsoever gets you one
+            # that matches all Tags, and only Tags.
+            self.name_rules =3D [TagNameMatchRule(present=3DTrue)]
+        else:
+            self.name_rules =3D cast(
+                List[TagNameMatchRule], list(self._make_match_rules(name=
, TagNameMatchRule))
+            )
+        self.attribute_rules =3D defaultdict(list)
+
+        if attrs is None:
+            attrs =3D {}
+        if not isinstance(attrs, dict):
+            # Passing something other than a dictionary as attrs is
+            # sugar for matching that thing against the 'class'
+            # attribute.
+            attrs =3D {"class": attrs}
+
+        for attrdict in attrs, kwargs:
+            for attr, value in attrdict.items():
+                if attr =3D=3D "class_" and attrdict is kwargs:
+                    # If you pass in 'class_' as part of kwargs, it's
+                    # because class is a Python reserved word. If you
+                    # pass it in as part of the attrs dict, it's
+                    # because you really are looking for an attribute
+                    # called 'class_'.
+                    attr =3D "class"
+
+                if value is None:
+                    value =3D False
+                for rule_obj in self._make_match_rules(value, AttributeV=
alueMatchRule):
+                    self.attribute_rules[attr].append(
+                        cast(AttributeValueMatchRule, rule_obj)
+                    )
+
+        self.string_rules =3D cast(
+            List[StringMatchRule], list(self._make_match_rules(string, S=
tringMatchRule))
+        )
+
+        #: DEPRECATED 4.13.0: You shouldn't need to check this under
+        #: any name (.string or .text), and if you do, you're probably
+        #: not taking into account all of the types of values this
+        #: variable might have. Look at the .string_rules list instead.
+        self.__string =3D string
+
+    @property
+    def includes_everything(self) -> bool:
+        """Check whether the provided rules will obviously include
+        everything. (They might include everything even if this returns =
`False`,
+        but not in an obvious way.)
+        """
+        return not self.name_rules and not self.string_rules and not sel=
f.attribute_rules
+
+    @property
+    def excludes_everything(self) -> bool:
+        """Check whether the provided rules will obviously exclude
+        everything. (They might exclude everything even if this returns =
`False`,
+        but not in an obvious way.)
+        """
+        if (self.string_rules and (self.name_rules or self.attribute_rul=
es)):
+            # This is self-contradictory, so the rules exclude everythin=
g.
+            return True
+
+        # If there's a rule that ended up treated as an "exclude everyth=
ing"
+        # rule due to creating a logical inconsistency, then the rules
+        # exclude everything.
+        if any(x.exclude_everything for x in self.string_rules):
+            return True
+        if any(x.exclude_everything for x in self.name_rules):
+            return True
+        for ruleset in self.attribute_rules.values():
+            if any(x.exclude_everything for x in ruleset):
+                return True
+        return False
+
+    @property
+    def string(self) -> Optional[_StrainableString]:
+        ":meta private:"
+        warnings.warn(
+            "Access to deprecated property string. (Look at .string_rule=
s instead) -- Deprecated since version 4.13.0.",
+            DeprecationWarning,
+            stacklevel=3D2,
+        )
+        return self.__string
+
+    @property
+    def text(self) -> Optional[_StrainableString]:
+        ":meta private:"
+        warnings.warn(
+            "Access to deprecated property text. (Look at .string_rules =
instead) -- Deprecated since version 4.13.0.",
+            DeprecationWarning,
+            stacklevel=3D2,
+        )
+        return self.__string
+
+    def __repr__(self) -> str:
+        return f"<{self.__class__.__name__} name=3D{self.name_rules} att=
rs=3D{self.attribute_rules} string=3D{self.string_rules}>"
+
+    @classmethod
+    def _make_match_rules(
+        cls,
+        obj: Optional[Union[_StrainableElement, _StrainableAttribute]],
+        rule_class: Type[MatchRule],
+    ) -> Iterator[MatchRule]:
+        """Convert a vaguely-specific 'object' into one or more well-def=
ined
+        `MatchRule` objects.
+
+        :param obj: Some kind of object that corresponds to one or more
+           matching rules.
+        :param rule_class: Create instances of this `MatchRule` subclass.
+        """
+        if obj is None:
+            return
+        if isinstance(obj, (str, bytes)):
+            yield rule_class(string=3Dobj)
+        elif isinstance(obj, bool):
+            yield rule_class(present=3Dobj)
+        elif callable(obj):
+            yield rule_class(function=3Dobj)
+        elif isinstance(obj, _RegularExpressionProtocol):
+            yield rule_class(pattern=3Dobj)
+        elif hasattr(obj, "__iter__"):
+            if not obj:
+                # The attribute is being matched against the null set,
+                # which means it should exclude everything.
+                yield rule_class(exclude_everything=3DTrue)
+            for o in obj:
+                if not isinstance(o, (bytes, str)) and hasattr(o, "__ite=
r__"):
+                    # This is almost certainly the user's
+                    # mistake. This list contains another list, which
+                    # opens up the possibility of infinite
+                    # self-reference. In the interests of avoiding
+                    # infinite recursion, we'll treat this as an
+                    # impossible match and issue a rule that excludes
+                    # everything, rather than looking inside.
+                    warnings.warn(
+                        f"Ignoring nested list {o} to avoid the possibil=
ity of infinite recursion.",
+                        stacklevel=3D5,
+                    )
+                    yield rule_class(exclude_everything=3DTrue)
+                    continue
+                for x in cls._make_match_rules(o, rule_class):
+                    yield x
+        else:
+            yield rule_class(string=3Dstr(obj))
+
+    def matches_tag(self, tag: Tag) -> bool:
+        """Do the rules of this `SoupStrainer` trigger a match against t=
he
+        given `Tag`?
+
+        If the `SoupStrainer` has any `TagNameMatchRule`, at least one
+        must match the `Tag` or its `Tag.name`.
+
+        If there are any `AttributeValueMatchRule` for a given
+        attribute, at least one of them must match the attribute
+        value.
+
+        If there are any `StringMatchRule`, at least one must match,
+        but a `SoupStrainer` that *only* contains `StringMatchRule`
+        cannot match a `Tag`, only a `NavigableString`.
+        """
+        # If there are no rules at all, let anything through.
+        #if self.includes_everything:
+        #    return True
+
+        # String rules cannot not match a Tag on their own.
+        if not self.name_rules and not self.attribute_rules:
+            return False
+
+        # Optimization for a very common case where the user is
+        # searching for a tag with one specific name, and we're
+        # looking at a tag with a different name.
+        if (
+            not tag.prefix
+            and len(self.name_rules) =3D=3D 1
+            and self.name_rules[0].string is not None
+            and tag.name !=3D self.name_rules[0].string
+        ):
+            return False
+
+        # If there are name rules, at least one must match. It can
+        # match either the Tag object itself or the prefixed name of
+        # the tag.
+        prefixed_name =3D None
+        if tag.prefix:
+            prefixed_name =3D f"{tag.prefix}:{tag.name}"
+        if self.name_rules:
+            name_matches =3D False
+            for rule in self.name_rules:
+                # attrs =3D " ".join(
+                #     [f"{k}=3D{v}" for k, v in sorted(tag.attrs.items()=
)]
+                # )
+                # print(f"Testing <{tag.name} {attrs}>{tag.string}</{tag=
.name}> against {rule}")
+
+                # If the rule contains a function, the function will be =
called
+                # with `tag`. It will not be called a second time with
+                # `prefixed_name`.
+                if rule.matches_tag(tag) or (
+                        not rule.function and prefixed_name is not None =
and rule.matches_string(prefixed_name)
+                ):
+                    name_matches =3D True
+                    break
+
+            if not name_matches:
+                return False
+
+        # If there are attribute rules for a given attribute, at least
+        # one of them must match. If there are rules for multiple
+        # attributes, each attribute must have at least one match.
+        for attr, rules in self.attribute_rules.items():
+            attr_value =3D tag.get(attr, None)
+            this_attr_match =3D self._attribute_match(attr_value, rules)
+            if not this_attr_match:
+                return False
+
+        # If there are string rules, at least one must match.
+        if self.string_rules:
+            _str =3D tag.string
+            if _str is None:
+                return False
+            if not self.matches_any_string_rule(_str):
+                return False
+        return True
+
+    def _attribute_match(
+        self,
+        attr_value: Optional[_AttributeValue],
+        rules: Iterable[AttributeValueMatchRule],
+    ) -> bool:
+        attr_values: Sequence[Optional[str]]
+        if isinstance(attr_value, list):
+            attr_values =3D attr_value
+        else:
+            attr_values =3D [cast(str, attr_value)]
+
+        def _match_attribute_value_helper(attr_values: Sequence[Optional=
[str]]) -> bool:
+            for rule in rules:
+                for attr_value in attr_values:
+                    if rule.matches_string(attr_value):
+                        return True
+            return False
+
+        this_attr_match =3D _match_attribute_value_helper(attr_values)
+        if not this_attr_match and len(attr_values) !=3D 1:
+            # Try again but treat the attribute value as a single
+            # string instead of a list. The result can only be
+            # different if the list of values contains more or less
+            # than one item.
+
+            # This cast converts Optional[str] to plain str.
+            #
+            # We know there can't be any None in the list. Beautiful
+            # Soup never uses None as a value of a multi-valued
+            # attribute, and if None is passed in as attr_value, it's
+            # turned into a list with 1 element, which was excluded by
+            # the if statement above.
+            attr_values =3D cast(Sequence[str], attr_values)
+
+            joined_attr_value =3D " ".join(attr_values)
+            this_attr_match =3D _match_attribute_value_helper([joined_at=
tr_value])
+        return this_attr_match
+
+    def allow_tag_creation(
+        self, nsprefix: Optional[str], name: str, attrs: Optional[_RawAt=
tributeValues]
+    ) -> bool:
+        """Based on the name and attributes of a tag, see whether this
+        `SoupStrainer` will allow a `Tag` object to even be created.
+
+        :param name: The name of the prospective tag.
+        :param attrs: The attributes of the prospective tag.
+        """
+        if self.string_rules:
+            # A SoupStrainer that has string rules can't be used to
+            # manage tag creation, because the string rule can't be
+            # evaluated until after the tag and all of its contents
+            # have been parsed.
+            return False
+        prefixed_name =3D None
+        if nsprefix:
+            prefixed_name =3D f"{nsprefix}:{name}"
+        if self.name_rules:
+            # At least one name rule must match.
+            name_match =3D False
+            for rule in self.name_rules:
+                for x in name, prefixed_name:
+                    if x is not None:
+                        if rule.matches_string(x):
+                            name_match =3D True
+                            break
+            if not name_match:
+                return False
+
+        # For each attribute that has rules, at least one rule must
+        # match.
+        if attrs is None:
+            attrs =3D AttributeDict()
+        for attr, rules in self.attribute_rules.items():
+            attr_value =3D attrs.get(attr)
+            if not self._attribute_match(attr_value, rules):
+                return False
+
+        return True
+
+    def allow_string_creation(self, string: str) -> bool:
+        """Based on the content of a markup string, see whether this
+        `SoupStrainer` will allow it to be instantiated as a
+        `NavigableString` object, or whether it should be ignored.
+        """
+        if self.name_rules or self.attribute_rules:
+            # A SoupStrainer that has name or attribute rules won't
+            # match any strings; it's designed to match tags with
+            # certain properties.
+            return False
+        if not self.string_rules:
+            # A SoupStrainer with no string rules will match
+            # all strings.
+            return True
+        if not self.matches_any_string_rule(string):
+            return False
+        return True
+
+    def matches_any_string_rule(self, string: str) -> bool:
+        """See whether the content of a string matches any of
+        this `SoupStrainer`'s string rules.
+        """
+        if not self.string_rules:
+            return True
+        for string_rule in self.string_rules:
+            if string_rule.matches_string(string):
+                return True
+        return False
+
+    def match(self, element: PageElement, _known_rules: bool=3DFalse) ->=
 bool:
+        """Does the given `PageElement` match the rules set down by this
+        `SoupStrainer`?
+
+        The find_* methods rely heavily on this method to find matches.
+
+        :param element: A `PageElement`.
+        :param _known_rules: Set to true in the common case where
+           we already checked and found at least one rule in this SoupSt=
rainer
+           that might exclude a PageElement. Without this, we need
+           to check .includes_everything every time, just to be safe.
+        :return: `True` if the element matches this `SoupStrainer`'s rul=
es; `False` otherwise.
+        """
+        # If there are no rules at all, let anything through.
+        if not _known_rules and self.includes_everything:
+            return True
+        if isinstance(element, Tag):
+            return self.matches_tag(element)
+        assert isinstance(element, NavigableString)
+        if not (self.name_rules or self.attribute_rules):
+            # A NavigableString can only match a SoupStrainer that
+            # does not define any name or attribute rules.
+            # Then it comes down to the string rules.
+            return self.matches_any_string_rule(element)
+        return False
+
+    @_deprecated("allow_tag_creation", "4.13.0")
+    def search_tag(self, name: str, attrs: Optional[_RawAttributeValues]=
) -> bool:
+        """A less elegant version of `allow_tag_creation`. Deprecated as=
 of 4.13.0"""
+        ":meta private:"
+        return self.allow_tag_creation(None, name, attrs)
+
+    @_deprecated("match", "4.13.0")
+    def search(self, element: PageElement) -> Optional[PageElement]:
+        """A less elegant version of match(). Deprecated as of 4.13.0.
+
+        :meta private:
+        """
+        return element if self.match(element) else None
diff --git a/lib/bb/_vendor/bs4/formatter.py b/lib/bb/_vendor/bs4/formatt=
er.py
index 50f775aee..ef69d992f 100644
--- a/lib/bb/_vendor/bs4/formatter.py
+++ b/lib/bb/_vendor/bs4/formatter.py
@@ -1,4 +1,11 @@
-from .dammit import EntitySubstitution
+from __future__ import annotations
+from typing import Callable, Dict, Iterable, Optional, Set, Tuple, TYPE_=
CHECKING, Union
+from typing_extensions import TypeAlias
+from bb._vendor.bs4.dammit import EntitySubstitution
+
+if TYPE_CHECKING:
+    from bb._vendor.bs4._typing import _AttributeValue
+
=20
 class Formatter(EntitySubstitution):
     """Describes a strategy to use when outputting a parse tree to a str=
ing.
@@ -7,15 +14,17 @@ class Formatter(EntitySubstitution):
     HTML4, HTML5, and XML. Others are configurable by the user.
=20
     Formatters are passed in as the `formatter` argument to methods
-    like `PageElement.encode`. Most people won't need to think about
-    formatters, and most people who need to think about them can pass
-    in one of these predefined strings as `formatter` rather than
-    making a new Formatter object:
+    like `bs4.element.Tag.encode`. Most people won't need to
+    think about formatters, and most people who need to think about
+    them can pass in one of these predefined strings as `formatter`
+    rather than making a new Formatter object:
=20
     For HTML documents:
      * 'html' - HTML entity substitution for generic HTML documents. (de=
fault)
      * 'html5' - HTML entity substitution for HTML5 documents, as
                  well as some optimizations in the way tags are rendered.
+     * 'html5-4.12.0' - The version of the 'html5' formatter used prior =
to
+                        Beautiful Soup 4.13.0.
      * 'minimal' - Only make the substitutions necessary to guarantee
                    valid HTML.
      * None - Do not perform any substitution. This will be faster
@@ -27,49 +36,75 @@ class Formatter(EntitySubstitution):
                    valid XML. (default)
      * None - Do not perform any substitution. This will be faster
               but may result in invalid markup.
+
     """
-    # Registries of XML and HTML formatters.
-    XML_FORMATTERS =3D {}
-    HTML_FORMATTERS =3D {}
=20
-    HTML =3D 'html'
-    XML =3D 'xml'
+    #: Constant name denoting HTML markup
+    HTML: str =3D "html"
=20
-    HTML_DEFAULTS =3D dict(
+    #: Constant name denoting XML markup
+    XML: str =3D "xml"
+
+    #: Default values for the various constructor options when the
+    #: markup language is HTML.
+    HTML_DEFAULTS: Dict[str, Set[str]] =3D dict(
         cdata_containing_tags=3Dset(["script", "style"]),
     )
=20
-    def _default(self, language, value, kwarg):
+    language: Optional[str]  #: :meta private:
+    entity_substitution: Optional[_EntitySubstitutionFunction]  #: :meta=
 private:
+    void_element_close_prefix: str  #: :meta private:
+    cdata_containing_tags: Set[str]  #: :meta private:
+    indent: str  #: :meta private:
+
+    #: If this is set to true by the constructor, then attributes whose
+    #: values are sent to the empty string will be treated as HTML
+    #: boolean attributes. (Attributes whose value is None are always
+    #: rendered this way.)
+    empty_attributes_are_booleans: bool
+
+    def _default(
+        self, language: str, value: Optional[Set[str]], kwarg: str
+    ) -> Set[str]:
         if value is not None:
             return value
         if language =3D=3D self.XML:
+            # When XML is the markup language in use, all of the
+            # defaults are the empty list.
             return set()
+
+        # Otherwise, it depends on what's in HTML_DEFAULTS.
         return self.HTML_DEFAULTS[kwarg]
=20
     def __init__(
-            self, language=3DNone, entity_substitution=3DNone,
-            void_element_close_prefix=3D'/', cdata_containing_tags=3DNon=
e,
-            empty_attributes_are_booleans=3DFalse, indent=3D1,
+        self,
+        language: Optional[str] =3D None,
+        entity_substitution: Optional[_EntitySubstitutionFunction] =3D N=
one,
+        void_element_close_prefix: str =3D "/",
+        cdata_containing_tags: Optional[Set[str]] =3D None,
+        empty_attributes_are_booleans: bool =3D False,
+        indent: Union[int,str] =3D 1,
     ):
         r"""Constructor.
=20
-        :param language: This should be Formatter.XML if you are formatt=
ing
-           XML markup and Formatter.HTML if you are formatting HTML mark=
up.
+        :param language: This should be `Formatter.XML` if you are forma=
tting
+           XML markup and `Formatter.HTML` if you are formatting HTML ma=
rkup.
=20
         :param entity_substitution: A function to call to replace specia=
l
-           characters with XML/HTML entities. For examples, see=20
+           characters with XML/HTML entities. For examples, see
            bs4.dammit.EntitySubstitution.substitute_html and substitute_=
xml.
         :param void_element_close_prefix: By default, void elements
            are represented as <tag/> (XML rules) rather than <tag>
            (HTML rules). To get <tag>, pass in the empty string.
-        :param cdata_containing_tags: The list of tags that are defined
+        :param cdata_containing_tags: The set of tags that are defined
            as containing CDATA in this dialect. For example, in HTML,
            <script> and <style> tags are defined as containing CDATA,
            and their contents should not be formatted.
-        :param blank_attributes_are_booleans: Render attributes whose va=
lue
-            is the empty string as HTML-style boolean attributes.
-            (Attributes whose value is None are always rendered this way=
.)
-
+        :param empty_attributes_are_booleans: If this is set to true,
+          then attributes whose values are sent to the empty string
+          will be treated as `HTML boolean
+          attributes<https://dev.w3.org/html5/spec-LC/common-microsyntax=
es.html#boolean-attributes>`_. (Attributes
+          whose value is None are always rendered this way.)
         :param indent: If indent is a non-negative integer or string,
             then the contents of elements will be indented
             appropriately when pretty-printing. An indent level of 0,
@@ -78,47 +113,52 @@ class Formatter(EntitySubstitution):
             level. If indent is a string (such as "\t"), that string
             is used to indent each level. The default behavior is to
             indent one space per level.
+
         """
-        self.language =3D language
+        self.language =3D language or self.HTML
         self.entity_substitution =3D entity_substitution
         self.void_element_close_prefix =3D void_element_close_prefix
         self.cdata_containing_tags =3D self._default(
-            language, cdata_containing_tags, 'cdata_containing_tags'
+            self.language, cdata_containing_tags, "cdata_containing_tags=
"
         )
-        self.empty_attributes_are_booleans=3Dempty_attributes_are_boolea=
ns
+        self.empty_attributes_are_booleans =3D empty_attributes_are_bool=
eans
         if indent is None:
             indent =3D 0
+        indent_str: str
         if isinstance(indent, int):
             if indent < 0:
                 indent =3D 0
-            indent =3D ' ' * indent
+            indent_str =3D " " * indent
         elif isinstance(indent, str):
-            indent =3D indent
+            indent_str =3D indent
         else:
-            indent =3D ' '
-        self.indent =3D indent
+            indent_str =3D " "
+        self.indent =3D indent_str
=20
-    def substitute(self, ns):
+    def substitute(self, ns: str) -> str:
         """Process a string that needs to undergo entity substitution.
         This may be a string encountered in an attribute value or as
         text.
=20
         :param ns: A string.
-        :return: A string with certain characters replaced by named
+        :return: The same string but with certain characters replaced by=
 named
            or numeric entities.
         """
         if not self.entity_substitution:
             return ns
         from .element import NavigableString
-        if (isinstance(ns, NavigableString)
+
+        if (
+            isinstance(ns, NavigableString)
             and ns.parent is not None
-            and ns.parent.name in self.cdata_containing_tags):
+            and ns.parent.name in self.cdata_containing_tags
+        ):
             # Do nothing.
             return ns
         # Substitute.
         return self.entity_substitution(ns)
=20
-    def attribute_value(self, value):
+    def attribute_value(self, value: str) -> str:
         """Process the value of an attribute.
=20
         :param ns: A string.
@@ -126,60 +166,111 @@ class Formatter(EntitySubstitution):
            or numeric entities.
         """
         return self.substitute(value)
-   =20
-    def attributes(self, tag):
+
+    def attributes(
+        self, tag: bs4.element.Tag # type:ignore
+    ) -> Iterable[Tuple[str, Optional[_AttributeValue]]]:
         """Reorder a tag's attributes however you want.
-       =20
+
         By default, attributes are sorted alphabetically. This makes
         behavior consistent between Python 2 and Python 3, and preserves
         backwards compatibility with older versions of Beautiful Soup.
=20
-        If `empty_boolean_attributes` is True, then attributes whose
-        values are set to the empty string will be treated as boolean
-        attributes.
+        If `empty_attributes_are_booleans` is True, then
+        attributes whose values are set to the empty string will be
+        treated as boolean attributes.
         """
         if tag.attrs is None:
             return []
+
+        items: Iterable[Tuple[str, _AttributeValue]] =3D list(tag.attrs.=
items())
         return sorted(
-            (k, (None if self.empty_attributes_are_booleans and v =3D=3D=
 '' else v))
-            for k, v in list(tag.attrs.items())
+            (k, (None if self.empty_attributes_are_booleans and v =3D=3D=
 "" else v))
+            for k, v in items
         )
-  =20
+
+
 class HTMLFormatter(Formatter):
     """A generic Formatter for HTML."""
-    REGISTRY =3D {}
-    def __init__(self, *args, **kwargs):
-        super(HTMLFormatter, self).__init__(self.HTML, *args, **kwargs)
=20
-   =20
+    REGISTRY: Dict[Optional[str], HTMLFormatter] =3D {}
+
+    def __init__(
+        self,
+        entity_substitution: Optional[_EntitySubstitutionFunction] =3D N=
one,
+        void_element_close_prefix: str =3D "/",
+        cdata_containing_tags: Optional[Set[str]] =3D None,
+        empty_attributes_are_booleans: bool =3D False,
+        indent: Union[int,str] =3D 1,
+    ):
+        super(HTMLFormatter, self).__init__(
+            self.HTML,
+            entity_substitution,
+            void_element_close_prefix,
+            cdata_containing_tags,
+            empty_attributes_are_booleans,
+            indent=3Dindent
+        )
+
+
 class XMLFormatter(Formatter):
     """A generic Formatter for XML."""
-    REGISTRY =3D {}
-    def __init__(self, *args, **kwargs):
-        super(XMLFormatter, self).__init__(self.XML, *args, **kwargs)
+
+    REGISTRY: Dict[Optional[str], XMLFormatter] =3D {}
+
+    def __init__(
+        self,
+        entity_substitution: Optional[_EntitySubstitutionFunction] =3D N=
one,
+        void_element_close_prefix: str =3D "/",
+        cdata_containing_tags: Optional[Set[str]] =3D None,
+        empty_attributes_are_booleans: bool =3D False,
+        indent: Union[int,str] =3D 1,
+    ):
+        super(XMLFormatter, self).__init__(
+            self.XML,
+            entity_substitution,
+            void_element_close_prefix,
+            cdata_containing_tags,
+            empty_attributes_are_booleans,
+            indent=3Dindent,
+        )
=20
=20
 # Set up aliases for the default formatters.
-HTMLFormatter.REGISTRY['html'] =3D HTMLFormatter(
+HTMLFormatter.REGISTRY["html"] =3D HTMLFormatter(
     entity_substitution=3DEntitySubstitution.substitute_html
 )
+
 HTMLFormatter.REGISTRY["html5"] =3D HTMLFormatter(
+    entity_substitution=3DEntitySubstitution.substitute_html5,
+    void_element_close_prefix=3D"",
+    empty_attributes_are_booleans=3DTrue,
+)
+HTMLFormatter.REGISTRY["html5-4.12"] =3D HTMLFormatter(
     entity_substitution=3DEntitySubstitution.substitute_html,
-    void_element_close_prefix=3DNone,
+    void_element_close_prefix=3D"",
     empty_attributes_are_booleans=3DTrue,
 )
 HTMLFormatter.REGISTRY["minimal"] =3D HTMLFormatter(
     entity_substitution=3DEntitySubstitution.substitute_xml
 )
-HTMLFormatter.REGISTRY[None] =3D HTMLFormatter(
-    entity_substitution=3DNone
-)
-XMLFormatter.REGISTRY["html"] =3D  XMLFormatter(
+HTMLFormatter.REGISTRY[None] =3D HTMLFormatter(entity_substitution=3DNon=
e)
+XMLFormatter.REGISTRY["html"] =3D XMLFormatter(
     entity_substitution=3DEntitySubstitution.substitute_html
 )
 XMLFormatter.REGISTRY["minimal"] =3D XMLFormatter(
     entity_substitution=3DEntitySubstitution.substitute_xml
 )
-XMLFormatter.REGISTRY[None] =3D Formatter(
-    Formatter(Formatter.XML, entity_substitution=3DNone)
-)
+
+XMLFormatter.REGISTRY[None] =3D XMLFormatter(entity_substitution=3DNone)
+
+# Define type aliases to improve readability.
+#
+
+#: A function to call to replace special characters with XML or HTML
+#: entities.
+_EntitySubstitutionFunction: TypeAlias =3D Callable[[str], str]
+
+# Many of the output-centered methods take an argument that can either
+# be a Formatter object or the name of a Formatter to be looked up.
+_FormatterOrName =3D Union[Formatter, str]
diff --git a/lib/bb/_vendor/bs4/py.typed b/lib/bb/_vendor/bs4/py.typed
new file mode 100644
index 000000000..e69de29bb
diff --git a/lib/bb/_vendor/ply.pyi b/lib/bb/_vendor/ply.pyi
new file mode 100644
index 000000000..5a6b56582
--- /dev/null
+++ b/lib/bb/_vendor/ply.pyi
@@ -0,0 +1 @@
+from ply import *
\ No newline at end of file
diff --git a/lib/bb/_vendor/ply/__init__.py b/lib/bb/_vendor/ply/__init__=
.py
index 853a98554..6e53cddcf 100644
--- a/lib/bb/_vendor/ply/__init__.py
+++ b/lib/bb/_vendor/ply/__init__.py
@@ -1,4 +1,5 @@
 # PLY package
 # Author: David Beazley (dave@dabeaz.com)
=20
+__version__ =3D '3.9'
 __all__ =3D ['lex','yacc']
diff --git a/lib/bb/_vendor/ply/cpp.py b/lib/bb/_vendor/ply/cpp.py
new file mode 100644
index 000000000..b049f412b
--- /dev/null
+++ b/lib/bb/_vendor/ply/cpp.py
@@ -0,0 +1,918 @@
+# ----------------------------------------------------------------------=
-------
+# cpp.py
+#
+# Author:  David Beazley (http://www.dabeaz.com)
+# Copyright (C) 2007
+# All rights reserved
+#
+# This module implements an ANSI-C style lexical preprocessor for PLY.=20
+# ----------------------------------------------------------------------=
-------
+from __future__ import generators
+
+import sys
+
+# Some Python 3 compatibility shims
+if sys.version_info.major < 3:
+    STRING_TYPES =3D (str, unicode)
+else:
+    STRING_TYPES =3D str
+    xrange =3D range
+
+# ----------------------------------------------------------------------=
-------
+# Default preprocessor lexer definitions.   These tokens are enough to g=
et
+# a basic preprocessor working.   Other modules may import these if they=
 want
+# ----------------------------------------------------------------------=
-------
+
+tokens =3D (
+   'CPP_ID','CPP_INTEGER', 'CPP_FLOAT', 'CPP_STRING', 'CPP_CHAR', 'CPP_W=
S', 'CPP_COMMENT1', 'CPP_COMMENT2', 'CPP_POUND','CPP_DPOUND'
+)
+
+literals =3D "+-*/%|&~^<>=3D!?()[]{}.,;:\\\'\""
+
+# Whitespace
+def t_CPP_WS(t):
+    r'\s+'
+    t.lexer.lineno +=3D t.value.count("\n")
+    return t
+
+t_CPP_POUND =3D r'\#'
+t_CPP_DPOUND =3D r'\#\#'
+
+# Identifier
+t_CPP_ID =3D r'[A-Za-z_][\w_]*'
+
+# Integer literal
+def CPP_INTEGER(t):
+    r'(((((0x)|(0X))[0-9a-fA-F]+)|(\d+))([uU][lL]|[lL][uU]|[uU]|[lL])?)'
+    return t
+
+t_CPP_INTEGER =3D CPP_INTEGER
+
+# Floating literal
+t_CPP_FLOAT =3D r'((\d+)(\.\d+)(e(\+|-)?(\d+))? | (\d+)e(\+|-)?(\d+))([l=
L]|[fF])?'
+
+# String literal
+def t_CPP_STRING(t):
+    r'\"([^\\\n]|(\\(.|\n)))*?\"'
+    t.lexer.lineno +=3D t.value.count("\n")
+    return t
+
+# Character constant 'c' or L'c'
+def t_CPP_CHAR(t):
+    r'(L)?\'([^\\\n]|(\\(.|\n)))*?\''
+    t.lexer.lineno +=3D t.value.count("\n")
+    return t
+
+# Comment
+def t_CPP_COMMENT1(t):
+    r'(/\*(.|\n)*?\*/)'
+    ncr =3D t.value.count("\n")
+    t.lexer.lineno +=3D ncr
+    # replace with one space or a number of '\n'
+    t.type =3D 'CPP_WS'; t.value =3D '\n' * ncr if ncr else ' '
+    return t
+
+# Line comment
+def t_CPP_COMMENT2(t):
+    r'(//.*?(\n|$))'
+    # replace with '/n'
+    t.type =3D 'CPP_WS'; t.value =3D '\n'
+    return t
+   =20
+def t_error(t):
+    t.type =3D t.value[0]
+    t.value =3D t.value[0]
+    t.lexer.skip(1)
+    return t
+
+import re
+import copy
+import time
+import os.path
+
+# ----------------------------------------------------------------------=
-------
+# trigraph()
+#=20
+# Given an input string, this function replaces all trigraph sequences.=20
+# The following mapping is used:
+#
+#     ??=3D    #
+#     ??/    \
+#     ??'    ^
+#     ??(    [
+#     ??)    ]
+#     ??!    |
+#     ??<    {
+#     ??>    }
+#     ??-    ~
+# ----------------------------------------------------------------------=
-------
+
+_trigraph_pat =3D re.compile(r'''\?\?[=3D/\'\(\)\!<>\-]''')
+_trigraph_rep =3D {
+    '=3D':'#',
+    '/':'\\',
+    "'":'^',
+    '(':'[',
+    ')':']',
+    '!':'|',
+    '<':'{',
+    '>':'}',
+    '-':'~'
+}
+
+def trigraph(input):
+    return _trigraph_pat.sub(lambda g: _trigraph_rep[g.group()[-1]],inpu=
t)
+
+# ------------------------------------------------------------------
+# Macro object
+#
+# This object holds information about preprocessor macros
+#
+#    .name      - Macro name (string)
+#    .value     - Macro value (a list of tokens)
+#    .arglist   - List of argument names
+#    .variadic  - Boolean indicating whether or not variadic macro
+#    .vararg    - Name of the variadic parameter
+#
+# When a macro is created, the macro replacement token sequence is
+# pre-scanned and used to create patch lists that are later used
+# during macro expansion
+# ------------------------------------------------------------------
+
+class Macro(object):
+    def __init__(self,name,value,arglist=3DNone,variadic=3DFalse):
+        self.name =3D name
+        self.value =3D value
+        self.arglist =3D arglist
+        self.variadic =3D variadic
+        if variadic:
+            self.vararg =3D arglist[-1]
+        self.source =3D None
+
+# ------------------------------------------------------------------
+# Preprocessor object
+#
+# Object representing a preprocessor.  Contains macro definitions,
+# include directories, and other information
+# ------------------------------------------------------------------
+
+class Preprocessor(object):
+    def __init__(self,lexer=3DNone):
+        if lexer is None:
+            lexer =3D lex.lexer
+        self.lexer =3D lexer
+        self.macros =3D { }
+        self.path =3D []
+        self.temp_path =3D []
+
+        # Probe the lexer for selected tokens
+        self.lexprobe()
+
+        tm =3D time.localtime()
+        self.define("__DATE__ \"%s\"" % time.strftime("%b %d %Y",tm))
+        self.define("__TIME__ \"%s\"" % time.strftime("%H:%M:%S",tm))
+        self.parser =3D None
+
+    # ------------------------------------------------------------------=
-----------
+    # tokenize()
+    #
+    # Utility function. Given a string of text, tokenize into a list of =
tokens
+    # ------------------------------------------------------------------=
-----------
+
+    def tokenize(self,text):
+        tokens =3D []
+        self.lexer.input(text)
+        while True:
+            tok =3D self.lexer.token()
+            if not tok: break
+            tokens.append(tok)
+        return tokens
+
+    # ------------------------------------------------------------------=
---
+    # error()
+    #
+    # Report a preprocessor error/warning of some kind
+    # ------------------------------------------------------------------=
----
+
+    def error(self,file,line,msg):
+        print("%s:%d %s" % (file,line,msg))
+
+    # ------------------------------------------------------------------=
----
+    # lexprobe()
+    #
+    # This method probes the preprocessor lexer object to discover
+    # the token types of symbols that are important to the preprocessor.
+    # If this works right, the preprocessor will simply "work"
+    # with any suitable lexer regardless of how tokens have been named.
+    # ------------------------------------------------------------------=
----
+
+    def lexprobe(self):
+
+        # Determine the token type for identifiers
+        self.lexer.input("identifier")
+        tok =3D self.lexer.token()
+        if not tok or tok.value !=3D "identifier":
+            print("Couldn't determine identifier type")
+        else:
+            self.t_ID =3D tok.type
+
+        # Determine the token type for integers
+        self.lexer.input("12345")
+        tok =3D self.lexer.token()
+        if not tok or int(tok.value) !=3D 12345:
+            print("Couldn't determine integer type")
+        else:
+            self.t_INTEGER =3D tok.type
+            self.t_INTEGER_TYPE =3D type(tok.value)
+
+        # Determine the token type for strings enclosed in double quotes
+        self.lexer.input("\"filename\"")
+        tok =3D self.lexer.token()
+        if not tok or tok.value !=3D "\"filename\"":
+            print("Couldn't determine string type")
+        else:
+            self.t_STRING =3D tok.type
+
+        # Determine the token type for whitespace--if any
+        self.lexer.input("  ")
+        tok =3D self.lexer.token()
+        if not tok or tok.value !=3D "  ":
+            self.t_SPACE =3D None
+        else:
+            self.t_SPACE =3D tok.type
+
+        # Determine the token type for newlines
+        self.lexer.input("\n")
+        tok =3D self.lexer.token()
+        if not tok or tok.value !=3D "\n":
+            self.t_NEWLINE =3D None
+            print("Couldn't determine token for newlines")
+        else:
+            self.t_NEWLINE =3D tok.type
+
+        self.t_WS =3D (self.t_SPACE, self.t_NEWLINE)
+
+        # Check for other characters used by the preprocessor
+        chars =3D [ '<','>','#','##','\\','(',')',',','.']
+        for c in chars:
+            self.lexer.input(c)
+            tok =3D self.lexer.token()
+            if not tok or tok.value !=3D c:
+                print("Unable to lex '%s' required for preprocessor" % c=
)
+
+    # ------------------------------------------------------------------=
----
+    # add_path()
+    #
+    # Adds a search path to the preprocessor. =20
+    # ------------------------------------------------------------------=
----
+
+    def add_path(self,path):
+        self.path.append(path)
+
+    # ------------------------------------------------------------------=
----
+    # group_lines()
+    #
+    # Given an input string, this function splits it into lines.  Traili=
ng whitespace
+    # is removed.   Any line ending with \ is grouped with the next line=
.  This
+    # function forms the lowest level of the preprocessor---grouping int=
o text into
+    # a line-by-line format.
+    # ------------------------------------------------------------------=
----
+
+    def group_lines(self,input):
+        lex =3D self.lexer.clone()
+        lines =3D [x.rstrip() for x in input.splitlines()]
+        for i in xrange(len(lines)):
+            j =3D i+1
+            while lines[i].endswith('\\') and (j < len(lines)):
+                lines[i] =3D lines[i][:-1]+lines[j]
+                lines[j] =3D ""
+                j +=3D 1
+
+        input =3D "\n".join(lines)
+        lex.input(input)
+        lex.lineno =3D 1
+
+        current_line =3D []
+        while True:
+            tok =3D lex.token()
+            if not tok:
+                break
+            current_line.append(tok)
+            if tok.type in self.t_WS and '\n' in tok.value:
+                yield current_line
+                current_line =3D []
+
+        if current_line:
+            yield current_line
+
+    # ------------------------------------------------------------------=
----
+    # tokenstrip()
+    #=20
+    # Remove leading/trailing whitespace tokens from a token list
+    # ------------------------------------------------------------------=
----
+
+    def tokenstrip(self,tokens):
+        i =3D 0
+        while i < len(tokens) and tokens[i].type in self.t_WS:
+            i +=3D 1
+        del tokens[:i]
+        i =3D len(tokens)-1
+        while i >=3D 0 and tokens[i].type in self.t_WS:
+            i -=3D 1
+        del tokens[i+1:]
+        return tokens
+
+
+    # ------------------------------------------------------------------=
----
+    # collect_args()
+    #
+    # Collects comma separated arguments from a list of tokens.   The ar=
guments
+    # must be enclosed in parenthesis.  Returns a tuple (tokencount,args=
,positions)
+    # where tokencount is the number of tokens consumed, args is a list =
of arguments,
+    # and positions is a list of integers containing the starting index =
of each
+    # argument.  Each argument is represented by a list of tokens.
+    #
+    # When collecting arguments, leading and trailing whitespace is remo=
ved
+    # from each argument. =20
+    #
+    # This function properly handles nested parenthesis and commas---the=
se do not
+    # define new arguments.
+    # ------------------------------------------------------------------=
----
+
+    def collect_args(self,tokenlist):
+        args =3D []
+        positions =3D []
+        current_arg =3D []
+        nesting =3D 1
+        tokenlen =3D len(tokenlist)
+   =20
+        # Search for the opening '('.
+        i =3D 0
+        while (i < tokenlen) and (tokenlist[i].type in self.t_WS):
+            i +=3D 1
+
+        if (i < tokenlen) and (tokenlist[i].value =3D=3D '('):
+            positions.append(i+1)
+        else:
+            self.error(self.source,tokenlist[0].lineno,"Missing '(' in m=
acro arguments")
+            return 0, [], []
+
+        i +=3D 1
+
+        while i < tokenlen:
+            t =3D tokenlist[i]
+            if t.value =3D=3D '(':
+                current_arg.append(t)
+                nesting +=3D 1
+            elif t.value =3D=3D ')':
+                nesting -=3D 1
+                if nesting =3D=3D 0:
+                    if current_arg:
+                        args.append(self.tokenstrip(current_arg))
+                        positions.append(i)
+                    return i+1,args,positions
+                current_arg.append(t)
+            elif t.value =3D=3D ',' and nesting =3D=3D 1:
+                args.append(self.tokenstrip(current_arg))
+                positions.append(i+1)
+                current_arg =3D []
+            else:
+                current_arg.append(t)
+            i +=3D 1
+   =20
+        # Missing end argument
+        self.error(self.source,tokenlist[-1].lineno,"Missing ')' in macr=
o arguments")
+        return 0, [],[]
+
+    # ------------------------------------------------------------------=
----
+    # macro_prescan()
+    #
+    # Examine the macro value (token sequence) and identify patch points
+    # This is used to speed up macro expansion later on---we'll know
+    # right away where to apply patches to the value to form the expansi=
on
+    # ------------------------------------------------------------------=
----
+   =20
+    def macro_prescan(self,macro):
+        macro.patch     =3D []             # Standard macro arguments=20
+        macro.str_patch =3D []             # String conversion expansion
+        macro.var_comma_patch =3D []       # Variadic macro comma patch
+        i =3D 0
+        while i < len(macro.value):
+            if macro.value[i].type =3D=3D self.t_ID and macro.value[i].v=
alue in macro.arglist:
+                argnum =3D macro.arglist.index(macro.value[i].value)
+                # Conversion of argument to a string
+                if i > 0 and macro.value[i-1].value =3D=3D '#':
+                    macro.value[i] =3D copy.copy(macro.value[i])
+                    macro.value[i].type =3D self.t_STRING
+                    del macro.value[i-1]
+                    macro.str_patch.append((argnum,i-1))
+                    continue
+                # Concatenation
+                elif (i > 0 and macro.value[i-1].value =3D=3D '##'):
+                    macro.patch.append(('c',argnum,i-1))
+                    del macro.value[i-1]
+                    continue
+                elif ((i+1) < len(macro.value) and macro.value[i+1].valu=
e =3D=3D '##'):
+                    macro.patch.append(('c',argnum,i))
+                    i +=3D 1
+                    continue
+                # Standard expansion
+                else:
+                    macro.patch.append(('e',argnum,i))
+            elif macro.value[i].value =3D=3D '##':
+                if macro.variadic and (i > 0) and (macro.value[i-1].valu=
e =3D=3D ',') and \
+                        ((i+1) < len(macro.value)) and (macro.value[i+1]=
.type =3D=3D self.t_ID) and \
+                        (macro.value[i+1].value =3D=3D macro.vararg):
+                    macro.var_comma_patch.append(i-1)
+            i +=3D 1
+        macro.patch.sort(key=3Dlambda x: x[2],reverse=3DTrue)
+
+    # ------------------------------------------------------------------=
----
+    # macro_expand_args()
+    #
+    # Given a Macro and list of arguments (each a token list), this meth=
od
+    # returns an expanded version of a macro.  The return value is a tok=
en sequence
+    # representing the replacement macro tokens
+    # ------------------------------------------------------------------=
----
+
+    def macro_expand_args(self,macro,args):
+        # Make a copy of the macro token sequence
+        rep =3D [copy.copy(_x) for _x in macro.value]
+
+        # Make string expansion patches.  These do not alter the length =
of the replacement sequence
+       =20
+        str_expansion =3D {}
+        for argnum, i in macro.str_patch:
+            if argnum not in str_expansion:
+                str_expansion[argnum] =3D ('"%s"' % "".join([x.value for=
 x in args[argnum]])).replace("\\","\\\\")
+            rep[i] =3D copy.copy(rep[i])
+            rep[i].value =3D str_expansion[argnum]
+
+        # Make the variadic macro comma patch.  If the variadic macro ar=
gument is empty, we get rid
+        comma_patch =3D False
+        if macro.variadic and not args[-1]:
+            for i in macro.var_comma_patch:
+                rep[i] =3D None
+                comma_patch =3D True
+
+        # Make all other patches.   The order of these matters.  It is a=
ssumed that the patch list
+        # has been sorted in reverse order of patch location since repla=
cements will cause the
+        # size of the replacement sequence to expand from the patch poin=
t.
+       =20
+        expanded =3D { }
+        for ptype, argnum, i in macro.patch:
+            # Concatenation.   Argument is left unexpanded
+            if ptype =3D=3D 'c':
+                rep[i:i+1] =3D args[argnum]
+            # Normal expansion.  Argument is macro expanded first
+            elif ptype =3D=3D 'e':
+                if argnum not in expanded:
+                    expanded[argnum] =3D self.expand_macros(args[argnum]=
)
+                rep[i:i+1] =3D expanded[argnum]
+
+        # Get rid of removed comma if necessary
+        if comma_patch:
+            rep =3D [_i for _i in rep if _i]
+
+        return rep
+
+
+    # ------------------------------------------------------------------=
----
+    # expand_macros()
+    #
+    # Given a list of tokens, this function performs macro expansion.
+    # The expanded argument is a dictionary that contains macros already
+    # expanded.  This is used to prevent infinite recursion.
+    # ------------------------------------------------------------------=
----
+
+    def expand_macros(self,tokens,expanded=3DNone):
+        if expanded is None:
+            expanded =3D {}
+        i =3D 0
+        while i < len(tokens):
+            t =3D tokens[i]
+            if t.type =3D=3D self.t_ID:
+                if t.value in self.macros and t.value not in expanded:
+                    # Yes, we found a macro match
+                    expanded[t.value] =3D True
+                   =20
+                    m =3D self.macros[t.value]
+                    if not m.arglist:
+                        # A simple macro
+                        ex =3D self.expand_macros([copy.copy(_x) for _x =
in m.value],expanded)
+                        for e in ex:
+                            e.lineno =3D t.lineno
+                        tokens[i:i+1] =3D ex
+                        i +=3D len(ex)
+                    else:
+                        # A macro with arguments
+                        j =3D i + 1
+                        while j < len(tokens) and tokens[j].type in self=
.t_WS:
+                            j +=3D 1
+                        if tokens[j].value =3D=3D '(':
+                            tokcount,args,positions =3D self.collect_arg=
s(tokens[j:])
+                            if not m.variadic and len(args) !=3D  len(m.=
arglist):
+                                self.error(self.source,t.lineno,"Macro %=
s requires %d arguments" % (t.value,len(m.arglist)))
+                                i =3D j + tokcount
+                            elif m.variadic and len(args) < len(m.arglis=
t)-1:
+                                if len(m.arglist) > 2:
+                                    self.error(self.source,t.lineno,"Mac=
ro %s must have at least %d arguments" % (t.value, len(m.arglist)-1))
+                                else:
+                                    self.error(self.source,t.lineno,"Mac=
ro %s must have at least %d argument" % (t.value, len(m.arglist)-1))
+                                i =3D j + tokcount
+                            else:
+                                if m.variadic:
+                                    if len(args) =3D=3D len(m.arglist)-1=
:
+                                        args.append([])
+                                    else:
+                                        args[len(m.arglist)-1] =3D token=
s[j+positions[len(m.arglist)-1]:j+tokcount-1]
+                                        del args[len(m.arglist):]
+                                       =20
+                                # Get macro replacement text
+                                rep =3D self.macro_expand_args(m,args)
+                                rep =3D self.expand_macros(rep,expanded)
+                                for r in rep:
+                                    r.lineno =3D t.lineno
+                                tokens[i:j+tokcount] =3D rep
+                                i +=3D len(rep)
+                    del expanded[t.value]
+                    continue
+                elif t.value =3D=3D '__LINE__':
+                    t.type =3D self.t_INTEGER
+                    t.value =3D self.t_INTEGER_TYPE(t.lineno)
+               =20
+            i +=3D 1
+        return tokens
+
+    # ------------------------------------------------------------------=
----   =20
+    # evalexpr()
+    #=20
+    # Evaluate an expression token sequence for the purposes of evaluati=
ng
+    # integral expressions.
+    # ------------------------------------------------------------------=
----
+
+    def evalexpr(self,tokens):
+        # tokens =3D tokenize(line)
+        # Search for defined macros
+        i =3D 0
+        while i < len(tokens):
+            if tokens[i].type =3D=3D self.t_ID and tokens[i].value =3D=3D=
 'defined':
+                j =3D i + 1
+                needparen =3D False
+                result =3D "0L"
+                while j < len(tokens):
+                    if tokens[j].type in self.t_WS:
+                        j +=3D 1
+                        continue
+                    elif tokens[j].type =3D=3D self.t_ID:
+                        if tokens[j].value in self.macros:
+                            result =3D "1L"
+                        else:
+                            result =3D "0L"
+                        if not needparen: break
+                    elif tokens[j].value =3D=3D '(':
+                        needparen =3D True
+                    elif tokens[j].value =3D=3D ')':
+                        break
+                    else:
+                        self.error(self.source,tokens[i].lineno,"Malform=
ed defined()")
+                    j +=3D 1
+                tokens[i].type =3D self.t_INTEGER
+                tokens[i].value =3D self.t_INTEGER_TYPE(result)
+                del tokens[i+1:j+1]
+            i +=3D 1
+        tokens =3D self.expand_macros(tokens)
+        for i,t in enumerate(tokens):
+            if t.type =3D=3D self.t_ID:
+                tokens[i] =3D copy.copy(t)
+                tokens[i].type =3D self.t_INTEGER
+                tokens[i].value =3D self.t_INTEGER_TYPE("0L")
+            elif t.type =3D=3D self.t_INTEGER:
+                tokens[i] =3D copy.copy(t)
+                # Strip off any trailing suffixes
+                tokens[i].value =3D str(tokens[i].value)
+                while tokens[i].value[-1] not in "0123456789abcdefABCDEF=
":
+                    tokens[i].value =3D tokens[i].value[:-1]
+       =20
+        expr =3D "".join([str(x.value) for x in tokens])
+        expr =3D expr.replace("&&"," and ")
+        expr =3D expr.replace("||"," or ")
+        expr =3D expr.replace("!"," not ")
+        try:
+            result =3D eval(expr)
+        except Exception:
+            self.error(self.source,tokens[0].lineno,"Couldn't evaluate e=
xpression")
+            result =3D 0
+        return result
+
+    # ------------------------------------------------------------------=
----
+    # parsegen()
+    #
+    # Parse an input string/
+    # ------------------------------------------------------------------=
----
+    def parsegen(self,input,source=3DNone):
+
+        # Replace trigraph sequences
+        t =3D trigraph(input)
+        lines =3D self.group_lines(t)
+
+        if not source:
+            source =3D ""
+           =20
+        self.define("__FILE__ \"%s\"" % source)
+
+        self.source =3D source
+        chunk =3D []
+        enable =3D True
+        iftrigger =3D False
+        ifstack =3D []
+
+        for x in lines:
+            for i,tok in enumerate(x):
+                if tok.type not in self.t_WS: break
+            if tok.value =3D=3D '#':
+                # Preprocessor directive
+
+                # insert necessary whitespace instead of eaten tokens
+                for tok in x:
+                    if tok.type in self.t_WS and '\n' in tok.value:
+                        chunk.append(tok)
+               =20
+                dirtokens =3D self.tokenstrip(x[i+1:])
+                if dirtokens:
+                    name =3D dirtokens[0].value
+                    args =3D self.tokenstrip(dirtokens[1:])
+                else:
+                    name =3D ""
+                    args =3D []
+               =20
+                if name =3D=3D 'define':
+                    if enable:
+                        for tok in self.expand_macros(chunk):
+                            yield tok
+                        chunk =3D []
+                        self.define(args)
+                elif name =3D=3D 'include':
+                    if enable:
+                        for tok in self.expand_macros(chunk):
+                            yield tok
+                        chunk =3D []
+                        oldfile =3D self.macros['__FILE__']
+                        for tok in self.include(args):
+                            yield tok
+                        self.macros['__FILE__'] =3D oldfile
+                        self.source =3D source
+                elif name =3D=3D 'undef':
+                    if enable:
+                        for tok in self.expand_macros(chunk):
+                            yield tok
+                        chunk =3D []
+                        self.undef(args)
+                elif name =3D=3D 'ifdef':
+                    ifstack.append((enable,iftrigger))
+                    if enable:
+                        if not args[0].value in self.macros:
+                            enable =3D False
+                            iftrigger =3D False
+                        else:
+                            iftrigger =3D True
+                elif name =3D=3D 'ifndef':
+                    ifstack.append((enable,iftrigger))
+                    if enable:
+                        if args[0].value in self.macros:
+                            enable =3D False
+                            iftrigger =3D False
+                        else:
+                            iftrigger =3D True
+                elif name =3D=3D 'if':
+                    ifstack.append((enable,iftrigger))
+                    if enable:
+                        result =3D self.evalexpr(args)
+                        if not result:
+                            enable =3D False
+                            iftrigger =3D False
+                        else:
+                            iftrigger =3D True
+                elif name =3D=3D 'elif':
+                    if ifstack:
+                        if ifstack[-1][0]:     # We only pay attention i=
f outer "if" allows this
+                            if enable:         # If already true, we fli=
p enable False
+                                enable =3D False
+                            elif not iftrigger:   # If False, but not tr=
iggered yet, we'll check expression
+                                result =3D self.evalexpr(args)
+                                if result:
+                                    enable  =3D True
+                                    iftrigger =3D True
+                    else:
+                        self.error(self.source,dirtokens[0].lineno,"Misp=
laced #elif")
+                       =20
+                elif name =3D=3D 'else':
+                    if ifstack:
+                        if ifstack[-1][0]:
+                            if enable:
+                                enable =3D False
+                            elif not iftrigger:
+                                enable =3D True
+                                iftrigger =3D True
+                    else:
+                        self.error(self.source,dirtokens[0].lineno,"Misp=
laced #else")
+
+                elif name =3D=3D 'endif':
+                    if ifstack:
+                        enable,iftrigger =3D ifstack.pop()
+                    else:
+                        self.error(self.source,dirtokens[0].lineno,"Misp=
laced #endif")
+                else:
+                    # Unknown preprocessor directive
+                    pass
+
+            else:
+                # Normal text
+                if enable:
+                    chunk.extend(x)
+
+        for tok in self.expand_macros(chunk):
+            yield tok
+        chunk =3D []
+
+    # ------------------------------------------------------------------=
----
+    # include()
+    #
+    # Implementation of file-inclusion
+    # ------------------------------------------------------------------=
----
+
+    def include(self,tokens):
+        # Try to extract the filename and then process an include file
+        if not tokens:
+            return
+        if tokens:
+            if tokens[0].value !=3D '<' and tokens[0].type !=3D self.t_S=
TRING:
+                tokens =3D self.expand_macros(tokens)
+
+            if tokens[0].value =3D=3D '<':
+                # Include <...>
+                i =3D 1
+                while i < len(tokens):
+                    if tokens[i].value =3D=3D '>':
+                        break
+                    i +=3D 1
+                else:
+                    print("Malformed #include <...>")
+                    return
+                filename =3D "".join([x.value for x in tokens[1:i]])
+                path =3D self.path + [""] + self.temp_path
+            elif tokens[0].type =3D=3D self.t_STRING:
+                filename =3D tokens[0].value[1:-1]
+                path =3D self.temp_path + [""] + self.path
+            else:
+                print("Malformed #include statement")
+                return
+        for p in path:
+            iname =3D os.path.join(p,filename)
+            try:
+                data =3D open(iname,"r").read()
+                dname =3D os.path.dirname(iname)
+                if dname:
+                    self.temp_path.insert(0,dname)
+                for tok in self.parsegen(data,filename):
+                    yield tok
+                if dname:
+                    del self.temp_path[0]
+                break
+            except IOError:
+                pass
+        else:
+            print("Couldn't find '%s'" % filename)
+
+    # ------------------------------------------------------------------=
----
+    # define()
+    #
+    # Define a new macro
+    # ------------------------------------------------------------------=
----
+
+    def define(self,tokens):
+        if isinstance(tokens,STRING_TYPES):
+            tokens =3D self.tokenize(tokens)
+
+        linetok =3D tokens
+        try:
+            name =3D linetok[0]
+            if len(linetok) > 1:
+                mtype =3D linetok[1]
+            else:
+                mtype =3D None
+            if not mtype:
+                m =3D Macro(name.value,[])
+                self.macros[name.value] =3D m
+            elif mtype.type in self.t_WS:
+                # A normal macro
+                m =3D Macro(name.value,self.tokenstrip(linetok[2:]))
+                self.macros[name.value] =3D m
+            elif mtype.value =3D=3D '(':
+                # A macro with arguments
+                tokcount, args, positions =3D self.collect_args(linetok[=
1:])
+                variadic =3D False
+                for a in args:
+                    if variadic:
+                        print("No more arguments may follow a variadic a=
rgument")
+                        break
+                    astr =3D "".join([str(_i.value) for _i in a])
+                    if astr =3D=3D "...":
+                        variadic =3D True
+                        a[0].type =3D self.t_ID
+                        a[0].value =3D '__VA_ARGS__'
+                        variadic =3D True
+                        del a[1:]
+                        continue
+                    elif astr[-3:] =3D=3D "..." and a[0].type =3D=3D sel=
f.t_ID:
+                        variadic =3D True
+                        del a[1:]
+                        # If, for some reason, "." is part of the identi=
fier, strip off the name for the purposes
+                        # of macro expansion
+                        if a[0].value[-3:] =3D=3D '...':
+                            a[0].value =3D a[0].value[:-3]
+                        continue
+                    if len(a) > 1 or a[0].type !=3D self.t_ID:
+                        print("Invalid macro argument")
+                        break
+                else:
+                    mvalue =3D self.tokenstrip(linetok[1+tokcount:])
+                    i =3D 0
+                    while i < len(mvalue):
+                        if i+1 < len(mvalue):
+                            if mvalue[i].type in self.t_WS and mvalue[i+=
1].value =3D=3D '##':
+                                del mvalue[i]
+                                continue
+                            elif mvalue[i].value =3D=3D '##' and mvalue[=
i+1].type in self.t_WS:
+                                del mvalue[i+1]
+                        i +=3D 1
+                    m =3D Macro(name.value,mvalue,[x[0].value for x in a=
rgs],variadic)
+                    self.macro_prescan(m)
+                    self.macros[name.value] =3D m
+            else:
+                print("Bad macro definition")
+        except LookupError:
+            print("Bad macro definition")
+
+    # ------------------------------------------------------------------=
----
+    # undef()
+    #
+    # Undefine a macro
+    # ------------------------------------------------------------------=
----
+
+    def undef(self,tokens):
+        id =3D tokens[0].value
+        try:
+            del self.macros[id]
+        except LookupError:
+            pass
+
+    # ------------------------------------------------------------------=
----
+    # parse()
+    #
+    # Parse input text.
+    # ------------------------------------------------------------------=
----
+    def parse(self,input,source=3DNone,ignore=3D{}):
+        self.ignore =3D ignore
+        self.parser =3D self.parsegen(input,source)
+       =20
+    # ------------------------------------------------------------------=
----
+    # token()
+    #
+    # Method to return individual tokens
+    # ------------------------------------------------------------------=
----
+    def token(self):
+        try:
+            while True:
+                tok =3D next(self.parser)
+                if tok.type not in self.ignore: return tok
+        except StopIteration:
+            self.parser =3D None
+            return None
+
+if __name__ =3D=3D '__main__':
+    import bb._vendor.ply.lex as lex
+    lexer =3D lex.lex()
+
+    # Run a preprocessor
+    import sys
+    f =3D open(sys.argv[1])
+    input =3D f.read()
+
+    p =3D Preprocessor(lexer)
+    p.parse(input,sys.argv[1])
+    while True:
+        tok =3D p.token()
+        if not tok: break
+        print(p.source, tok)
+
+
+
+
+   =20
+
+
+
+
+
+
diff --git a/lib/bb/_vendor/ply/ctokens.py b/lib/bb/_vendor/ply/ctokens.p=
y
new file mode 100644
index 000000000..f6f6952d6
--- /dev/null
+++ b/lib/bb/_vendor/ply/ctokens.py
@@ -0,0 +1,133 @@
+# ----------------------------------------------------------------------
+# ctokens.py
+#
+# Token specifications for symbols in ANSI C and C++.  This file is
+# meant to be used as a library in other tokenizers.
+# ----------------------------------------------------------------------
+
+# Reserved words
+
+tokens =3D [
+    # Literals (identifier, integer constant, float constant, string con=
stant, char const)
+    'ID', 'TYPEID', 'INTEGER', 'FLOAT', 'STRING', 'CHARACTER',
+
+    # Operators (+,-,*,/,%,|,&,~,^,<<,>>, ||, &&, !, <, <=3D, >, >=3D, =3D=
=3D, !=3D)
+    'PLUS', 'MINUS', 'TIMES', 'DIVIDE', 'MODULO',
+    'OR', 'AND', 'NOT', 'XOR', 'LSHIFT', 'RSHIFT',
+    'LOR', 'LAND', 'LNOT',
+    'LT', 'LE', 'GT', 'GE', 'EQ', 'NE',
+   =20
+    # Assignment (=3D, *=3D, /=3D, %=3D, +=3D, -=3D, <<=3D, >>=3D, &=3D,=
 ^=3D, |=3D)
+    'EQUALS', 'TIMESEQUAL', 'DIVEQUAL', 'MODEQUAL', 'PLUSEQUAL', 'MINUSE=
QUAL',
+    'LSHIFTEQUAL','RSHIFTEQUAL', 'ANDEQUAL', 'XOREQUAL', 'OREQUAL',
+
+    # Increment/decrement (++,--)
+    'INCREMENT', 'DECREMENT',
+
+    # Structure dereference (->)
+    'ARROW',
+
+    # Ternary operator (?)
+    'TERNARY',
+   =20
+    # Delimeters ( ) [ ] { } , . ; :
+    'LPAREN', 'RPAREN',
+    'LBRACKET', 'RBRACKET',
+    'LBRACE', 'RBRACE',
+    'COMMA', 'PERIOD', 'SEMI', 'COLON',
+
+    # Ellipsis (...)
+    'ELLIPSIS',
+]
+   =20
+# Operators
+t_PLUS             =3D r'\+'
+t_MINUS            =3D r'-'
+t_TIMES            =3D r'\*'
+t_DIVIDE           =3D r'/'
+t_MODULO           =3D r'%'
+t_OR               =3D r'\|'
+t_AND              =3D r'&'
+t_NOT              =3D r'~'
+t_XOR              =3D r'\^'
+t_LSHIFT           =3D r'<<'
+t_RSHIFT           =3D r'>>'
+t_LOR              =3D r'\|\|'
+t_LAND             =3D r'&&'
+t_LNOT             =3D r'!'
+t_LT               =3D r'<'
+t_GT               =3D r'>'
+t_LE               =3D r'<=3D'
+t_GE               =3D r'>=3D'
+t_EQ               =3D r'=3D=3D'
+t_NE               =3D r'!=3D'
+
+# Assignment operators
+
+t_EQUALS           =3D r'=3D'
+t_TIMESEQUAL       =3D r'\*=3D'
+t_DIVEQUAL         =3D r'/=3D'
+t_MODEQUAL         =3D r'%=3D'
+t_PLUSEQUAL        =3D r'\+=3D'
+t_MINUSEQUAL       =3D r'-=3D'
+t_LSHIFTEQUAL      =3D r'<<=3D'
+t_RSHIFTEQUAL      =3D r'>>=3D'
+t_ANDEQUAL         =3D r'&=3D'
+t_OREQUAL          =3D r'\|=3D'
+t_XOREQUAL         =3D r'\^=3D'
+
+# Increment/decrement
+t_INCREMENT        =3D r'\+\+'
+t_DECREMENT        =3D r'--'
+
+# ->
+t_ARROW            =3D r'->'
+
+# ?
+t_TERNARY          =3D r'\?'
+
+# Delimeters
+t_LPAREN           =3D r'\('
+t_RPAREN           =3D r'\)'
+t_LBRACKET         =3D r'\['
+t_RBRACKET         =3D r'\]'
+t_LBRACE           =3D r'\{'
+t_RBRACE           =3D r'\}'
+t_COMMA            =3D r','
+t_PERIOD           =3D r'\.'
+t_SEMI             =3D r';'
+t_COLON            =3D r':'
+t_ELLIPSIS         =3D r'\.\.\.'
+
+# Identifiers
+t_ID =3D r'[A-Za-z_][A-Za-z0-9_]*'
+
+# Integer literal
+t_INTEGER =3D r'\d+([uU]|[lL]|[uU][lL]|[lL][uU])?'
+
+# Floating literal
+t_FLOAT =3D r'((\d+)(\.\d+)(e(\+|-)?(\d+))? | (\d+)e(\+|-)?(\d+))([lL]|[=
fF])?'
+
+# String literal
+t_STRING =3D r'\"([^\\\n]|(\\.))*?\"'
+
+# Character constant 'c' or L'c'
+t_CHARACTER =3D r'(L)?\'([^\\\n]|(\\.))*?\''
+
+# Comment (C-Style)
+def t_COMMENT(t):
+    r'/\*(.|\n)*?\*/'
+    t.lexer.lineno +=3D t.value.count('\n')
+    return t
+
+# Comment (C++-Style)
+def t_CPPCOMMENT(t):
+    r'//.*\n'
+    t.lexer.lineno +=3D 1
+    return t
+
+
+   =20
+
+
+
diff --git a/lib/bb/_vendor/ply/lex.py b/lib/bb/_vendor/ply/lex.py
index 182f2e837..de011fe13 100644
--- a/lib/bb/_vendor/ply/lex.py
+++ b/lib/bb/_vendor/ply/lex.py
@@ -1,22 +1,24 @@
 # ----------------------------------------------------------------------=
-------
 # ply: lex.py
 #
-# Copyright (C) 2001-2009,
+# Copyright (C) 2001-2022
 # David M. Beazley (Dabeaz LLC)
 # All rights reserved.
 #
+# Latest version: https://github.com/dabeaz/ply
+#
 # Redistribution and use in source and binary forms, with or without
 # modification, are permitted provided that the following conditions are
 # met:
-#=20
+#
 # * Redistributions of source code must retain the above copyright notic=
e,
-#   this list of conditions and the following disclaimer. =20
-# * Redistributions in binary form must reproduce the above copyright no=
tice,=20
+#   this list of conditions and the following disclaimer.
+# * Redistributions in binary form must reproduce the above copyright no=
tice,
 #   this list of conditions and the following disclaimer in the document=
ation
-#   and/or other materials provided with the distribution. =20
-# * Neither the name of the David Beazley or Dabeaz LLC may be used to
+#   and/or other materials provided with the distribution.
+# * Neither the name of David Beazley or Dabeaz LLC may be used to
 #   endorse or promote products derived from this software without
-#  specific prior written permission.=20
+#   specific prior written permission.
 #
 # THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 # "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
@@ -31,72 +33,50 @@
 # OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 # ----------------------------------------------------------------------=
-------
=20
-__version__    =3D "3.3"
-__tabversion__ =3D "3.2"       # Version of table file used
-
-import re, sys, types, copy, os
-
-# This tuple contains known string types
-try:
-    # Python 2.6
-    StringTypes =3D (types.StringType, types.UnicodeType)
-except AttributeError:
-    # Python 3.0
-    StringTypes =3D (str, bytes)
-
-# Extract the code attribute of a function. Different implementations
-# are for Python 2/3 compatibility.
+import re
+import sys
+import types
+import copy
+import os
+import inspect
=20
-if sys.version_info[0] < 3:
-    def func_code(f):
-        return f.func_code
-else:
-    def func_code(f):
-        return f.__code__
+# This tuple contains acceptable string types
+StringTypes =3D (str, bytes)
=20
 # This regular expression is used to match valid token names
 _is_identifier =3D re.compile(r'^[a-zA-Z0-9_]+$')
=20
 # Exception thrown when invalid token encountered and no default error
 # handler is defined.
-
 class LexError(Exception):
-    def __init__(self,message,s):
-         self.args =3D (message,)
-         self.text =3D s
+    def __init__(self, message, s):
+        self.args =3D (message,)
+        self.text =3D s
=20
 # Token class.  This class is used to represent the tokens produced.
 class LexToken(object):
-    def __str__(self):
-        return "LexToken(%s,%r,%d,%d)" % (self.type,self.value,self.line=
no,self.lexpos)
     def __repr__(self):
-        return str(self)
+        return f'LexToken({self.type},{self.value!r},{self.lineno},{self=
.lexpos})'
=20
-# This object is a stand-in for a logging object created by the=20
-# logging module. =20
+# This object is a stand-in for a logging object created by the
+# logging module.
=20
 class PlyLogger(object):
-    def __init__(self,f):
+    def __init__(self, f):
         self.f =3D f
-    def critical(self,msg,*args,**kwargs):
-        self.f.write((msg % args) + "\n")
=20
-    def warning(self,msg,*args,**kwargs):
-        self.f.write("WARNING: "+ (msg % args) + "\n")
+    def critical(self, msg, *args, **kwargs):
+        self.f.write((msg % args) + '\n')
+
+    def warning(self, msg, *args, **kwargs):
+        self.f.write('WARNING: ' + (msg % args) + '\n')
=20
-    def error(self,msg,*args,**kwargs):
-        self.f.write("ERROR: " + (msg % args) + "\n")
+    def error(self, msg, *args, **kwargs):
+        self.f.write('ERROR: ' + (msg % args) + '\n')
=20
     info =3D critical
     debug =3D critical
=20
-# Null logger is used when no output is generated. Does nothing.
-class NullLogger(object):
-    def __getattribute__(self,name):
-        return self
-    def __call__(self,*args,**kwargs):
-        return self
-
 # ----------------------------------------------------------------------=
-------
 #                        =3D=3D=3D Lexing Engine =3D=3D=3D
 #
@@ -114,31 +94,32 @@ class NullLogger(object):
 class Lexer:
     def __init__(self):
         self.lexre =3D None             # Master regular expression. Thi=
s is a list of
-                                      # tuples (re,findex) where re is a=
 compiled
+                                      # tuples (re, findex) where re is =
a compiled
                                       # regular expression and findex is=
 a list
                                       # mapping regex group numbers to r=
ules
         self.lexretext =3D None         # Current regular expression str=
ings
         self.lexstatere =3D {}          # Dictionary mapping lexer state=
s to master regexs
         self.lexstateretext =3D {}      # Dictionary mapping lexer state=
s to regex strings
         self.lexstaterenames =3D {}     # Dictionary mapping lexer state=
s to symbol names
-        self.lexstate =3D "INITIAL"     # Current lexer state
+        self.lexstate =3D 'INITIAL'     # Current lexer state
         self.lexstatestack =3D []       # Stack of lexer states
         self.lexstateinfo =3D None      # State information
         self.lexstateignore =3D {}      # Dictionary of ignored characte=
rs for each state
         self.lexstateerrorf =3D {}      # Dictionary of error functions =
for each state
+        self.lexstateeoff =3D {}        # Dictionary of eof functions fo=
r each state
         self.lexreflags =3D 0           # Optional re compile flags
         self.lexdata =3D None           # Actual input data (as a string=
)
         self.lexpos =3D 0               # Current position in input text
         self.lexlen =3D 0               # Length of the input text
         self.lexerrorf =3D None         # Error rule (if any)
+        self.lexeoff =3D None           # EOF rule (if any)
         self.lextokens =3D None         # List of valid tokens
-        self.lexignore =3D ""           # Ignored characters
-        self.lexliterals =3D ""         # Literal characters that can be=
 passed through
+        self.lexignore =3D ''           # Ignored characters
+        self.lexliterals =3D ''         # Literal characters that can be=
 passed through
         self.lexmodule =3D None         # Module
         self.lineno =3D 1               # Current line number
-        self.lexoptimize =3D 0          # Optimized mode
=20
-    def clone(self,object=3DNone):
+    def clone(self, object=3DNone):
         c =3D copy.copy(self)
=20
         # If the object parameter has been supplied, it means we are att=
aching the
@@ -146,113 +127,29 @@ class Lexer:
         # the lexstatere and lexstateerrorf tables.
=20
         if object:
-            newtab =3D { }
+            newtab =3D {}
             for key, ritem in self.lexstatere.items():
                 newre =3D []
                 for cre, findex in ritem:
-                     newfindex =3D []
-                     for f in findex:
-                         if not f or not f[0]:
-                             newfindex.append(f)
-                             continue
-                         newfindex.append((getattr(object,f[0].__name__)=
,f[1]))
-                newre.append((cre,newfindex))
+                    newfindex =3D []
+                    for f in findex:
+                        if not f or not f[0]:
+                            newfindex.append(f)
+                            continue
+                        newfindex.append((getattr(object, f[0].__name__)=
, f[1]))
+                newre.append((cre, newfindex))
                 newtab[key] =3D newre
             c.lexstatere =3D newtab
-            c.lexstateerrorf =3D { }
+            c.lexstateerrorf =3D {}
             for key, ef in self.lexstateerrorf.items():
-                c.lexstateerrorf[key] =3D getattr(object,ef.__name__)
+                c.lexstateerrorf[key] =3D getattr(object, ef.__name__)
             c.lexmodule =3D object
         return c
=20
-    # ------------------------------------------------------------
-    # writetab() - Write lexer information to a table file
-    # ------------------------------------------------------------
-    def writetab(self,tabfile,outputdir=3D""):
-        if isinstance(tabfile,types.ModuleType):
-            return
-        basetabfilename =3D tabfile.split(".")[-1]
-        filename =3D os.path.join(outputdir,basetabfilename)+".py"
-        tf =3D open(filename,"w")
-        tf.write("# %s.py. This file automatically created by PLY (versi=
on %s). Don't edit!\n" % (tabfile,__version__))
-        tf.write("_tabversion   =3D %s\n" % repr(__version__))
-        tf.write("_lextokens    =3D %s\n" % repr(self.lextokens))
-        tf.write("_lexreflags   =3D %s\n" % repr(self.lexreflags))
-        tf.write("_lexliterals  =3D %s\n" % repr(self.lexliterals))
-        tf.write("_lexstateinfo =3D %s\n" % repr(self.lexstateinfo))
-
-        tabre =3D { }
-        # Collect all functions in the initial state
-        initial =3D self.lexstatere["INITIAL"]
-        initialfuncs =3D []
-        for part in initial:
-            for f in part[1]:
-                if f and f[0]:
-                    initialfuncs.append(f)
-
-        for key, lre in self.lexstatere.items():
-             titem =3D []
-             for i in range(len(lre)):
-                  titem.append((self.lexstateretext[key][i],_funcs_to_na=
mes(lre[i][1],self.lexstaterenames[key][i])))
-             tabre[key] =3D titem
-
-        tf.write("_lexstatere   =3D %s\n" % repr(tabre))
-        tf.write("_lexstateignore =3D %s\n" % repr(self.lexstateignore))
-
-        taberr =3D { }
-        for key, ef in self.lexstateerrorf.items():
-             if ef:
-                  taberr[key] =3D ef.__name__
-             else:
-                  taberr[key] =3D None
-        tf.write("_lexstateerrorf =3D %s\n" % repr(taberr))
-        tf.close()
-
-    # ------------------------------------------------------------
-    # readtab() - Read lexer information from a tab file
-    # ------------------------------------------------------------
-    def readtab(self,tabfile,fdict):
-        if isinstance(tabfile,types.ModuleType):
-            lextab =3D tabfile
-        else:
-            if sys.version_info[0] < 3:
-                exec("import %s as lextab" % tabfile)
-            else:
-                env =3D { }
-                exec("import %s as lextab" % tabfile, env,env)
-                lextab =3D env['lextab']
-
-        if getattr(lextab,"_tabversion","0.0") !=3D __version__:
-            raise ImportError("Inconsistent PLY version")
-
-        self.lextokens      =3D lextab._lextokens
-        self.lexreflags     =3D lextab._lexreflags
-        self.lexliterals    =3D lextab._lexliterals
-        self.lexstateinfo   =3D lextab._lexstateinfo
-        self.lexstateignore =3D lextab._lexstateignore
-        self.lexstatere     =3D { }
-        self.lexstateretext =3D { }
-        for key,lre in lextab._lexstatere.items():
-             titem =3D []
-             txtitem =3D []
-             for i in range(len(lre)):
-                  titem.append((re.compile(lre[i][0],lextab._lexreflags =
| re.VERBOSE),_names_to_funcs(lre[i][1],fdict)))
-                  txtitem.append(lre[i][0])
-             self.lexstatere[key] =3D titem
-             self.lexstateretext[key] =3D txtitem
-        self.lexstateerrorf =3D { }
-        for key,ef in lextab._lexstateerrorf.items():
-             self.lexstateerrorf[key] =3D fdict[ef]
-        self.begin('INITIAL')
-
     # ------------------------------------------------------------
     # input() - Push a new string into the lexer
     # ------------------------------------------------------------
-    def input(self,s):
-        # Pull off the first character to see if s looks like a string
-        c =3D s[:1]
-        if not isinstance(c,StringTypes):
-            raise ValueError("Expected a string")
+    def input(self, s):
         self.lexdata =3D s
         self.lexpos =3D 0
         self.lexlen =3D len(s)
@@ -260,19 +157,20 @@ class Lexer:
     # ------------------------------------------------------------
     # begin() - Changes the lexing state
     # ------------------------------------------------------------
-    def begin(self,state):
-        if not state in self.lexstatere:
-            raise ValueError("Undefined state")
+    def begin(self, state):
+        if state not in self.lexstatere:
+            raise ValueError(f'Undefined state {state!r}')
         self.lexre =3D self.lexstatere[state]
         self.lexretext =3D self.lexstateretext[state]
-        self.lexignore =3D self.lexstateignore.get(state,"")
-        self.lexerrorf =3D self.lexstateerrorf.get(state,None)
+        self.lexignore =3D self.lexstateignore.get(state, '')
+        self.lexerrorf =3D self.lexstateerrorf.get(state, None)
+        self.lexeoff =3D self.lexstateeoff.get(state, None)
         self.lexstate =3D state
=20
     # ------------------------------------------------------------
     # push_state() - Changes the lexing state and saves old on stack
     # ------------------------------------------------------------
-    def push_state(self,state):
+    def push_state(self, state):
         self.lexstatestack.append(self.lexstate)
         self.begin(state)
=20
@@ -291,11 +189,11 @@ class Lexer:
     # ------------------------------------------------------------
     # skip() - Skip ahead n characters
     # ------------------------------------------------------------
-    def skip(self,n):
+    def skip(self, n):
         self.lexpos +=3D n
=20
     # ------------------------------------------------------------
-    # opttoken() - Return the next token from the Lexer
+    # token() - Return the next token from the Lexer
     #
     # Note: This function has been carefully implemented to be as fast
     # as possible.  Don't make changes unless you really know what
@@ -315,9 +213,10 @@ class Lexer:
                 continue
=20
             # Look for a regular expression match
-            for lexre,lexindexfunc in self.lexre:
-                m =3D lexre.match(lexdata,lexpos)
-                if not m: continue
+            for lexre, lexindexfunc in self.lexre:
+                m =3D lexre.match(lexdata, lexpos)
+                if not m:
+                    continue
=20
                 # Create a token for return
                 tok =3D LexToken()
@@ -326,16 +225,16 @@ class Lexer:
                 tok.lexpos =3D lexpos
=20
                 i =3D m.lastindex
-                func,tok.type =3D lexindexfunc[i]
+                func, tok.type =3D lexindexfunc[i]
=20
                 if not func:
-                   # If no token type was set, it's an ignored token
-                   if tok.type:
-                      self.lexpos =3D m.end()
-                      return tok
-                   else:
-                      lexpos =3D m.end()
-                      break
+                    # If no token type was set, it's an ignored token
+                    if tok.type:
+                        self.lexpos =3D m.end()
+                        return tok
+                    else:
+                        lexpos =3D m.end()
+                        break
=20
                 lexpos =3D m.end()
=20
@@ -344,22 +243,15 @@ class Lexer:
                 tok.lexer =3D self      # Set additional attributes usef=
ul in token rules
                 self.lexmatch =3D m
                 self.lexpos =3D lexpos
-
                 newtok =3D func(tok)
+                del tok.lexer
+                del self.lexmatch
=20
                 # Every function must return a token, if nothing, we jus=
t move to next token
                 if not newtok:
                     lexpos    =3D self.lexpos         # This is here in =
case user has updated lexpos.
                     lexignore =3D self.lexignore      # This is here in =
case there was a state change
                     break
-
-                # Verify type of the token.  If not in the token map, ra=
ise an error
-                if not self.lexoptimize:
-                    if not newtok.type in self.lextokens:
-                        raise LexError("%s:%d: Rule '%s' returned an unk=
nown token type '%s'" % (
-                            func_code(func).co_filename, func_code(func)=
.co_firstlineno,
-                            func.__name__, newtok.type),lexdata[lexpos:]=
)
-
                 return newtok
             else:
                 # No match, see if in literals
@@ -377,38 +269,50 @@ class Lexer:
                     tok =3D LexToken()
                     tok.value =3D self.lexdata[lexpos:]
                     tok.lineno =3D self.lineno
-                    tok.type =3D "error"
+                    tok.type =3D 'error'
                     tok.lexer =3D self
                     tok.lexpos =3D lexpos
                     self.lexpos =3D lexpos
                     newtok =3D self.lexerrorf(tok)
                     if lexpos =3D=3D self.lexpos:
                         # Error method didn't change text position at al=
l. This is an error.
-                        raise LexError("Scanning error. Illegal characte=
r '%s'" % (lexdata[lexpos]), lexdata[lexpos:])
+                        raise LexError(f"Scanning error. Illegal charact=
er {lexdata[lexpos]!r}",
+                                       lexdata[lexpos:])
                     lexpos =3D self.lexpos
-                    if not newtok: continue
+                    if not newtok:
+                        continue
                     return newtok
=20
                 self.lexpos =3D lexpos
-                raise LexError("Illegal character '%s' at index %d" % (l=
exdata[lexpos],lexpos), lexdata[lexpos:])
+                raise LexError(f"Illegal character {lexdata[lexpos]!r} a=
t index {lexpos}",
+                               lexdata[lexpos:])
+
+        if self.lexeoff:
+            tok =3D LexToken()
+            tok.type =3D 'eof'
+            tok.value =3D ''
+            tok.lineno =3D self.lineno
+            tok.lexpos =3D lexpos
+            tok.lexer =3D self
+            self.lexpos =3D lexpos
+            newtok =3D self.lexeoff(tok)
+            return newtok
=20
         self.lexpos =3D lexpos + 1
         if self.lexdata is None:
-             raise RuntimeError("No input string given with input()")
+            raise RuntimeError('No input string given with input()')
         return None
=20
     # Iterator interface
     def __iter__(self):
         return self
=20
-    def next(self):
+    def __next__(self):
         t =3D self.token()
         if t is None:
             raise StopIteration
         return t
=20
-    __next__ =3D next
-
 # ----------------------------------------------------------------------=
-------
 #                           =3D=3D=3D=3D Lex Builder =3D=3D=3D
 #
@@ -416,6 +320,15 @@ class Lexer:
 # and build a Lexer object from it.
 # ----------------------------------------------------------------------=
-------
=20
+# ----------------------------------------------------------------------=
-------
+# _get_regex(func)
+#
+# Returns the regular expression assigned to a function either as a doc =
string
+# or as a .regex attribute attached by the @TOKEN decorator.
+# ----------------------------------------------------------------------=
-------
+def _get_regex(func):
+    return getattr(func, 'regex', func.__doc__)
+
 # ----------------------------------------------------------------------=
-------
 # get_caller_module_dict()
 #
@@ -423,53 +336,9 @@ class Lexer:
 # a caller further down the call stack.  This is used to get the environ=
ment
 # associated with the yacc() call if none was provided.
 # ----------------------------------------------------------------------=
-------
-
 def get_caller_module_dict(levels):
-    try:
-        raise RuntimeError
-    except RuntimeError:
-        e,b,t =3D sys.exc_info()
-        f =3D t.tb_frame
-        while levels > 0:
-            f =3D f.f_back                  =20
-            levels -=3D 1
-        ldict =3D f.f_globals.copy()
-        if f.f_globals !=3D f.f_locals:
-            ldict.update(f.f_locals)
-
-        return ldict
-
-# ----------------------------------------------------------------------=
-------
-# _funcs_to_names()
-#
-# Given a list of regular expression functions, this converts it to a li=
st
-# suitable for output to a table file
-# ----------------------------------------------------------------------=
-------
-
-def _funcs_to_names(funclist,namelist):
-    result =3D []
-    for f,name in zip(funclist,namelist):
-         if f and f[0]:
-             result.append((name, f[1]))
-         else:
-             result.append(f)
-    return result
-
-# ----------------------------------------------------------------------=
-------
-# _names_to_funcs()
-#
-# Given a list of regular expression function names, this converts it ba=
ck to
-# functions.
-# ----------------------------------------------------------------------=
-------
-
-def _names_to_funcs(namelist,fdict):
-     result =3D []
-     for n in namelist:
-          if n and n[0]:
-              result.append((fdict[n[0]],n[1]))
-          else:
-              result.append(n)
-     return result
+    f =3D sys._getframe(levels)
+    return { **f.f_globals, **f.f_locals }
=20
 # ----------------------------------------------------------------------=
-------
 # _form_master_re()
@@ -478,36 +347,35 @@ def _names_to_funcs(namelist,fdict):
 # form the master regular expression.  Given limitations in the Python r=
e
 # module, it may be necessary to break the master regex into separate ex=
pressions.
 # ----------------------------------------------------------------------=
-------
-
-def _form_master_re(relist,reflags,ldict,toknames):
-    if not relist: return []
-    regex =3D "|".join(relist)
+def _form_master_re(relist, reflags, ldict, toknames):
+    if not relist:
+        return [], [], []
+    regex =3D '|'.join(relist)
     try:
-        lexre =3D re.compile(regex,re.VERBOSE | reflags)
+        lexre =3D re.compile(regex, reflags)
=20
         # Build the index to function map for the matching engine
-        lexindexfunc =3D [ None ] * (max(lexre.groupindex.values())+1)
+        lexindexfunc =3D [None] * (max(lexre.groupindex.values()) + 1)
         lexindexnames =3D lexindexfunc[:]
=20
-        for f,i in lexre.groupindex.items():
-            handle =3D ldict.get(f,None)
+        for f, i in lexre.groupindex.items():
+            handle =3D ldict.get(f, None)
             if type(handle) in (types.FunctionType, types.MethodType):
-                lexindexfunc[i] =3D (handle,toknames[f])
+                lexindexfunc[i] =3D (handle, toknames[f])
                 lexindexnames[i] =3D f
             elif handle is not None:
                 lexindexnames[i] =3D f
-                if f.find("ignore_") > 0:
-                    lexindexfunc[i] =3D (None,None)
+                if f.find('ignore_') > 0:
+                    lexindexfunc[i] =3D (None, None)
                 else:
                     lexindexfunc[i] =3D (None, toknames[f])
-       =20
-        return [(lexre,lexindexfunc)],[regex],[lexindexnames]
+
+        return [(lexre, lexindexfunc)], [regex], [lexindexnames]
     except Exception:
-        m =3D int(len(relist)/2)
-        if m =3D=3D 0: m =3D 1
-        llist, lre, lnames =3D _form_master_re(relist[:m],reflags,ldict,=
toknames)
-        rlist, rre, rnames =3D _form_master_re(relist[m:],reflags,ldict,=
toknames)
-        return llist+rlist, lre+rre, lnames+rnames
+        m =3D (len(relist) // 2) + 1
+        llist, lre, lnames =3D _form_master_re(relist[:m], reflags, ldic=
t, toknames)
+        rlist, rre, rnames =3D _form_master_re(relist[m:], reflags, ldic=
t, toknames)
+        return (llist+rlist), (lre+rre), (lnames+rnames)
=20
 # ----------------------------------------------------------------------=
-------
 # def _statetoken(s,names)
@@ -517,22 +385,22 @@ def _form_master_re(relist,reflags,ldict,toknames):
 # is a tuple of state names and tokenname is the name of the token.  For=
 example,
 # calling this with s =3D "t_foo_bar_SPAM" might return (('foo','bar'),'=
SPAM')
 # ----------------------------------------------------------------------=
-------
+def _statetoken(s, names):
+    parts =3D s.split('_')
+    for i, part in enumerate(parts[1:], 1):
+        if part not in names and part !=3D 'ANY':
+            break
=20
-def _statetoken(s,names):
-    nonstate =3D 1
-    parts =3D s.split("_")
-    for i in range(1,len(parts)):
-         if not parts[i] in names and parts[i] !=3D 'ANY': break
     if i > 1:
-       states =3D tuple(parts[1:i])
+        states =3D tuple(parts[1:i])
     else:
-       states =3D ('INITIAL',)
+        states =3D ('INITIAL',)
=20
     if 'ANY' in states:
-       states =3D tuple(names)
+        states =3D tuple(names)
=20
-    tokenname =3D "_".join(parts[i:])
-    return (states,tokenname)
+    tokenname =3D '_'.join(parts[i:])
+    return (states, tokenname)
=20
=20
 # ----------------------------------------------------------------------=
-------
@@ -542,19 +410,15 @@ def _statetoken(s,names):
 # user's input file.
 # ----------------------------------------------------------------------=
-------
 class LexerReflect(object):
-    def __init__(self,ldict,log=3DNone,reflags=3D0):
+    def __init__(self, ldict, log=3DNone, reflags=3D0):
         self.ldict      =3D ldict
         self.error_func =3D None
         self.tokens     =3D []
         self.reflags    =3D reflags
-        self.stateinfo  =3D { 'INITIAL' : 'inclusive'}
-        self.files      =3D {}
-        self.error      =3D 0
-
-        if log is None:
-            self.log =3D PlyLogger(sys.stderr)
-        else:
-            self.log =3D log
+        self.stateinfo  =3D {'INITIAL': 'inclusive'}
+        self.modules    =3D set()
+        self.error      =3D False
+        self.log        =3D PlyLogger(sys.stderr) if log is None else lo=
g
=20
     # Get all of the basic information
     def get_all(self):
@@ -562,7 +426,7 @@ class LexerReflect(object):
         self.get_literals()
         self.get_states()
         self.get_rules()
-       =20
+
     # Validate all of the information
     def validate_all(self):
         self.validate_tokens()
@@ -572,20 +436,20 @@ class LexerReflect(object):
=20
     # Get the tokens map
     def get_tokens(self):
-        tokens =3D self.ldict.get("tokens",None)
+        tokens =3D self.ldict.get('tokens', None)
         if not tokens:
-            self.log.error("No token list is defined")
-            self.error =3D 1
+            self.log.error('No token list is defined')
+            self.error =3D True
             return
=20
-        if not isinstance(tokens,(list, tuple)):
-            self.log.error("tokens must be a list or tuple")
-            self.error =3D 1
+        if not isinstance(tokens, (list, tuple)):
+            self.log.error('tokens must be a list or tuple')
+            self.error =3D True
             return
-       =20
+
         if not tokens:
-            self.log.error("tokens is empty")
-            self.error =3D 1
+            self.log.error('tokens is empty')
+            self.error =3D True
             return
=20
         self.tokens =3D tokens
@@ -595,276 +459,270 @@ class LexerReflect(object):
         terminals =3D {}
         for n in self.tokens:
             if not _is_identifier.match(n):
-                self.log.error("Bad token name '%s'",n)
-                self.error =3D 1
+                self.log.error(f"Bad token name {n!r}")
+                self.error =3D True
             if n in terminals:
-                self.log.warning("Token '%s' multiply defined", n)
+                self.log.warning(f"Token {n!r} multiply defined")
             terminals[n] =3D 1
=20
     # Get the literals specifier
     def get_literals(self):
-        self.literals =3D self.ldict.get("literals","")
+        self.literals =3D self.ldict.get('literals', '')
+        if not self.literals:
+            self.literals =3D ''
=20
     # Validate literals
     def validate_literals(self):
         try:
             for c in self.literals:
-                if not isinstance(c,StringTypes) or len(c) > 1:
-                    self.log.error("Invalid literal %s. Must be a single=
 character", repr(c))
-                    self.error =3D 1
-                    continue
+                if not isinstance(c, StringTypes) or len(c) > 1:
+                    self.log.error(f'Invalid literal {c!r}. Must be a si=
ngle character')
+                    self.error =3D True
=20
         except TypeError:
-            self.log.error("Invalid literals specification. literals mus=
t be a sequence of characters")
-            self.error =3D 1
+            self.log.error('Invalid literals specification. literals mus=
t be a sequence of characters')
+            self.error =3D True
=20
     def get_states(self):
-        self.states =3D self.ldict.get("states",None)
+        self.states =3D self.ldict.get('states', None)
         # Build statemap
         if self.states:
-             if not isinstance(self.states,(tuple,list)):
-                  self.log.error("states must be defined as a tuple or l=
ist")
-                  self.error =3D 1
-             else:
-                  for s in self.states:
-                        if not isinstance(s,tuple) or len(s) !=3D 2:
-                               self.log.error("Invalid state specifier %=
s. Must be a tuple (statename,'exclusive|inclusive')",repr(s))
-                               self.error =3D 1
-                               continue
-                        name, statetype =3D s
-                        if not isinstance(name,StringTypes):
-                               self.log.error("State name %s must be a s=
tring", repr(name))
-                               self.error =3D 1
-                               continue
-                        if not (statetype =3D=3D 'inclusive' or statetyp=
e =3D=3D 'exclusive'):
-                               self.log.error("State type for state %s m=
ust be 'inclusive' or 'exclusive'",name)
-                               self.error =3D 1
-                               continue
-                        if name in self.stateinfo:
-                               self.log.error("State '%s' already define=
d",name)
-                               self.error =3D 1
-                               continue
-                        self.stateinfo[name] =3D statetype
+            if not isinstance(self.states, (tuple, list)):
+                self.log.error('states must be defined as a tuple or lis=
t')
+                self.error =3D True
+            else:
+                for s in self.states:
+                    if not isinstance(s, tuple) or len(s) !=3D 2:
+                        self.log.error("Invalid state specifier %r. Must=
 be a tuple (statename,'exclusive|inclusive')", s)
+                        self.error =3D True
+                        continue
+                    name, statetype =3D s
+                    if not isinstance(name, StringTypes):
+                        self.log.error('State name %r must be a string',=
 name)
+                        self.error =3D True
+                        continue
+                    if not (statetype =3D=3D 'inclusive' or statetype =3D=
=3D 'exclusive'):
+                        self.log.error("State type for state %r must be =
'inclusive' or 'exclusive'", name)
+                        self.error =3D True
+                        continue
+                    if name in self.stateinfo:
+                        self.log.error("State %r already defined", name)
+                        self.error =3D True
+                        continue
+                    self.stateinfo[name] =3D statetype
=20
     # Get all of the symbols with a t_ prefix and sort them into various
     # categories (functions, strings, error functions, and ignore charac=
ters)
=20
     def get_rules(self):
-        tsymbols =3D [f for f in self.ldict if f[:2] =3D=3D 't_' ]
+        tsymbols =3D [f for f in self.ldict if f[:2] =3D=3D 't_']
=20
         # Now build up a list of functions and a list of strings
-
-        self.toknames =3D { }        # Mapping of symbols to token names
-        self.funcsym =3D  { }        # Symbols defined as functions
-        self.strsym =3D   { }        # Symbols defined as strings
-        self.ignore   =3D { }        # Ignore strings by state
-        self.errorf   =3D { }        # Error functions by state
+        self.toknames =3D {}        # Mapping of symbols to token names
+        self.funcsym  =3D {}        # Symbols defined as functions
+        self.strsym   =3D {}        # Symbols defined as strings
+        self.ignore   =3D {}        # Ignore strings by state
+        self.errorf   =3D {}        # Error functions by state
+        self.eoff     =3D {}        # EOF functions by state
=20
         for s in self.stateinfo:
-             self.funcsym[s] =3D []
-             self.strsym[s] =3D []
+            self.funcsym[s] =3D []
+            self.strsym[s] =3D []
=20
         if len(tsymbols) =3D=3D 0:
-            self.log.error("No rules of the form t_rulename are defined"=
)
-            self.error =3D 1
+            self.log.error('No rules of the form t_rulename are defined'=
)
+            self.error =3D True
             return
=20
         for f in tsymbols:
             t =3D self.ldict[f]
-            states, tokname =3D _statetoken(f,self.stateinfo)
+            states, tokname =3D _statetoken(f, self.stateinfo)
             self.toknames[f] =3D tokname
=20
-            if hasattr(t,"__call__"):
+            if hasattr(t, '__call__'):
                 if tokname =3D=3D 'error':
                     for s in states:
                         self.errorf[s] =3D t
+                elif tokname =3D=3D 'eof':
+                    for s in states:
+                        self.eoff[s] =3D t
                 elif tokname =3D=3D 'ignore':
-                    line =3D func_code(t).co_firstlineno
-                    file =3D func_code(t).co_filename
-                    self.log.error("%s:%d: Rule '%s' must be defined as =
a string",file,line,t.__name__)
-                    self.error =3D 1
+                    line =3D t.__code__.co_firstlineno
+                    file =3D t.__code__.co_filename
+                    self.log.error("%s:%d: Rule %r must be defined as a =
string", file, line, t.__name__)
+                    self.error =3D True
                 else:
-                    for s in states:=20
-                        self.funcsym[s].append((f,t))
+                    for s in states:
+                        self.funcsym[s].append((f, t))
             elif isinstance(t, StringTypes):
                 if tokname =3D=3D 'ignore':
                     for s in states:
                         self.ignore[s] =3D t
-                    if "\\" in t:
-                        self.log.warning("%s contains a literal backslas=
h '\\'",f)
+                    if '\\' in t:
+                        self.log.warning("%s contains a literal backslas=
h '\\'", f)
=20
                 elif tokname =3D=3D 'error':
-                    self.log.error("Rule '%s' must be defined as a funct=
ion", f)
-                    self.error =3D 1
+                    self.log.error("Rule %r must be defined as a functio=
n", f)
+                    self.error =3D True
                 else:
-                    for s in states:=20
-                        self.strsym[s].append((f,t))
+                    for s in states:
+                        self.strsym[s].append((f, t))
             else:
-                self.log.error("%s not defined as a function or string",=
 f)
-                self.error =3D 1
+                self.log.error('%s not defined as a function or string',=
 f)
+                self.error =3D True
=20
         # Sort the functions by line number
         for f in self.funcsym.values():
-            f.sort(key=3Dlambda x: func_code(x[1]).co_firstlineno)
+            f.sort(key=3Dlambda x: x[1].__code__.co_firstlineno)
=20
         # Sort the strings by regular expression length
         for s in self.strsym.values():
-            if sys.version_info[0] < 3:
-                s.sort(lambda x,y: (len(x[1]) < len(y[1])) - (len(x[1]) =
> len(y[1])))
-            else:
-                # Python 3.0
-                s.sort(key=3Dlambda x: len(x[1]),reverse=3DTrue)
+            s.sort(key=3Dlambda x: len(x[1]), reverse=3DTrue)
=20
-    # Validate all of the t_rules collected=20
+    # Validate all of the t_rules collected
     def validate_rules(self):
         for state in self.stateinfo:
             # Validate all rules defined by functions
=20
-           =20
-
             for fname, f in self.funcsym[state]:
-                line =3D func_code(f).co_firstlineno
-                file =3D func_code(f).co_filename
-                self.files[file] =3D 1
+                line =3D f.__code__.co_firstlineno
+                file =3D f.__code__.co_filename
+                module =3D inspect.getmodule(f)
+                self.modules.add(module)
=20
                 tokname =3D self.toknames[fname]
                 if isinstance(f, types.MethodType):
                     reqargs =3D 2
                 else:
                     reqargs =3D 1
-                nargs =3D func_code(f).co_argcount
+                nargs =3D f.__code__.co_argcount
                 if nargs > reqargs:
-                    self.log.error("%s:%d: Rule '%s' has too many argume=
nts",file,line,f.__name__)
-                    self.error =3D 1
+                    self.log.error("%s:%d: Rule %r has too many argument=
s", file, line, f.__name__)
+                    self.error =3D True
                     continue
=20
                 if nargs < reqargs:
-                    self.log.error("%s:%d: Rule '%s' requires an argumen=
t", file,line,f.__name__)
-                    self.error =3D 1
+                    self.log.error("%s:%d: Rule %r requires an argument"=
, file, line, f.__name__)
+                    self.error =3D True
                     continue
=20
-                if not f.__doc__:
-                    self.log.error("%s:%d: No regular expression defined=
 for rule '%s'",file,line,f.__name__)
-                    self.error =3D 1
+                if not _get_regex(f):
+                    self.log.error("%s:%d: No regular expression defined=
 for rule %r", file, line, f.__name__)
+                    self.error =3D True
                     continue
=20
                 try:
-                    c =3D re.compile("(?P<%s>%s)" % (fname,f.__doc__), r=
e.VERBOSE | self.reflags)
-                    if c.match(""):
-                        self.log.error("%s:%d: Regular expression for ru=
le '%s' matches empty string", file,line,f.__name__)
-                        self.error =3D 1
-                except re.error:
-                    _etype, e, _etrace =3D sys.exc_info()
-                    self.log.error("%s:%d: Invalid regular expression fo=
r rule '%s'. %s", file,line,f.__name__,e)
-                    if '#' in f.__doc__:
-                        self.log.error("%s:%d. Make sure '#' in rule '%s=
' is escaped with '\\#'",file,line, f.__name__)
-                    self.error =3D 1
+                    c =3D re.compile('(?P<%s>%s)' % (fname, _get_regex(f=
)), self.reflags)
+                    if c.match(''):
+                        self.log.error("%s:%d: Regular expression for ru=
le %r matches empty string", file, line, f.__name__)
+                        self.error =3D True
+                except re.error as e:
+                    self.log.error("%s:%d: Invalid regular expression fo=
r rule '%s'. %s", file, line, f.__name__, e)
+                    if '#' in _get_regex(f):
+                        self.log.error("%s:%d. Make sure '#' in rule %r =
is escaped with '\\#'", file, line, f.__name__)
+                    self.error =3D True
=20
             # Validate all rules defined by strings
-            for name,r in self.strsym[state]:
+            for name, r in self.strsym[state]:
                 tokname =3D self.toknames[name]
                 if tokname =3D=3D 'error':
-                    self.log.error("Rule '%s' must be defined as a funct=
ion", name)
-                    self.error =3D 1
+                    self.log.error("Rule %r must be defined as a functio=
n", name)
+                    self.error =3D True
                     continue
=20
-                if not tokname in self.tokens and tokname.find("ignore_"=
) < 0:
-                    self.log.error("Rule '%s' defined for an unspecified=
 token %s",name,tokname)
-                    self.error =3D 1
+                if tokname not in self.tokens and tokname.find('ignore_'=
) < 0:
+                    self.log.error("Rule %r defined for an unspecified t=
oken %s", name, tokname)
+                    self.error =3D True
                     continue
=20
                 try:
-                    c =3D re.compile("(?P<%s>%s)" % (name,r),re.VERBOSE =
| self.reflags)
-                    if (c.match("")):
-                         self.log.error("Regular expression for rule '%s=
' matches empty string",name)
-                         self.error =3D 1
-                except re.error:
-                    _etype, e, _etrace =3D sys.exc_info()
-                    self.log.error("Invalid regular expression for rule =
'%s'. %s",name,e)
+                    c =3D re.compile('(?P<%s>%s)' % (name, r), self.refl=
ags)
+                    if (c.match('')):
+                        self.log.error("Regular expression for rule %r m=
atches empty string", name)
+                        self.error =3D True
+                except re.error as e:
+                    self.log.error("Invalid regular expression for rule =
%r. %s", name, e)
                     if '#' in r:
-                         self.log.error("Make sure '#' in rule '%s' is e=
scaped with '\\#'",name)
-                    self.error =3D 1
+                        self.log.error("Make sure '#' in rule %r is esca=
ped with '\\#'", name)
+                    self.error =3D True
=20
             if not self.funcsym[state] and not self.strsym[state]:
-                self.log.error("No rules defined for state '%s'",state)
-                self.error =3D 1
+                self.log.error("No rules defined for state %r", state)
+                self.error =3D True
=20
             # Validate the error function
-            efunc =3D self.errorf.get(state,None)
+            efunc =3D self.errorf.get(state, None)
             if efunc:
                 f =3D efunc
-                line =3D func_code(f).co_firstlineno
-                file =3D func_code(f).co_filename
-                self.files[file] =3D 1
+                line =3D f.__code__.co_firstlineno
+                file =3D f.__code__.co_filename
+                module =3D inspect.getmodule(f)
+                self.modules.add(module)
=20
                 if isinstance(f, types.MethodType):
                     reqargs =3D 2
                 else:
                     reqargs =3D 1
-                nargs =3D func_code(f).co_argcount
+                nargs =3D f.__code__.co_argcount
                 if nargs > reqargs:
-                    self.log.error("%s:%d: Rule '%s' has too many argume=
nts",file,line,f.__name__)
-                    self.error =3D 1
+                    self.log.error("%s:%d: Rule %r has too many argument=
s", file, line, f.__name__)
+                    self.error =3D True
=20
                 if nargs < reqargs:
-                    self.log.error("%s:%d: Rule '%s' requires an argumen=
t", file,line,f.__name__)
-                    self.error =3D 1
-
-        for f in self.files:
-            self.validate_file(f)
+                    self.log.error("%s:%d: Rule %r requires an argument"=
, file, line, f.__name__)
+                    self.error =3D True
=20
+        for module in self.modules:
+            self.validate_module(module)
=20
     # ------------------------------------------------------------------=
-----------
-    # validate_file()
+    # validate_module()
     #
     # This checks to see if there are duplicated t_rulename() functions =
or strings
     # in the parser input file.  This is done using a simple regular exp=
ression
-    # match on each line in the given file. =20
+    # match on each line in the source code of the given module.
     # ------------------------------------------------------------------=
-----------
=20
-    def validate_file(self,filename):
-        import os.path
-        base,ext =3D os.path.splitext(filename)
-        if ext !=3D '.py': return         # No idea what the file is. Re=
turn OK
-
+    def validate_module(self, module):
         try:
-            f =3D open(filename)
-            lines =3D f.readlines()
-            f.close()
+            lines, linen =3D inspect.getsourcelines(module)
         except IOError:
-            return                      # Couldn't find the file.  Don't=
 worry about it
+            return
=20
         fre =3D re.compile(r'\s*def\s+(t_[a-zA-Z_0-9]*)\(')
         sre =3D re.compile(r'\s*(t_[a-zA-Z_0-9]*)\s*=3D')
=20
-        counthash =3D { }
-        linen =3D 1
-        for l in lines:
-            m =3D fre.match(l)
+        counthash =3D {}
+        linen +=3D 1
+        for line in lines:
+            m =3D fre.match(line)
             if not m:
-                m =3D sre.match(l)
+                m =3D sre.match(line)
             if m:
                 name =3D m.group(1)
                 prev =3D counthash.get(name)
                 if not prev:
                     counthash[name] =3D linen
                 else:
-                    self.log.error("%s:%d: Rule %s redefined. Previously=
 defined on line %d",filename,linen,name,prev)
-                    self.error =3D 1
+                    filename =3D inspect.getsourcefile(module)
+                    self.log.error('%s:%d: Rule %s redefined. Previously=
 defined on line %d', filename, linen, name, prev)
+                    self.error =3D True
             linen +=3D 1
-           =20
+
 # ----------------------------------------------------------------------=
-------
 # lex(module)
 #
 # Build all of the regular expression rules from definitions in the supp=
lied module
 # ----------------------------------------------------------------------=
-------
-def lex(module=3DNone,object=3DNone,debug=3D0,optimize=3D0,lextab=3D"lex=
tab",reflags=3D0,nowarn=3D0,outputdir=3D"", debuglog=3DNone, errorlog=3DN=
one):
+def lex(*, module=3DNone, object=3DNone, debug=3DFalse,=20
+        reflags=3Dint(re.VERBOSE), debuglog=3DNone, errorlog=3DNone):
+
     global lexer
+
     ldict =3D None
-    stateinfo  =3D { 'INITIAL' : 'inclusive'}
+    stateinfo  =3D {'INITIAL': 'inclusive'}
     lexobj =3D Lexer()
-    lexobj.lexoptimize =3D optimize
-    global token,input
+    global token, input
=20
     if errorlog is None:
         errorlog =3D PlyLogger(sys.stderr)
@@ -874,131 +732,124 @@ def lex(module=3DNone,object=3DNone,debug=3D0,opt=
imize=3D0,lextab=3D"lextab",reflags=3D0,now
             debuglog =3D PlyLogger(sys.stderr)
=20
     # Get the module dictionary used for the lexer
-    if object: module =3D object
+    if object:
+        module =3D object
=20
+    # Get the module dictionary used for the parser
     if module:
-        _items =3D [(k,getattr(module,k)) for k in dir(module)]
+        _items =3D [(k, getattr(module, k)) for k in dir(module)]
         ldict =3D dict(_items)
+        # If no __file__ attribute is available, try to obtain it from t=
he __module__ instead
+        if '__file__' not in ldict:
+            ldict['__file__'] =3D sys.modules[ldict['__module__']].__fil=
e__
     else:
         ldict =3D get_caller_module_dict(2)
=20
     # Collect parser information from the dictionary
-    linfo =3D LexerReflect(ldict,log=3Derrorlog,reflags=3Dreflags)
+    linfo =3D LexerReflect(ldict, log=3Derrorlog, reflags=3Dreflags)
     linfo.get_all()
-    if not optimize:
-        if linfo.validate_all():
-            raise SyntaxError("Can't build lexer")
-
-    if optimize and lextab:
-        try:
-            lexobj.readtab(lextab,ldict)
-            token =3D lexobj.token
-            input =3D lexobj.input
-            lexer =3D lexobj
-            return lexobj
-
-        except ImportError:
-            pass
+    if linfo.validate_all():
+        raise SyntaxError("Can't build lexer")
=20
     # Dump some basic debugging information
     if debug:
-        debuglog.info("lex: tokens   =3D %r", linfo.tokens)
-        debuglog.info("lex: literals =3D %r", linfo.literals)
-        debuglog.info("lex: states   =3D %r", linfo.stateinfo)
+        debuglog.info('lex: tokens   =3D %r', linfo.tokens)
+        debuglog.info('lex: literals =3D %r', linfo.literals)
+        debuglog.info('lex: states   =3D %r', linfo.stateinfo)
=20
     # Build a dictionary of valid token names
-    lexobj.lextokens =3D { }
+    lexobj.lextokens =3D set()
     for n in linfo.tokens:
-        lexobj.lextokens[n] =3D 1
+        lexobj.lextokens.add(n)
=20
     # Get literals specification
-    if isinstance(linfo.literals,(list,tuple)):
+    if isinstance(linfo.literals, (list, tuple)):
         lexobj.lexliterals =3D type(linfo.literals[0])().join(linfo.lite=
rals)
     else:
         lexobj.lexliterals =3D linfo.literals
=20
+    lexobj.lextokens_all =3D lexobj.lextokens | set(lexobj.lexliterals)
+
     # Get the stateinfo dictionary
     stateinfo =3D linfo.stateinfo
=20
-    regexs =3D { }
+    regexs =3D {}
     # Build the master regular expressions
     for state in stateinfo:
         regex_list =3D []
=20
         # Add rules defined by functions first
         for fname, f in linfo.funcsym[state]:
-            line =3D func_code(f).co_firstlineno
-            file =3D func_code(f).co_filename
-            regex_list.append("(?P<%s>%s)" % (fname,f.__doc__))
+            regex_list.append('(?P<%s>%s)' % (fname, _get_regex(f)))
             if debug:
-                debuglog.info("lex: Adding rule %s -> '%s' (state '%s')"=
,fname,f.__doc__, state)
+                debuglog.info("lex: Adding rule %s -> '%s' (state '%s')"=
, fname, _get_regex(f), state)
=20
         # Now add all of the simple rules
-        for name,r in linfo.strsym[state]:
-            regex_list.append("(?P<%s>%s)" % (name,r))
+        for name, r in linfo.strsym[state]:
+            regex_list.append('(?P<%s>%s)' % (name, r))
             if debug:
-                debuglog.info("lex: Adding rule %s -> '%s' (state '%s')"=
,name,r, state)
+                debuglog.info("lex: Adding rule %s -> '%s' (state '%s')"=
, name, r, state)
=20
         regexs[state] =3D regex_list
=20
     # Build the master regular expressions
=20
     if debug:
-        debuglog.info("lex: =3D=3D=3D=3D MASTER REGEXS FOLLOW =3D=3D=3D=3D=
")
+        debuglog.info('lex: =3D=3D=3D=3D MASTER REGEXS FOLLOW =3D=3D=3D=3D=
')
=20
     for state in regexs:
-        lexre, re_text, re_names =3D _form_master_re(regexs[state],refla=
gs,ldict,linfo.toknames)
+        lexre, re_text, re_names =3D _form_master_re(regexs[state], refl=
ags, ldict, linfo.toknames)
         lexobj.lexstatere[state] =3D lexre
         lexobj.lexstateretext[state] =3D re_text
         lexobj.lexstaterenames[state] =3D re_names
         if debug:
-            for i in range(len(re_text)):
-                debuglog.info("lex: state '%s' : regex[%d] =3D '%s'",sta=
te, i, re_text[i])
+            for i, text in enumerate(re_text):
+                debuglog.info("lex: state '%s' : regex[%d] =3D '%s'", st=
ate, i, text)
=20
     # For inclusive states, we need to add the regular expressions from =
the INITIAL state
-    for state,stype in stateinfo.items():
-        if state !=3D "INITIAL" and stype =3D=3D 'inclusive':
-             lexobj.lexstatere[state].extend(lexobj.lexstatere['INITIAL'=
])
-             lexobj.lexstateretext[state].extend(lexobj.lexstateretext['=
INITIAL'])
-             lexobj.lexstaterenames[state].extend(lexobj.lexstaterenames=
['INITIAL'])
+    for state, stype in stateinfo.items():
+        if state !=3D 'INITIAL' and stype =3D=3D 'inclusive':
+            lexobj.lexstatere[state].extend(lexobj.lexstatere['INITIAL']=
)
+            lexobj.lexstateretext[state].extend(lexobj.lexstateretext['I=
NITIAL'])
+            lexobj.lexstaterenames[state].extend(lexobj.lexstaterenames[=
'INITIAL'])
=20
     lexobj.lexstateinfo =3D stateinfo
-    lexobj.lexre =3D lexobj.lexstatere["INITIAL"]
-    lexobj.lexretext =3D lexobj.lexstateretext["INITIAL"]
+    lexobj.lexre =3D lexobj.lexstatere['INITIAL']
+    lexobj.lexretext =3D lexobj.lexstateretext['INITIAL']
     lexobj.lexreflags =3D reflags
=20
     # Set up ignore variables
     lexobj.lexstateignore =3D linfo.ignore
-    lexobj.lexignore =3D lexobj.lexstateignore.get("INITIAL","")
+    lexobj.lexignore =3D lexobj.lexstateignore.get('INITIAL', '')
=20
     # Set up error functions
     lexobj.lexstateerrorf =3D linfo.errorf
-    lexobj.lexerrorf =3D linfo.errorf.get("INITIAL",None)
+    lexobj.lexerrorf =3D linfo.errorf.get('INITIAL', None)
     if not lexobj.lexerrorf:
-        errorlog.warning("No t_error rule is defined")
+        errorlog.warning('No t_error rule is defined')
+
+    # Set up eof functions
+    lexobj.lexstateeoff =3D linfo.eoff
+    lexobj.lexeoff =3D linfo.eoff.get('INITIAL', None)
=20
     # Check state information for ignore and error rules
-    for s,stype in stateinfo.items():
+    for s, stype in stateinfo.items():
         if stype =3D=3D 'exclusive':
-              if not s in linfo.errorf:
-                   errorlog.warning("No error rule is defined for exclus=
ive state '%s'", s)
-              if not s in linfo.ignore and lexobj.lexignore:
-                   errorlog.warning("No ignore rule is defined for exclu=
sive state '%s'", s)
+            if s not in linfo.errorf:
+                errorlog.warning("No error rule is defined for exclusive=
 state %r", s)
+            if s not in linfo.ignore and lexobj.lexignore:
+                errorlog.warning("No ignore rule is defined for exclusiv=
e state %r", s)
         elif stype =3D=3D 'inclusive':
-              if not s in linfo.errorf:
-                   linfo.errorf[s] =3D linfo.errorf.get("INITIAL",None)
-              if not s in linfo.ignore:
-                   linfo.ignore[s] =3D linfo.ignore.get("INITIAL","")
+            if s not in linfo.errorf:
+                linfo.errorf[s] =3D linfo.errorf.get('INITIAL', None)
+            if s not in linfo.ignore:
+                linfo.ignore[s] =3D linfo.ignore.get('INITIAL', '')
=20
     # Create global versions of the token() and input() functions
     token =3D lexobj.token
     input =3D lexobj.input
     lexer =3D lexobj
=20
-    # If in optimize mode, we write the lextab
-    if lextab and optimize:
-        lexobj.writetab(lextab,outputdir)
-
     return lexobj
=20
 # ----------------------------------------------------------------------=
-------
@@ -1007,15 +858,14 @@ def lex(module=3DNone,object=3DNone,debug=3D0,opti=
mize=3D0,lextab=3D"lextab",reflags=3D0,now
 # This runs the lexer as a main program
 # ----------------------------------------------------------------------=
-------
=20
-def runmain(lexer=3DNone,data=3DNone):
+def runmain(lexer=3DNone, data=3DNone):
     if not data:
         try:
             filename =3D sys.argv[1]
-            f =3D open(filename)
-            data =3D f.read()
-            f.close()
+            with open(filename) as f:
+                data =3D f.read()
         except IndexError:
-            sys.stdout.write("Reading from standard input (type EOF to e=
nd):\n")
+            sys.stdout.write('Reading from standard input (type EOF to e=
nd):\n')
             data =3D sys.stdin.read()
=20
     if lexer:
@@ -1028,10 +878,11 @@ def runmain(lexer=3DNone,data=3DNone):
     else:
         _token =3D token
=20
-    while 1:
+    while True:
         tok =3D _token()
-        if not tok: break
-        sys.stdout.write("(%s,%r,%d,%d)\n" % (tok.type, tok.value, tok.l=
ineno,tok.lexpos))
+        if not tok:
+            break
+        sys.stdout.write(f'({tok.type},{tok.value!r},{tok.lineno},{tok.l=
expos})\n')
=20
 # ----------------------------------------------------------------------=
-------
 # @TOKEN(regex)
@@ -1041,14 +892,10 @@ def runmain(lexer=3DNone,data=3DNone):
 # ----------------------------------------------------------------------=
-------
=20
 def TOKEN(r):
-    def set_doc(f):
-        if hasattr(r,"__call__"):
-            f.__doc__ =3D r.__doc__
+    def set_regex(f):
+        if hasattr(r, '__call__'):
+            f.regex =3D _get_regex(r)
         else:
-            f.__doc__ =3D r
+            f.regex =3D r
         return f
-    return set_doc
-
-# Alternative spelling of the TOKEN decorator
-Token =3D TOKEN
-
+    return set_regex
diff --git a/lib/bb/_vendor/ply/yacc.py b/lib/bb/_vendor/ply/yacc.py
index 0cd9b522b..03bd86ee0 100644
--- a/lib/bb/_vendor/ply/yacc.py
+++ b/lib/bb/_vendor/ply/yacc.py
@@ -1,22 +1,22 @@
 # ----------------------------------------------------------------------=
-------
 # ply: yacc.py
 #
-# Copyright (C) 2001-2009,
+# Copyright (C) 2001-2017
 # David M. Beazley (Dabeaz LLC)
 # All rights reserved.
 #
 # Redistribution and use in source and binary forms, with or without
 # modification, are permitted provided that the following conditions are
 # met:
-#=20
+#
 # * Redistributions of source code must retain the above copyright notic=
e,
-#   this list of conditions and the following disclaimer. =20
-# * Redistributions in binary form must reproduce the above copyright no=
tice,=20
+#   this list of conditions and the following disclaimer.
+# * Redistributions in binary form must reproduce the above copyright no=
tice,
 #   this list of conditions and the following disclaimer in the document=
ation
-#   and/or other materials provided with the distribution. =20
+#   and/or other materials provided with the distribution.
 # * Neither the name of the David Beazley or Dabeaz LLC may be used to
 #   endorse or promote products derived from this software without
-#  specific prior written permission.=20
+#  specific prior written permission.
 #
 # THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 # "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
@@ -59,8 +59,16 @@
 # own risk!
 # ----------------------------------------------------------------------=
------
=20
-__version__    =3D "3.3"
-__tabversion__ =3D "3.2"       # Table version
+import re
+import types
+import sys
+import os.path
+import inspect
+import base64
+import warnings
+
+__version__    =3D '3.10'
+__tabversion__ =3D '3.10'
=20
 #-----------------------------------------------------------------------=
------
 #                     =3D=3D=3D User configurable parameters =3D=3D=3D
@@ -68,7 +76,7 @@ __tabversion__ =3D "3.2"       # Table version
 # Change these to modify the default behavior of yacc (if you wish)
 #-----------------------------------------------------------------------=
------
=20
-yaccdebug   =3D 0                # Debugging mode.  If set, yacc generat=
es a
+yaccdebug   =3D True             # Debugging mode.  If set, yacc generat=
es a
                                # a 'parser.out' file in the current dire=
ctory
=20
 debug_file  =3D 'parser.out'     # Default name of the debugging file
@@ -77,82 +85,117 @@ default_lr  =3D 'LALR'           # Default LR table =
generation method
=20
 error_count =3D 3                # Number of symbols that must be shifte=
d to leave recovery mode
=20
-yaccdevel   =3D 0                # Set to True if developing yacc.  This=
 turns off optimized
+yaccdevel   =3D False            # Set to True if developing yacc.  This=
 turns off optimized
                                # implementations of certain functions.
=20
 resultlimit =3D 40               # Size limit of results when running in=
 debug mode.
=20
 pickle_protocol =3D 0            # Protocol to use when writing pickle f=
iles
=20
-import re, types, sys, os.path
-
-# Compatibility function for python 2.6/3.0
+# String type-checking compatibility
 if sys.version_info[0] < 3:
-    def func_code(f):
-        return f.func_code
+    string_types =3D basestring
 else:
-    def func_code(f):
-        return f.__code__
+    string_types =3D str
=20
-# Compatibility
-try:
-    MAXINT =3D sys.maxint
-except AttributeError:
-    MAXINT =3D sys.maxsize
+MAXINT =3D sys.maxsize
=20
-def load_ply_lex():
-    from . import lex
-    return lex
-
-# This object is a stand-in for a logging object created by the=20
+# This object is a stand-in for a logging object created by the
 # logging module.   PLY will use this by default to create things
 # such as the parser.out file.  If a user wants more detailed
 # information, they can create their own logging object and pass
 # it into PLY.
=20
 class PlyLogger(object):
-    def __init__(self,f):
+    def __init__(self, f):
         self.f =3D f
-    def debug(self,msg,*args,**kwargs):
-        self.f.write((msg % args) + "\n")
-    info     =3D debug
=20
-    def warning(self,msg,*args,**kwargs):
-        self.f.write("WARNING: "+ (msg % args) + "\n")
+    def debug(self, msg, *args, **kwargs):
+        self.f.write((msg % args) + '\n')
+
+    info =3D debug
+
+    def warning(self, msg, *args, **kwargs):
+        self.f.write('WARNING: ' + (msg % args) + '\n')
=20
-    def error(self,msg,*args,**kwargs):
-        self.f.write("ERROR: " + (msg % args) + "\n")
+    def error(self, msg, *args, **kwargs):
+        self.f.write('ERROR: ' + (msg % args) + '\n')
=20
     critical =3D debug
=20
 # Null logger is used when no output is generated. Does nothing.
 class NullLogger(object):
-    def __getattribute__(self,name):
+    def __getattribute__(self, name):
         return self
-    def __call__(self,*args,**kwargs):
+
+    def __call__(self, *args, **kwargs):
         return self
-       =20
+
 # Exception raised for yacc-related errors
-class YaccError(Exception):   pass
+class YaccError(Exception):
+    pass
=20
 # Format the result message that the parser produces when running in deb=
ug mode.
 def format_result(r):
     repr_str =3D repr(r)
-    if '\n' in repr_str: repr_str =3D repr(repr_str)
+    if '\n' in repr_str:
+        repr_str =3D repr(repr_str)
     if len(repr_str) > resultlimit:
-        repr_str =3D repr_str[:resultlimit]+" ..."
-    result =3D "<%s @ 0x%x> (%s)" % (type(r).__name__,id(r),repr_str)
+        repr_str =3D repr_str[:resultlimit] + ' ...'
+    result =3D '<%s @ 0x%x> (%s)' % (type(r).__name__, id(r), repr_str)
     return result
=20
-
 # Format stack entries when the parser is running in debug mode
 def format_stack_entry(r):
     repr_str =3D repr(r)
-    if '\n' in repr_str: repr_str =3D repr(repr_str)
+    if '\n' in repr_str:
+        repr_str =3D repr(repr_str)
     if len(repr_str) < 16:
         return repr_str
     else:
-        return "<%s @ 0x%x>" % (type(r).__name__,id(r))
+        return '<%s @ 0x%x>' % (type(r).__name__, id(r))
+
+# Panic mode error recovery support.   This feature is being reworked--m=
uch of the
+# code here is to offer a deprecation/backwards compatible transition
+
+_errok =3D None
+_token =3D None
+_restart =3D None
+_warnmsg =3D '''PLY: Don't use global functions errok(), token(), and re=
start() in p_error().
+Instead, invoke the methods on the associated parser instance:
+
+    def p_error(p):
+        ...
+        # Use parser.errok(), parser.token(), parser.restart()
+        ...
+
+    parser =3D yacc.yacc()
+'''
+
+def errok():
+    warnings.warn(_warnmsg)
+    return _errok()
+
+def restart():
+    warnings.warn(_warnmsg)
+    return _restart()
+
+def token():
+    warnings.warn(_warnmsg)
+    return _token()
+
+# Utility function to call the p_error() function with some deprecation =
hacks
+def call_errorfunc(errorfunc, token, parser):
+    global _errok, _token, _restart
+    _errok =3D parser.errok
+    _token =3D parser.token
+    _restart =3D parser.restart
+    r =3D errorfunc(token)
+    try:
+        del _errok, _token, _restart
+    except NameError:
+        pass
+    return r
=20
 #-----------------------------------------------------------------------=
------
 #                        =3D=3D=3D  LR Parsing Engine =3D=3D=3D
@@ -172,8 +215,11 @@ def format_stack_entry(r):
 #        .endlexpos  =3D Ending lex position (optional, set automaticall=
y)
=20
 class YaccSymbol:
-    def __str__(self):    return self.type
-    def __repr__(self):   return str(self)
+    def __str__(self):
+        return self.type
+
+    def __repr__(self):
+        return str(self)
=20
 # This class is a wrapper around the objects actually passed to each
 # grammar rule.   Index lookup and assignment actually assign the
@@ -185,48 +231,50 @@ class YaccSymbol:
 # representing the range of positional information for a symbol.
=20
 class YaccProduction:
-    def __init__(self,s,stack=3DNone):
+    def __init__(self, s, stack=3DNone):
         self.slice =3D s
         self.stack =3D stack
         self.lexer =3D None
-        self.parser=3D None
-    def __getitem__(self,n):
-        if isinstance(n,slice):
-            return [self[i] for i in range(*(n.indices(len(self.slice)))=
)]
-        if n >=3D 0: return self.slice[n].value
-        else: return self.stack[n].value
-
-    def __setitem__(self,n,v):
+        self.parser =3D None
+
+    def __getitem__(self, n):
+        if isinstance(n, slice):
+            return [s.value for s in self.slice[n]]
+        elif n >=3D 0:
+            return self.slice[n].value
+        else:
+            return self.stack[n].value
+
+    def __setitem__(self, n, v):
         self.slice[n].value =3D v
=20
-    def __getslice__(self,i,j):
+    def __getslice__(self, i, j):
         return [s.value for s in self.slice[i:j]]
=20
     def __len__(self):
         return len(self.slice)
=20
-    def lineno(self,n):
-        return getattr(self.slice[n],"lineno",0)
+    def lineno(self, n):
+        return getattr(self.slice[n], 'lineno', 0)
=20
-    def set_lineno(self,n,lineno):
+    def set_lineno(self, n, lineno):
         self.slice[n].lineno =3D lineno
=20
-    def linespan(self,n):
-        startline =3D getattr(self.slice[n],"lineno",0)
-        endline =3D getattr(self.slice[n],"endlineno",startline)
-        return startline,endline
+    def linespan(self, n):
+        startline =3D getattr(self.slice[n], 'lineno', 0)
+        endline =3D getattr(self.slice[n], 'endlineno', startline)
+        return startline, endline
=20
-    def lexpos(self,n):
-        return getattr(self.slice[n],"lexpos",0)
+    def lexpos(self, n):
+        return getattr(self.slice[n], 'lexpos', 0)
=20
-    def lexspan(self,n):
-        startpos =3D getattr(self.slice[n],"lexpos",0)
-        endpos =3D getattr(self.slice[n],"endlexpos",startpos)
-        return startpos,endpos
+    def lexspan(self, n):
+        startpos =3D getattr(self.slice[n], 'lexpos', 0)
+        endpos =3D getattr(self.slice[n], 'endlexpos', startpos)
+        return startpos, endpos
=20
     def error(self):
-       raise SyntaxError
-
+        raise SyntaxError
=20
 # ----------------------------------------------------------------------=
-------
 #                               =3D=3D LRParser =3D=3D
@@ -235,14 +283,16 @@ class YaccProduction:
 # ----------------------------------------------------------------------=
-------
=20
 class LRParser:
-    def __init__(self,lrtab,errorf):
+    def __init__(self, lrtab, errorf):
         self.productions =3D lrtab.lr_productions
-        self.action      =3D lrtab.lr_action
-        self.goto        =3D lrtab.lr_goto
-        self.errorfunc   =3D errorf
+        self.action =3D lrtab.lr_action
+        self.goto =3D lrtab.lr_goto
+        self.errorfunc =3D errorf
+        self.set_defaulted_states()
+        self.errorok =3D True
=20
     def errok(self):
-        self.errorok     =3D 1
+        self.errorok =3D True
=20
     def restart(self):
         del self.statestack[:]
@@ -252,24 +302,42 @@ class LRParser:
         self.symstack.append(sym)
         self.statestack.append(0)
=20
-    def parse(self,input=3DNone,lexer=3DNone,debug=3D0,tracking=3D0,toke=
nfunc=3DNone):
+    # Defaulted state support.
+    # This method identifies parser states where there is only one possi=
ble reduction action.
+    # For such states, the parser can make a choose to make a rule reduc=
tion without consuming
+    # the next look-ahead token.  This delayed invocation of the tokeniz=
er can be useful in
+    # certain kinds of advanced parsing situations where the lexer and p=
arser interact with
+    # each other or change states (i.e., manipulation of scope, lexer st=
ates, etc.).
+    #
+    # See:  http://www.gnu.org/software/bison/manual/html_node/Default-R=
eductions.html#Default-Reductions
+    def set_defaulted_states(self):
+        self.defaulted_states =3D {}
+        for state, actions in self.action.items():
+            rules =3D list(actions.values())
+            if len(rules) =3D=3D 1 and rules[0] < 0:
+                self.defaulted_states[state] =3D rules[0]
+
+    def disable_defaulted_states(self):
+        self.defaulted_states =3D {}
+
+    def parse(self, input=3DNone, lexer=3DNone, debug=3DFalse, tracking=3D=
False, tokenfunc=3DNone):
         if debug or yaccdevel:
-            if isinstance(debug,int):
+            if isinstance(debug, int):
                 debug =3D PlyLogger(sys.stderr)
-            return self.parsedebug(input,lexer,debug,tracking,tokenfunc)
+            return self.parsedebug(input, lexer, debug, tracking, tokenf=
unc)
         elif tracking:
-            return self.parseopt(input,lexer,debug,tracking,tokenfunc)
+            return self.parseopt(input, lexer, debug, tracking, tokenfun=
c)
         else:
-            return self.parseopt_notrack(input,lexer,debug,tracking,toke=
nfunc)
-       =20
+            return self.parseopt_notrack(input, lexer, debug, tracking, =
tokenfunc)
+
=20
     # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!!!!!!!!
     # parsedebug().
     #
     # This is the debugging enabled version of parse().  All changes mad=
e to the
-    # parsing engine should be made here.   For the non-debugging versio=
n,
-    # copy this code to a method parseopt() and delete all of the sectio=
ns
-    # enclosed in:
+    # parsing engine should be made here.   Optimized versions of this f=
unction
+    # are automatically created by the ply/ygen.py script.  This script =
cuts out
+    # sections enclosed in markers such as this:
     #
     #      #--! DEBUG
     #      statements
@@ -277,22 +345,24 @@ class LRParser:
     #
     # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!!!!!!!!
=20
-    def parsedebug(self,input=3DNone,lexer=3DNone,debug=3DNone,tracking=3D=
0,tokenfunc=3DNone):
-        lookahead =3D None                 # Current lookahead symbol
-        lookaheadstack =3D [ ]             # Stack of lookahead symbols
-        actions =3D self.action            # Local reference to action t=
able (to avoid lookup on self.)
-        goto    =3D self.goto              # Local reference to goto tab=
le (to avoid lookup on self.)
-        prod    =3D self.productions       # Local reference to producti=
on list (to avoid lookup on self.)
-        pslice  =3D YaccProduction(None)   # Production object passed to=
 grammar rules
-        errorcount =3D 0                   # Used during error recovery=20
-
-        # --! DEBUG
-        debug.info("PLY: PARSE DEBUG START")
-        # --! DEBUG
+    def parsedebug(self, input=3DNone, lexer=3DNone, debug=3DFalse, trac=
king=3DFalse, tokenfunc=3DNone):
+        #--! parsedebug-start
+        lookahead =3D None                         # Current lookahead s=
ymbol
+        lookaheadstack =3D []                      # Stack of lookahead =
symbols
+        actions =3D self.action                    # Local reference to =
action table (to avoid lookup on self.)
+        goto    =3D self.goto                      # Local reference to =
goto table (to avoid lookup on self.)
+        prod    =3D self.productions               # Local reference to =
production list (to avoid lookup on self.)
+        defaulted_states =3D self.defaulted_states # Local reference to =
defaulted states
+        pslice  =3D YaccProduction(None)           # Production object p=
assed to grammar rules
+        errorcount =3D 0                           # Used during error r=
ecovery
+
+        #--! DEBUG
+        debug.info('PLY: PARSE DEBUG START')
+        #--! DEBUG
=20
         # If no lexer was given, we will try to use the lex module
         if not lexer:
-            lex =3D load_ply_lex()
+            from . import lex
             lexer =3D lex.lexer
=20
         # Set up the lexer and parser objects on pslice
@@ -304,16 +374,19 @@ class LRParser:
             lexer.input(input)
=20
         if tokenfunc is None:
-           # Tokenize function
-           get_token =3D lexer.token
+            # Tokenize function
+            get_token =3D lexer.token
         else:
-           get_token =3D tokenfunc
+            get_token =3D tokenfunc
+
+        # Set the parser() token method (sometimes used in error recover=
y)
+        self.token =3D get_token
=20
         # Set up the state and symbol stacks
=20
-        statestack =3D [ ]                # Stack of parsing states
+        statestack =3D []                # Stack of parsing states
         self.statestack =3D statestack
-        symstack   =3D [ ]                # Stack of grammar symbols
+        symstack   =3D []                # Stack of grammar symbols
         self.symstack =3D symstack
=20
         pslice.stack =3D symstack         # Put in the production
@@ -323,52 +396,59 @@ class LRParser:
=20
         statestack.append(0)
         sym =3D YaccSymbol()
-        sym.type =3D "$end"
+        sym.type =3D '$end'
         symstack.append(sym)
         state =3D 0
-        while 1:
+        while True:
             # Get the next symbol on the input.  If a lookahead symbol
             # is already set, we just use that. Otherwise, we'll pull
             # the next token off of the lookaheadstack or from the lexer
=20
-            # --! DEBUG
+            #--! DEBUG
             debug.debug('')
             debug.debug('State  : %s', state)
-            # --! DEBUG
+            #--! DEBUG
=20
-            if not lookahead:
-                if not lookaheadstack:
-                    lookahead =3D get_token()     # Get the next token
-                else:
-                    lookahead =3D lookaheadstack.pop()
+            if state not in defaulted_states:
                 if not lookahead:
-                    lookahead =3D YaccSymbol()
-                    lookahead.type =3D "$end"
+                    if not lookaheadstack:
+                        lookahead =3D get_token()     # Get the next tok=
en
+                    else:
+                        lookahead =3D lookaheadstack.pop()
+                    if not lookahead:
+                        lookahead =3D YaccSymbol()
+                        lookahead.type =3D '$end'
+
+                # Check the action table
+                ltype =3D lookahead.type
+                t =3D actions[state].get(ltype)
+            else:
+                t =3D defaulted_states[state]
+                #--! DEBUG
+                debug.debug('Defaulted state %s: Reduce using %d', state=
, -t)
+                #--! DEBUG
=20
-            # --! DEBUG
+            #--! DEBUG
             debug.debug('Stack  : %s',
-                        ("%s . %s" % (" ".join([xx.type for xx in symsta=
ck][1:]), str(lookahead))).lstrip())
-            # --! DEBUG
-
-            # Check the action table
-            ltype =3D lookahead.type
-            t =3D actions[state].get(ltype)
+                        ('%s . %s' % (' '.join([xx.type for xx in symsta=
ck][1:]), str(lookahead))).lstrip())
+            #--! DEBUG
=20
             if t is not None:
                 if t > 0:
                     # shift a symbol on the stack
                     statestack.append(t)
                     state =3D t
-                   =20
-                    # --! DEBUG
-                    debug.debug("Action : Shift and goto state %s", t)
-                    # --! DEBUG
+
+                    #--! DEBUG
+                    debug.debug('Action : Shift and goto state %s', t)
+                    #--! DEBUG
=20
                     symstack.append(lookahead)
                     lookahead =3D None
=20
                     # Decrease error count on successful shift
-                    if errorcount: errorcount -=3D1
+                    if errorcount:
+                        errorcount -=3D 1
                     continue
=20
                 if t < 0:
@@ -382,72 +462,77 @@ class LRParser:
                     sym.type =3D pname       # Production name
                     sym.value =3D None
=20
-                    # --! DEBUG
+                    #--! DEBUG
                     if plen:
-                        debug.info("Action : Reduce rule [%s] with %s an=
d goto state %d", p.str, "["+",".join([format_stack_entry(_v.value) for _=
v in symstack[-plen:]])+"]",-t)
+                        debug.info('Action : Reduce rule [%s] with %s an=
d goto state %d', p.str,
+                                   '['+','.join([format_stack_entry(_v.v=
alue) for _v in symstack[-plen:]])+']',
+                                   goto[statestack[-1-plen]][pname])
                     else:
-                        debug.info("Action : Reduce rule [%s] with %s an=
d goto state %d", p.str, [],-t)
-                       =20
-                    # --! DEBUG
+                        debug.info('Action : Reduce rule [%s] with %s an=
d goto state %d', p.str, [],
+                                   goto[statestack[-1]][pname])
+
+                    #--! DEBUG
=20
                     if plen:
                         targ =3D symstack[-plen-1:]
                         targ[0] =3D sym
=20
-                        # --! TRACKING
+                        #--! TRACKING
                         if tracking:
-                           t1 =3D targ[1]
-                           sym.lineno =3D t1.lineno
-                           sym.lexpos =3D t1.lexpos
-                           t1 =3D targ[-1]
-                           sym.endlineno =3D getattr(t1,"endlineno",t1.l=
ineno)
-                           sym.endlexpos =3D getattr(t1,"endlexpos",t1.l=
expos)
-
-                        # --! TRACKING
+                            t1 =3D targ[1]
+                            sym.lineno =3D t1.lineno
+                            sym.lexpos =3D t1.lexpos
+                            t1 =3D targ[-1]
+                            sym.endlineno =3D getattr(t1, 'endlineno', t=
1.lineno)
+                            sym.endlexpos =3D getattr(t1, 'endlexpos', t=
1.lexpos)
+                        #--! TRACKING
=20
                         # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!
-                        # The code enclosed in this section is duplicate=
d=20
+                        # The code enclosed in this section is duplicate=
d
                         # below as a performance optimization.  Make sur=
e
                         # changes get made in both locations.
=20
                         pslice.slice =3D targ
-                       =20
+
                         try:
                             # Call the grammar rule with our special sli=
ce object
                             del symstack[-plen:]
-                            del statestack[-plen:]
+                            self.state =3D state
                             p.callable(pslice)
-                            # --! DEBUG
-                            debug.info("Result : %s", format_result(psli=
ce[0]))
-                            # --! DEBUG
+                            del statestack[-plen:]
+                            #--! DEBUG
+                            debug.info('Result : %s', format_result(psli=
ce[0]))
+                            #--! DEBUG
                             symstack.append(sym)
                             state =3D goto[statestack[-1]][pname]
                             statestack.append(state)
                         except SyntaxError:
                             # If an error was set. Enter error recovery =
state
-                            lookaheadstack.append(lookahead)
-                            symstack.pop()
-                            statestack.pop()
+                            lookaheadstack.append(lookahead)    # Save t=
he current lookahead token
+                            symstack.extend(targ[1:-1])         # Put th=
e production slice back on the stack
+                            statestack.pop()                    # Pop ba=
ck one state (before the reduce)
                             state =3D statestack[-1]
                             sym.type =3D 'error'
+                            sym.value =3D 'error'
                             lookahead =3D sym
                             errorcount =3D error_count
-                            self.errorok =3D 0
+                            self.errorok =3D False
+
                         continue
                         # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!
-   =20
+
                     else:
=20
-                        # --! TRACKING
+                        #--! TRACKING
                         if tracking:
-                           sym.lineno =3D lexer.lineno
-                           sym.lexpos =3D lexer.lexpos
-                        # --! TRACKING
+                            sym.lineno =3D lexer.lineno
+                            sym.lexpos =3D lexer.lexpos
+                        #--! TRACKING
=20
-                        targ =3D [ sym ]
+                        targ =3D [sym]
=20
                         # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!
-                        # The code enclosed in this section is duplicate=
d=20
+                        # The code enclosed in this section is duplicate=
d
                         # above as a performance optimization.  Make sur=
e
                         # changes get made in both locations.
=20
@@ -455,41 +540,43 @@ class LRParser:
=20
                         try:
                             # Call the grammar rule with our special sli=
ce object
+                            self.state =3D state
                             p.callable(pslice)
-                            # --! DEBUG
-                            debug.info("Result : %s", format_result(psli=
ce[0]))
-                            # --! DEBUG
+                            #--! DEBUG
+                            debug.info('Result : %s', format_result(psli=
ce[0]))
+                            #--! DEBUG
                             symstack.append(sym)
                             state =3D goto[statestack[-1]][pname]
                             statestack.append(state)
                         except SyntaxError:
                             # If an error was set. Enter error recovery =
state
-                            lookaheadstack.append(lookahead)
-                            symstack.pop()
-                            statestack.pop()
+                            lookaheadstack.append(lookahead)    # Save t=
he current lookahead token
+                            statestack.pop()                    # Pop ba=
ck one state (before the reduce)
                             state =3D statestack[-1]
                             sym.type =3D 'error'
+                            sym.value =3D 'error'
                             lookahead =3D sym
                             errorcount =3D error_count
-                            self.errorok =3D 0
+                            self.errorok =3D False
+
                         continue
                         # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!
=20
                 if t =3D=3D 0:
                     n =3D symstack[-1]
-                    result =3D getattr(n,"value",None)
-                    # --! DEBUG
-                    debug.info("Done   : Returning %s", format_result(re=
sult))
-                    debug.info("PLY: PARSE DEBUG END")
-                    # --! DEBUG
+                    result =3D getattr(n, 'value', None)
+                    #--! DEBUG
+                    debug.info('Done   : Returning %s', format_result(re=
sult))
+                    debug.info('PLY: PARSE DEBUG END')
+                    #--! DEBUG
                     return result
=20
             if t is None:
=20
-                # --! DEBUG
+                #--! DEBUG
                 debug.error('Error  : %s',
-                            ("%s . %s" % (" ".join([xx.type for xx in sy=
mstack][1:]), str(lookahead))).lstrip())
-                # --! DEBUG
+                            ('%s . %s' % (' '.join([xx.type for xx in sy=
mstack][1:]), str(lookahead))).lstrip())
+                #--! DEBUG
=20
                 # We have some kind of parsing error here.  To handle
                 # this, we are going to push the current token onto
@@ -503,20 +590,15 @@ class LRParser:
                 # errorcount =3D=3D 0.
                 if errorcount =3D=3D 0 or self.errorok:
                     errorcount =3D error_count
-                    self.errorok =3D 0
+                    self.errorok =3D False
                     errtoken =3D lookahead
-                    if errtoken.type =3D=3D "$end":
+                    if errtoken.type =3D=3D '$end':
                         errtoken =3D None               # End of file!
                     if self.errorfunc:
-                        global errok,token,restart
-                        errok =3D self.errok        # Set some special f=
unctions available in error recovery
-                        token =3D get_token
-                        restart =3D self.restart
-                        if errtoken and not hasattr(errtoken,'lexer'):
+                        if errtoken and not hasattr(errtoken, 'lexer'):
                             errtoken.lexer =3D lexer
-                        tok =3D self.errorfunc(errtoken)
-                        del errok, token, restart   # Delete special fun=
ctions
-
+                        self.state =3D state
+                        tok =3D call_errorfunc(self.errorfunc, errtoken,=
 self)
                         if self.errorok:
                             # User must have done some kind of panic
                             # mode recovery on their own.  The
@@ -526,14 +608,16 @@ class LRParser:
                             continue
                     else:
                         if errtoken:
-                            if hasattr(errtoken,"lineno"): lineno =3D lo=
okahead.lineno
-                            else: lineno =3D 0
+                            if hasattr(errtoken, 'lineno'):
+                                lineno =3D lookahead.lineno
+                            else:
+                                lineno =3D 0
                             if lineno:
-                                sys.stderr.write("yacc: Syntax error at =
line %d, token=3D%s\n" % (lineno, errtoken.type))
+                                sys.stderr.write('yacc: Syntax error at =
line %d, token=3D%s\n' % (lineno, errtoken.type))
                             else:
-                                sys.stderr.write("yacc: Syntax error, to=
ken=3D%s" % errtoken.type)
+                                sys.stderr.write('yacc: Syntax error, to=
ken=3D%s' % errtoken.type)
                         else:
-                            sys.stderr.write("yacc: Parse error in input=
. EOF\n")
+                            sys.stderr.write('yacc: Parse error in input=
. EOF\n')
                             return
=20
                 else:
@@ -543,7 +627,7 @@ class LRParser:
                 # entire parse has been rolled back and we're completely=
 hosed.   The token is
                 # discarded and we just keep going.
=20
-                if len(statestack) <=3D 1 and lookahead.type !=3D "$end"=
:
+                if len(statestack) <=3D 1 and lookahead.type !=3D '$end'=
:
                     lookahead =3D None
                     errtoken =3D None
                     state =3D 0
@@ -555,7 +639,7 @@ class LRParser:
                 # at the end of the file. nuke the top entry and generat=
e an error token
=20
                 # Start nuking entries on the stack
-                if lookahead.type =3D=3D "$end":
+                if lookahead.type =3D=3D '$end':
                     # Whoa. We're really hosed here. Bail out
                     return
=20
@@ -564,48 +648,67 @@ class LRParser:
                     if sym.type =3D=3D 'error':
                         # Hmmm. Error is on top of stack, we'll just nuk=
e input
                         # symbol and continue
+                        #--! TRACKING
+                        if tracking:
+                            sym.endlineno =3D getattr(lookahead, 'lineno=
', sym.lineno)
+                            sym.endlexpos =3D getattr(lookahead, 'lexpos=
', sym.lexpos)
+                        #--! TRACKING
                         lookahead =3D None
                         continue
+
+                    # Create the error symbol for the first time and mak=
e it the new lookahead symbol
                     t =3D YaccSymbol()
                     t.type =3D 'error'
-                    if hasattr(lookahead,"lineno"):
-                        t.lineno =3D lookahead.lineno
+
+                    if hasattr(lookahead, 'lineno'):
+                        t.lineno =3D t.endlineno =3D lookahead.lineno
+                    if hasattr(lookahead, 'lexpos'):
+                        t.lexpos =3D t.endlexpos =3D lookahead.lexpos
                     t.value =3D lookahead
                     lookaheadstack.append(lookahead)
                     lookahead =3D t
                 else:
-                    symstack.pop()
+                    sym =3D symstack.pop()
+                    #--! TRACKING
+                    if tracking:
+                        lookahead.lineno =3D sym.lineno
+                        lookahead.lexpos =3D sym.lexpos
+                    #--! TRACKING
                     statestack.pop()
-                    state =3D statestack[-1]       # Potential bug fix
+                    state =3D statestack[-1]
=20
                 continue
=20
             # Call an error function here
-            raise RuntimeError("yacc: internal parser error!!!\n")
+            raise RuntimeError('yacc: internal parser error!!!\n')
+
+        #--! parsedebug-end
=20
     # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!!!!!!!!
     # parseopt().
     #
-    # Optimized version of parse() method.  DO NOT EDIT THIS CODE DIRECT=
LY.
-    # Edit the debug version above, then copy any modifications to the m=
ethod
-    # below while removing #--! DEBUG sections.
+    # Optimized version of parse() method.  DO NOT EDIT THIS CODE DIRECT=
LY!
+    # This code is automatically generated by the ply/ygen.py script. Ma=
ke
+    # changes to the parsedebug() method instead.
     # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!!!!!!!!
=20
+    def parseopt(self, input=3DNone, lexer=3DNone, debug=3DFalse, tracki=
ng=3DFalse, tokenfunc=3DNone):
+        #--! parseopt-start
+        lookahead =3D None                         # Current lookahead s=
ymbol
+        lookaheadstack =3D []                      # Stack of lookahead =
symbols
+        actions =3D self.action                    # Local reference to =
action table (to avoid lookup on self.)
+        goto    =3D self.goto                      # Local reference to =
goto table (to avoid lookup on self.)
+        prod    =3D self.productions               # Local reference to =
production list (to avoid lookup on self.)
+        defaulted_states =3D self.defaulted_states # Local reference to =
defaulted states
+        pslice  =3D YaccProduction(None)           # Production object p=
assed to grammar rules
+        errorcount =3D 0                           # Used during error r=
ecovery
=20
-    def parseopt(self,input=3DNone,lexer=3DNone,debug=3D0,tracking=3D0,t=
okenfunc=3DNone):
-        lookahead =3D None                 # Current lookahead symbol
-        lookaheadstack =3D [ ]             # Stack of lookahead symbols
-        actions =3D self.action            # Local reference to action t=
able (to avoid lookup on self.)
-        goto    =3D self.goto              # Local reference to goto tab=
le (to avoid lookup on self.)
-        prod    =3D self.productions       # Local reference to producti=
on list (to avoid lookup on self.)
-        pslice  =3D YaccProduction(None)   # Production object passed to=
 grammar rules
-        errorcount =3D 0                   # Used during error recovery=20
=20
         # If no lexer was given, we will try to use the lex module
         if not lexer:
-            lex =3D load_ply_lex()
+            from . import lex
             lexer =3D lex.lexer
-       =20
+
         # Set up the lexer and parser objects on pslice
         pslice.lexer =3D lexer
         pslice.parser =3D self
@@ -615,16 +718,19 @@ class LRParser:
             lexer.input(input)
=20
         if tokenfunc is None:
-           # Tokenize function
-           get_token =3D lexer.token
+            # Tokenize function
+            get_token =3D lexer.token
         else:
-           get_token =3D tokenfunc
+            get_token =3D tokenfunc
+
+        # Set the parser() token method (sometimes used in error recover=
y)
+        self.token =3D get_token
=20
         # Set up the state and symbol stacks
=20
-        statestack =3D [ ]                # Stack of parsing states
+        statestack =3D []                # Stack of parsing states
         self.statestack =3D statestack
-        symstack   =3D [ ]                # Stack of grammar symbols
+        symstack   =3D []                # Stack of grammar symbols
         self.symstack =3D symstack
=20
         pslice.stack =3D symstack         # Put in the production
@@ -637,23 +743,28 @@ class LRParser:
         sym.type =3D '$end'
         symstack.append(sym)
         state =3D 0
-        while 1:
+        while True:
             # Get the next symbol on the input.  If a lookahead symbol
             # is already set, we just use that. Otherwise, we'll pull
             # the next token off of the lookaheadstack or from the lexer
=20
-            if not lookahead:
-                if not lookaheadstack:
-                    lookahead =3D get_token()     # Get the next token
-                else:
-                    lookahead =3D lookaheadstack.pop()
+
+            if state not in defaulted_states:
                 if not lookahead:
-                    lookahead =3D YaccSymbol()
-                    lookahead.type =3D '$end'
+                    if not lookaheadstack:
+                        lookahead =3D get_token()     # Get the next tok=
en
+                    else:
+                        lookahead =3D lookaheadstack.pop()
+                    if not lookahead:
+                        lookahead =3D YaccSymbol()
+                        lookahead.type =3D '$end'
+
+                # Check the action table
+                ltype =3D lookahead.type
+                t =3D actions[state].get(ltype)
+            else:
+                t =3D defaulted_states[state]
=20
-            # Check the action table
-            ltype =3D lookahead.type
-            t =3D actions[state].get(ltype)
=20
             if t is not None:
                 if t > 0:
@@ -661,11 +772,13 @@ class LRParser:
                     statestack.append(t)
                     state =3D t
=20
+
                     symstack.append(lookahead)
                     lookahead =3D None
=20
                     # Decrease error count on successful shift
-                    if errorcount: errorcount -=3D1
+                    if errorcount:
+                        errorcount -=3D 1
                     continue
=20
                 if t < 0:
@@ -679,61 +792,64 @@ class LRParser:
                     sym.type =3D pname       # Production name
                     sym.value =3D None
=20
+
                     if plen:
                         targ =3D symstack[-plen-1:]
                         targ[0] =3D sym
=20
-                        # --! TRACKING
+                        #--! TRACKING
                         if tracking:
-                           t1 =3D targ[1]
-                           sym.lineno =3D t1.lineno
-                           sym.lexpos =3D t1.lexpos
-                           t1 =3D targ[-1]
-                           sym.endlineno =3D getattr(t1,"endlineno",t1.l=
ineno)
-                           sym.endlexpos =3D getattr(t1,"endlexpos",t1.l=
expos)
-
-                        # --! TRACKING
+                            t1 =3D targ[1]
+                            sym.lineno =3D t1.lineno
+                            sym.lexpos =3D t1.lexpos
+                            t1 =3D targ[-1]
+                            sym.endlineno =3D getattr(t1, 'endlineno', t=
1.lineno)
+                            sym.endlexpos =3D getattr(t1, 'endlexpos', t=
1.lexpos)
+                        #--! TRACKING
=20
                         # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!
-                        # The code enclosed in this section is duplicate=
d=20
+                        # The code enclosed in this section is duplicate=
d
                         # below as a performance optimization.  Make sur=
e
                         # changes get made in both locations.
=20
                         pslice.slice =3D targ
-                       =20
+
                         try:
                             # Call the grammar rule with our special sli=
ce object
                             del symstack[-plen:]
-                            del statestack[-plen:]
+                            self.state =3D state
                             p.callable(pslice)
+                            del statestack[-plen:]
                             symstack.append(sym)
                             state =3D goto[statestack[-1]][pname]
                             statestack.append(state)
                         except SyntaxError:
                             # If an error was set. Enter error recovery =
state
-                            lookaheadstack.append(lookahead)
-                            symstack.pop()
-                            statestack.pop()
+                            lookaheadstack.append(lookahead)    # Save t=
he current lookahead token
+                            symstack.extend(targ[1:-1])         # Put th=
e production slice back on the stack
+                            statestack.pop()                    # Pop ba=
ck one state (before the reduce)
                             state =3D statestack[-1]
                             sym.type =3D 'error'
+                            sym.value =3D 'error'
                             lookahead =3D sym
                             errorcount =3D error_count
-                            self.errorok =3D 0
+                            self.errorok =3D False
+
                         continue
                         # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!
-   =20
+
                     else:
=20
-                        # --! TRACKING
+                        #--! TRACKING
                         if tracking:
-                           sym.lineno =3D lexer.lineno
-                           sym.lexpos =3D lexer.lexpos
-                        # --! TRACKING
+                            sym.lineno =3D lexer.lineno
+                            sym.lexpos =3D lexer.lexpos
+                        #--! TRACKING
=20
-                        targ =3D [ sym ]
+                        targ =3D [sym]
=20
                         # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!
-                        # The code enclosed in this section is duplicate=
d=20
+                        # The code enclosed in this section is duplicate=
d
                         # above as a performance optimization.  Make sur=
e
                         # changes get made in both locations.
=20
@@ -741,29 +857,33 @@ class LRParser:
=20
                         try:
                             # Call the grammar rule with our special sli=
ce object
+                            self.state =3D state
                             p.callable(pslice)
                             symstack.append(sym)
                             state =3D goto[statestack[-1]][pname]
                             statestack.append(state)
                         except SyntaxError:
                             # If an error was set. Enter error recovery =
state
-                            lookaheadstack.append(lookahead)
-                            symstack.pop()
-                            statestack.pop()
+                            lookaheadstack.append(lookahead)    # Save t=
he current lookahead token
+                            statestack.pop()                    # Pop ba=
ck one state (before the reduce)
                             state =3D statestack[-1]
                             sym.type =3D 'error'
+                            sym.value =3D 'error'
                             lookahead =3D sym
                             errorcount =3D error_count
-                            self.errorok =3D 0
+                            self.errorok =3D False
+
                         continue
                         # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!
=20
                 if t =3D=3D 0:
                     n =3D symstack[-1]
-                    return getattr(n,"value",None)
+                    result =3D getattr(n, 'value', None)
+                    return result
=20
             if t is None:
=20
+
                 # We have some kind of parsing error here.  To handle
                 # this, we are going to push the current token onto
                 # the tokenstack and replace it with an 'error' token.
@@ -776,20 +896,15 @@ class LRParser:
                 # errorcount =3D=3D 0.
                 if errorcount =3D=3D 0 or self.errorok:
                     errorcount =3D error_count
-                    self.errorok =3D 0
+                    self.errorok =3D False
                     errtoken =3D lookahead
                     if errtoken.type =3D=3D '$end':
                         errtoken =3D None               # End of file!
                     if self.errorfunc:
-                        global errok,token,restart
-                        errok =3D self.errok        # Set some special f=
unctions available in error recovery
-                        token =3D get_token
-                        restart =3D self.restart
-                        if errtoken and not hasattr(errtoken,'lexer'):
+                        if errtoken and not hasattr(errtoken, 'lexer'):
                             errtoken.lexer =3D lexer
-                        tok =3D self.errorfunc(errtoken)
-                        del errok, token, restart   # Delete special fun=
ctions
-
+                        self.state =3D state
+                        tok =3D call_errorfunc(self.errorfunc, errtoken,=
 self)
                         if self.errorok:
                             # User must have done some kind of panic
                             # mode recovery on their own.  The
@@ -799,14 +914,16 @@ class LRParser:
                             continue
                     else:
                         if errtoken:
-                            if hasattr(errtoken,"lineno"): lineno =3D lo=
okahead.lineno
-                            else: lineno =3D 0
+                            if hasattr(errtoken, 'lineno'):
+                                lineno =3D lookahead.lineno
+                            else:
+                                lineno =3D 0
                             if lineno:
-                                sys.stderr.write("yacc: Syntax error at =
line %d, token=3D%s\n" % (lineno, errtoken.type))
+                                sys.stderr.write('yacc: Syntax error at =
line %d, token=3D%s\n' % (lineno, errtoken.type))
                             else:
-                                sys.stderr.write("yacc: Syntax error, to=
ken=3D%s" % errtoken.type)
+                                sys.stderr.write('yacc: Syntax error, to=
ken=3D%s' % errtoken.type)
                         else:
-                            sys.stderr.write("yacc: Parse error in input=
. EOF\n")
+                            sys.stderr.write('yacc: Parse error in input=
. EOF\n')
                             return
=20
                 else:
@@ -837,47 +954,67 @@ class LRParser:
                     if sym.type =3D=3D 'error':
                         # Hmmm. Error is on top of stack, we'll just nuk=
e input
                         # symbol and continue
+                        #--! TRACKING
+                        if tracking:
+                            sym.endlineno =3D getattr(lookahead, 'lineno=
', sym.lineno)
+                            sym.endlexpos =3D getattr(lookahead, 'lexpos=
', sym.lexpos)
+                        #--! TRACKING
                         lookahead =3D None
                         continue
+
+                    # Create the error symbol for the first time and mak=
e it the new lookahead symbol
                     t =3D YaccSymbol()
                     t.type =3D 'error'
-                    if hasattr(lookahead,"lineno"):
-                        t.lineno =3D lookahead.lineno
+
+                    if hasattr(lookahead, 'lineno'):
+                        t.lineno =3D t.endlineno =3D lookahead.lineno
+                    if hasattr(lookahead, 'lexpos'):
+                        t.lexpos =3D t.endlexpos =3D lookahead.lexpos
                     t.value =3D lookahead
                     lookaheadstack.append(lookahead)
                     lookahead =3D t
                 else:
-                    symstack.pop()
+                    sym =3D symstack.pop()
+                    #--! TRACKING
+                    if tracking:
+                        lookahead.lineno =3D sym.lineno
+                        lookahead.lexpos =3D sym.lexpos
+                    #--! TRACKING
                     statestack.pop()
-                    state =3D statestack[-1]       # Potential bug fix
+                    state =3D statestack[-1]
=20
                 continue
=20
             # Call an error function here
-            raise RuntimeError("yacc: internal parser error!!!\n")
+            raise RuntimeError('yacc: internal parser error!!!\n')
+
+        #--! parseopt-end
=20
     # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!!!!!!!!
     # parseopt_notrack().
     #
-    # Optimized version of parseopt() with line number tracking removed.=
=20
-    # DO NOT EDIT THIS CODE DIRECTLY. Copy the optimized version and rem=
ove
-    # code in the #--! TRACKING sections
+    # Optimized version of parseopt() with line number tracking removed.
+    # DO NOT EDIT THIS CODE DIRECTLY. This code is automatically generat=
ed
+    # by the ply/ygen.py script. Make changes to the parsedebug() method=
 instead.
     # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!!!!!!!!
=20
-    def parseopt_notrack(self,input=3DNone,lexer=3DNone,debug=3D0,tracki=
ng=3D0,tokenfunc=3DNone):
-        lookahead =3D None                 # Current lookahead symbol
-        lookaheadstack =3D [ ]             # Stack of lookahead symbols
-        actions =3D self.action            # Local reference to action t=
able (to avoid lookup on self.)
-        goto    =3D self.goto              # Local reference to goto tab=
le (to avoid lookup on self.)
-        prod    =3D self.productions       # Local reference to producti=
on list (to avoid lookup on self.)
-        pslice  =3D YaccProduction(None)   # Production object passed to=
 grammar rules
-        errorcount =3D 0                   # Used during error recovery=20
+    def parseopt_notrack(self, input=3DNone, lexer=3DNone, debug=3DFalse=
, tracking=3DFalse, tokenfunc=3DNone):
+        #--! parseopt-notrack-start
+        lookahead =3D None                         # Current lookahead s=
ymbol
+        lookaheadstack =3D []                      # Stack of lookahead =
symbols
+        actions =3D self.action                    # Local reference to =
action table (to avoid lookup on self.)
+        goto    =3D self.goto                      # Local reference to =
goto table (to avoid lookup on self.)
+        prod    =3D self.productions               # Local reference to =
production list (to avoid lookup on self.)
+        defaulted_states =3D self.defaulted_states # Local reference to =
defaulted states
+        pslice  =3D YaccProduction(None)           # Production object p=
assed to grammar rules
+        errorcount =3D 0                           # Used during error r=
ecovery
+
=20
         # If no lexer was given, we will try to use the lex module
         if not lexer:
-            lex =3D load_ply_lex()
+            from . import lex
             lexer =3D lex.lexer
-       =20
+
         # Set up the lexer and parser objects on pslice
         pslice.lexer =3D lexer
         pslice.parser =3D self
@@ -887,16 +1024,19 @@ class LRParser:
             lexer.input(input)
=20
         if tokenfunc is None:
-           # Tokenize function
-           get_token =3D lexer.token
+            # Tokenize function
+            get_token =3D lexer.token
         else:
-           get_token =3D tokenfunc
+            get_token =3D tokenfunc
+
+        # Set the parser() token method (sometimes used in error recover=
y)
+        self.token =3D get_token
=20
         # Set up the state and symbol stacks
=20
-        statestack =3D [ ]                # Stack of parsing states
+        statestack =3D []                # Stack of parsing states
         self.statestack =3D statestack
-        symstack   =3D [ ]                # Stack of grammar symbols
+        symstack   =3D []                # Stack of grammar symbols
         self.symstack =3D symstack
=20
         pslice.stack =3D symstack         # Put in the production
@@ -909,23 +1049,28 @@ class LRParser:
         sym.type =3D '$end'
         symstack.append(sym)
         state =3D 0
-        while 1:
+        while True:
             # Get the next symbol on the input.  If a lookahead symbol
             # is already set, we just use that. Otherwise, we'll pull
             # the next token off of the lookaheadstack or from the lexer
=20
-            if not lookahead:
-                if not lookaheadstack:
-                    lookahead =3D get_token()     # Get the next token
-                else:
-                    lookahead =3D lookaheadstack.pop()
+
+            if state not in defaulted_states:
                 if not lookahead:
-                    lookahead =3D YaccSymbol()
-                    lookahead.type =3D '$end'
+                    if not lookaheadstack:
+                        lookahead =3D get_token()     # Get the next tok=
en
+                    else:
+                        lookahead =3D lookaheadstack.pop()
+                    if not lookahead:
+                        lookahead =3D YaccSymbol()
+                        lookahead.type =3D '$end'
+
+                # Check the action table
+                ltype =3D lookahead.type
+                t =3D actions[state].get(ltype)
+            else:
+                t =3D defaulted_states[state]
=20
-            # Check the action table
-            ltype =3D lookahead.type
-            t =3D actions[state].get(ltype)
=20
             if t is not None:
                 if t > 0:
@@ -933,11 +1078,13 @@ class LRParser:
                     statestack.append(t)
                     state =3D t
=20
+
                     symstack.append(lookahead)
                     lookahead =3D None
=20
                     # Decrease error count on successful shift
-                    if errorcount: errorcount -=3D1
+                    if errorcount:
+                        errorcount -=3D 1
                     continue
=20
                 if t < 0:
@@ -951,44 +1098,50 @@ class LRParser:
                     sym.type =3D pname       # Production name
                     sym.value =3D None
=20
+
                     if plen:
                         targ =3D symstack[-plen-1:]
                         targ[0] =3D sym
=20
+
                         # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!
-                        # The code enclosed in this section is duplicate=
d=20
+                        # The code enclosed in this section is duplicate=
d
                         # below as a performance optimization.  Make sur=
e
                         # changes get made in both locations.
=20
                         pslice.slice =3D targ
-                       =20
+
                         try:
                             # Call the grammar rule with our special sli=
ce object
                             del symstack[-plen:]
-                            del statestack[-plen:]
+                            self.state =3D state
                             p.callable(pslice)
+                            del statestack[-plen:]
                             symstack.append(sym)
                             state =3D goto[statestack[-1]][pname]
                             statestack.append(state)
                         except SyntaxError:
                             # If an error was set. Enter error recovery =
state
-                            lookaheadstack.append(lookahead)
-                            symstack.pop()
-                            statestack.pop()
+                            lookaheadstack.append(lookahead)    # Save t=
he current lookahead token
+                            symstack.extend(targ[1:-1])         # Put th=
e production slice back on the stack
+                            statestack.pop()                    # Pop ba=
ck one state (before the reduce)
                             state =3D statestack[-1]
                             sym.type =3D 'error'
+                            sym.value =3D 'error'
                             lookahead =3D sym
                             errorcount =3D error_count
-                            self.errorok =3D 0
+                            self.errorok =3D False
+
                         continue
                         # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!
-   =20
+
                     else:
=20
-                        targ =3D [ sym ]
+
+                        targ =3D [sym]
=20
                         # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!
-                        # The code enclosed in this section is duplicate=
d=20
+                        # The code enclosed in this section is duplicate=
d
                         # above as a performance optimization.  Make sur=
e
                         # changes get made in both locations.
=20
@@ -996,29 +1149,33 @@ class LRParser:
=20
                         try:
                             # Call the grammar rule with our special sli=
ce object
+                            self.state =3D state
                             p.callable(pslice)
                             symstack.append(sym)
                             state =3D goto[statestack[-1]][pname]
                             statestack.append(state)
                         except SyntaxError:
                             # If an error was set. Enter error recovery =
state
-                            lookaheadstack.append(lookahead)
-                            symstack.pop()
-                            statestack.pop()
+                            lookaheadstack.append(lookahead)    # Save t=
he current lookahead token
+                            statestack.pop()                    # Pop ba=
ck one state (before the reduce)
                             state =3D statestack[-1]
                             sym.type =3D 'error'
+                            sym.value =3D 'error'
                             lookahead =3D sym
                             errorcount =3D error_count
-                            self.errorok =3D 0
+                            self.errorok =3D False
+
                         continue
                         # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
!!!!
=20
                 if t =3D=3D 0:
                     n =3D symstack[-1]
-                    return getattr(n,"value",None)
+                    result =3D getattr(n, 'value', None)
+                    return result
=20
             if t is None:
=20
+
                 # We have some kind of parsing error here.  To handle
                 # this, we are going to push the current token onto
                 # the tokenstack and replace it with an 'error' token.
@@ -1031,20 +1188,15 @@ class LRParser:
                 # errorcount =3D=3D 0.
                 if errorcount =3D=3D 0 or self.errorok:
                     errorcount =3D error_count
-                    self.errorok =3D 0
+                    self.errorok =3D False
                     errtoken =3D lookahead
                     if errtoken.type =3D=3D '$end':
                         errtoken =3D None               # End of file!
                     if self.errorfunc:
-                        global errok,token,restart
-                        errok =3D self.errok        # Set some special f=
unctions available in error recovery
-                        token =3D get_token
-                        restart =3D self.restart
-                        if errtoken and not hasattr(errtoken,'lexer'):
+                        if errtoken and not hasattr(errtoken, 'lexer'):
                             errtoken.lexer =3D lexer
-                        tok =3D self.errorfunc(errtoken)
-                        del errok, token, restart   # Delete special fun=
ctions
-
+                        self.state =3D state
+                        tok =3D call_errorfunc(self.errorfunc, errtoken,=
 self)
                         if self.errorok:
                             # User must have done some kind of panic
                             # mode recovery on their own.  The
@@ -1054,14 +1206,16 @@ class LRParser:
                             continue
                     else:
                         if errtoken:
-                            if hasattr(errtoken,"lineno"): lineno =3D lo=
okahead.lineno
-                            else: lineno =3D 0
+                            if hasattr(errtoken, 'lineno'):
+                                lineno =3D lookahead.lineno
+                            else:
+                                lineno =3D 0
                             if lineno:
-                                sys.stderr.write("yacc: Syntax error at =
line %d, token=3D%s\n" % (lineno, errtoken.type))
+                                sys.stderr.write('yacc: Syntax error at =
line %d, token=3D%s\n' % (lineno, errtoken.type))
                             else:
-                                sys.stderr.write("yacc: Syntax error, to=
ken=3D%s" % errtoken.type)
+                                sys.stderr.write('yacc: Syntax error, to=
ken=3D%s' % errtoken.type)
                         else:
-                            sys.stderr.write("yacc: Parse error in input=
. EOF\n")
+                            sys.stderr.write('yacc: Parse error in input=
. EOF\n')
                             return
=20
                 else:
@@ -1094,31 +1248,37 @@ class LRParser:
                         # symbol and continue
                         lookahead =3D None
                         continue
+
+                    # Create the error symbol for the first time and mak=
e it the new lookahead symbol
                     t =3D YaccSymbol()
                     t.type =3D 'error'
-                    if hasattr(lookahead,"lineno"):
-                        t.lineno =3D lookahead.lineno
+
+                    if hasattr(lookahead, 'lineno'):
+                        t.lineno =3D t.endlineno =3D lookahead.lineno
+                    if hasattr(lookahead, 'lexpos'):
+                        t.lexpos =3D t.endlexpos =3D lookahead.lexpos
                     t.value =3D lookahead
                     lookaheadstack.append(lookahead)
                     lookahead =3D t
                 else:
-                    symstack.pop()
+                    sym =3D symstack.pop()
                     statestack.pop()
-                    state =3D statestack[-1]       # Potential bug fix
+                    state =3D statestack[-1]
=20
                 continue
=20
             # Call an error function here
-            raise RuntimeError("yacc: internal parser error!!!\n")
+            raise RuntimeError('yacc: internal parser error!!!\n')
+
+        #--! parseopt-notrack-end
=20
 # ----------------------------------------------------------------------=
-------
 #                          =3D=3D=3D Grammar Representation =3D=3D=3D
 #
 # The following functions, classes, and variables are used to represent =
and
-# manipulate the rules that make up a grammar.=20
+# manipulate the rules that make up a grammar.
 # ----------------------------------------------------------------------=
-------
=20
-
 # regex matching identifiers
 _is_identifier =3D re.compile(r'^[a-zA-Z0-9_-]+$')
=20
@@ -1128,7 +1288,7 @@ _is_identifier =3D re.compile(r'^[a-zA-Z0-9_-]+$')
 # This class stores the raw information about a single production or gra=
mmar rule.
 # A grammar rule refers to a specification such as this:
 #
-#       expr : expr PLUS term=20
+#       expr : expr PLUS term
 #
 # Here are the basic attributes defined on all productions
 #
@@ -1148,7 +1308,7 @@ _is_identifier =3D re.compile(r'^[a-zA-Z0-9_-]+$')
=20
 class Production(object):
     reduced =3D 0
-    def __init__(self,number,name,prod,precedence=3D('right',0),func=3DN=
one,file=3D'',line=3D0):
+    def __init__(self, number, name, prod, precedence=3D('right', 0), fu=
nc=3DNone, file=3D'', line=3D0):
         self.name     =3D name
         self.prod     =3D tuple(prod)
         self.number   =3D number
@@ -1159,11 +1319,11 @@ class Production(object):
         self.prec     =3D precedence
=20
         # Internal settings used during table construction
-       =20
+
         self.len  =3D len(self.prod)   # Length of the production
=20
         # Create a list of unique production symbols used in the product=
ion
-        self.usyms =3D [ ]            =20
+        self.usyms =3D []
         for s in self.prod:
             if s not in self.usyms:
                 self.usyms.append(s)
@@ -1174,15 +1334,15 @@ class Production(object):
=20
         # Create a string representation
         if self.prod:
-            self.str =3D "%s -> %s" % (self.name," ".join(self.prod))
+            self.str =3D '%s -> %s' % (self.name, ' '.join(self.prod))
         else:
-            self.str =3D "%s -> <empty>" % self.name
+            self.str =3D '%s -> <empty>' % self.name
=20
     def __str__(self):
         return self.str
=20
     def __repr__(self):
-        return "Production("+str(self)+")"
+        return 'Production(' + str(self) + ')'
=20
     def __len__(self):
         return len(self.prod)
@@ -1190,28 +1350,27 @@ class Production(object):
     def __nonzero__(self):
         return 1
=20
-    def __getitem__(self,index):
+    def __getitem__(self, index):
         return self.prod[index]
-           =20
-    # Return the nth lr_item from the production (or None if at the end)
-    def lr_item(self,n):
-        if n > len(self.prod): return None
-        p =3D LRItem(self,n)
=20
-        # Precompute the list of productions immediately following.  Hac=
k. Remove later
+    # Return the nth lr_item from the production (or None if at the end)
+    def lr_item(self, n):
+        if n > len(self.prod):
+            return None
+        p =3D LRItem(self, n)
+        # Precompute the list of productions immediately following.
         try:
-            p.lr_after =3D self.Prodnames[p.prod[n+1]]
-        except (IndexError,KeyError):
+            p.lr_after =3D Prodnames[p.prod[n+1]]
+        except (IndexError, KeyError):
             p.lr_after =3D []
         try:
             p.lr_before =3D p.prod[n-1]
         except IndexError:
             p.lr_before =3D None
-
         return p
-   =20
+
     # Bind the production function name to a callable
-    def bind(self,pdict):
+    def bind(self, pdict):
         if self.func:
             self.callable =3D pdict[self.func]
=20
@@ -1220,7 +1379,7 @@ class Production(object):
 # actually used by the LR parsing engine, plus some additional
 # debugging information.
 class MiniProduction(object):
-    def __init__(self,str,name,len,func,file,line):
+    def __init__(self, str, name, len, func, file, line):
         self.name     =3D name
         self.len      =3D len
         self.func     =3D func
@@ -1228,13 +1387,15 @@ class MiniProduction(object):
         self.file     =3D file
         self.line     =3D line
         self.str      =3D str
+
     def __str__(self):
         return self.str
+
     def __repr__(self):
-        return "MiniProduction(%s)" % self.str
+        return 'MiniProduction(%s)' % self.str
=20
     # Bind the production function name to a callable
-    def bind(self,pdict):
+    def bind(self, pdict):
         if self.func:
             self.callable =3D pdict[self.func]
=20
@@ -1243,9 +1404,9 @@ class MiniProduction(object):
 # class LRItem
 #
 # This class represents a specific stage of parsing a production rule.  =
For
-# example:=20
+# example:
 #
-#       expr : expr . PLUS term=20
+#       expr : expr . PLUS term
 #
 # In the above, the "." represents the current location of the parse.  H=
ere
 # basic attributes:
@@ -1264,26 +1425,26 @@ class MiniProduction(object):
 # ----------------------------------------------------------------------=
-------
=20
 class LRItem(object):
-    def __init__(self,p,n):
+    def __init__(self, p, n):
         self.name       =3D p.name
         self.prod       =3D list(p.prod)
         self.number     =3D p.number
         self.lr_index   =3D n
-        self.lookaheads =3D { }
-        self.prod.insert(n,".")
+        self.lookaheads =3D {}
+        self.prod.insert(n, '.')
         self.prod       =3D tuple(self.prod)
         self.len        =3D len(self.prod)
         self.usyms      =3D p.usyms
=20
     def __str__(self):
         if self.prod:
-            s =3D "%s -> %s" % (self.name," ".join(self.prod))
+            s =3D '%s -> %s' % (self.name, ' '.join(self.prod))
         else:
-            s =3D "%s -> <empty>" % self.name
+            s =3D '%s -> <empty>' % self.name
         return s
=20
     def __repr__(self):
-        return "LRItem("+str(self)+")"
+        return 'LRItem(' + str(self) + ')'
=20
 # ----------------------------------------------------------------------=
-------
 # rightmost_terminal()
@@ -1306,21 +1467,22 @@ def rightmost_terminal(symbols, terminals):
 # This data is used for critical parts of the table generation process l=
ater.
 # ----------------------------------------------------------------------=
-------
=20
-class GrammarError(YaccError): pass
+class GrammarError(YaccError):
+    pass
=20
 class Grammar(object):
-    def __init__(self,terminals):
+    def __init__(self, terminals):
         self.Productions  =3D [None]  # A list of all of the productions=
.  The first
                                     # entry is always reserved for the p=
urpose of
                                     # building an augmented grammar
=20
-        self.Prodnames    =3D { }     # A dictionary mapping the names o=
f nonterminals to a list of all
+        self.Prodnames    =3D {}      # A dictionary mapping the names o=
f nonterminals to a list of all
                                     # productions of that nonterminal.
=20
-        self.Prodmap      =3D { }     # A dictionary that is only used t=
o detect duplicate
+        self.Prodmap      =3D {}      # A dictionary that is only used t=
o detect duplicate
                                     # productions.
=20
-        self.Terminals    =3D { }     # A dictionary mapping the names o=
f terminal symbols to a
+        self.Terminals    =3D {}      # A dictionary mapping the names o=
f terminal symbols to a
                                     # list of the rules where they are u=
sed.
=20
         for term in terminals:
@@ -1328,17 +1490,17 @@ class Grammar(object):
=20
         self.Terminals['error'] =3D []
=20
-        self.Nonterminals =3D { }     # A dictionary mapping names of no=
nterminals to a list
+        self.Nonterminals =3D {}      # A dictionary mapping names of no=
nterminals to a list
                                     # of rule numbers where they are use=
d.
=20
-        self.First        =3D { }     # A dictionary of precomputed FIRS=
T(x) symbols
+        self.First        =3D {}      # A dictionary of precomputed FIRS=
T(x) symbols
=20
-        self.Follow       =3D { }     # A dictionary of precomputed FOLL=
OW(x) symbols
+        self.Follow       =3D {}      # A dictionary of precomputed FOLL=
OW(x) symbols
=20
-        self.Precedence   =3D { }     # Precedence rules for each termin=
al. Contains tuples of the
+        self.Precedence   =3D {}      # Precedence rules for each termin=
al. Contains tuples of the
                                     # form ('right',level) or ('nonassoc=
', level) or ('left',level)
=20
-        self.UsedPrecedence =3D { }   # Precedence rules that were actua=
lly used by the grammer.
+        self.UsedPrecedence =3D set() # Precedence rules that were actua=
lly used by the grammer.
                                     # This is only used to provide error=
 checking and to generate
                                     # a warning about unused precedence =
rules.
=20
@@ -1348,7 +1510,7 @@ class Grammar(object):
     def __len__(self):
         return len(self.Productions)
=20
-    def __getitem__(self,index):
+    def __getitem__(self, index):
         return self.Productions[index]
=20
     # ------------------------------------------------------------------=
-----------
@@ -1359,14 +1521,14 @@ class Grammar(object):
     #
     # ------------------------------------------------------------------=
-----------
=20
-    def set_precedence(self,term,assoc,level):
-        assert self.Productions =3D=3D [None],"Must call set_precedence(=
) before add_production()"
+    def set_precedence(self, term, assoc, level):
+        assert self.Productions =3D=3D [None], 'Must call set_precedence=
() before add_production()'
         if term in self.Precedence:
-            raise GrammarError("Precedence already specified for termina=
l '%s'" % term)
-        if assoc not in ['left','right','nonassoc']:
+            raise GrammarError('Precedence already specified for termina=
l %r' % term)
+        if assoc not in ['left', 'right', 'nonassoc']:
             raise GrammarError("Associativity must be one of 'left','rig=
ht', or 'nonassoc'")
-        self.Precedence[term] =3D (assoc,level)
-=20
+        self.Precedence[term] =3D (assoc, level)
+
     # ------------------------------------------------------------------=
-----------
     # add_production()
     #
@@ -1384,72 +1546,74 @@ class Grammar(object):
     # are valid and that %prec is used correctly.
     # ------------------------------------------------------------------=
-----------
=20
-    def add_production(self,prodname,syms,func=3DNone,file=3D'',line=3D0=
):
+    def add_production(self, prodname, syms, func=3DNone, file=3D'', lin=
e=3D0):
=20
         if prodname in self.Terminals:
-            raise GrammarError("%s:%d: Illegal rule name '%s'. Already d=
efined as a token" % (file,line,prodname))
+            raise GrammarError('%s:%d: Illegal rule name %r. Already def=
ined as a token' % (file, line, prodname))
         if prodname =3D=3D 'error':
-            raise GrammarError("%s:%d: Illegal rule name '%s'. error is =
a reserved word" % (file,line,prodname))
+            raise GrammarError('%s:%d: Illegal rule name %r. error is a =
reserved word' % (file, line, prodname))
         if not _is_identifier.match(prodname):
-            raise GrammarError("%s:%d: Illegal rule name '%s'" % (file,l=
ine,prodname))
+            raise GrammarError('%s:%d: Illegal rule name %r' % (file, li=
ne, prodname))
=20
-        # Look for literal tokens=20
-        for n,s in enumerate(syms):
+        # Look for literal tokens
+        for n, s in enumerate(syms):
             if s[0] in "'\"":
-                 try:
-                     c =3D eval(s)
-                     if (len(c) > 1):
-                          raise GrammarError("%s:%d: Literal token %s in=
 rule '%s' may only be a single character" % (file,line,s, prodname))
-                     if not c in self.Terminals:
-                          self.Terminals[c] =3D []
-                     syms[n] =3D c
-                     continue
-                 except SyntaxError:
-                     pass
+                try:
+                    c =3D eval(s)
+                    if (len(c) > 1):
+                        raise GrammarError('%s:%d: Literal token %s in r=
ule %r may only be a single character' %
+                                           (file, line, s, prodname))
+                    if c not in self.Terminals:
+                        self.Terminals[c] =3D []
+                    syms[n] =3D c
+                    continue
+                except SyntaxError:
+                    pass
             if not _is_identifier.match(s) and s !=3D '%prec':
-                raise GrammarError("%s:%d: Illegal name '%s' in rule '%s=
'" % (file,line,s, prodname))
-       =20
+                raise GrammarError('%s:%d: Illegal name %r in rule %r' %=
 (file, line, s, prodname))
+
         # Determine the precedence level
         if '%prec' in syms:
             if syms[-1] =3D=3D '%prec':
-                raise GrammarError("%s:%d: Syntax error. Nothing follows=
 %%prec" % (file,line))
+                raise GrammarError('%s:%d: Syntax error. Nothing follows=
 %%prec' % (file, line))
             if syms[-2] !=3D '%prec':
-                raise GrammarError("%s:%d: Syntax error. %%prec can only=
 appear at the end of a grammar rule" % (file,line))
+                raise GrammarError('%s:%d: Syntax error. %%prec can only=
 appear at the end of a grammar rule' %
+                                   (file, line))
             precname =3D syms[-1]
-            prodprec =3D self.Precedence.get(precname,None)
+            prodprec =3D self.Precedence.get(precname)
             if not prodprec:
-                raise GrammarError("%s:%d: Nothing known about the prece=
dence of '%s'" % (file,line,precname))
+                raise GrammarError('%s:%d: Nothing known about the prece=
dence of %r' % (file, line, precname))
             else:
-                self.UsedPrecedence[precname] =3D 1
+                self.UsedPrecedence.add(precname)
             del syms[-2:]     # Drop %prec from the rule
         else:
             # If no %prec, precedence is determined by the rightmost ter=
minal symbol
-            precname =3D rightmost_terminal(syms,self.Terminals)
-            prodprec =3D self.Precedence.get(precname,('right',0))=20
-           =20
+            precname =3D rightmost_terminal(syms, self.Terminals)
+            prodprec =3D self.Precedence.get(precname, ('right', 0))
+
         # See if the rule is already in the rulemap
-        map =3D "%s -> %s" % (prodname,syms)
+        map =3D '%s -> %s' % (prodname, syms)
         if map in self.Prodmap:
             m =3D self.Prodmap[map]
-            raise GrammarError("%s:%d: Duplicate rule %s. " % (file,line=
, m) +
-                               "Previous definition at %s:%d" % (m.file,=
 m.line))
+            raise GrammarError('%s:%d: Duplicate rule %s. ' % (file, lin=
e, m) +
+                               'Previous definition at %s:%d' % (m.file,=
 m.line))
=20
         # From this point on, everything is valid.  Create a new Product=
ion instance
         pnumber  =3D len(self.Productions)
-        if not prodname in self.Nonterminals:
-            self.Nonterminals[prodname] =3D [ ]
+        if prodname not in self.Nonterminals:
+            self.Nonterminals[prodname] =3D []
=20
         # Add the production number to Terminals and Nonterminals
         for t in syms:
             if t in self.Terminals:
                 self.Terminals[t].append(pnumber)
             else:
-                if not t in self.Nonterminals:
-                    self.Nonterminals[t] =3D [ ]
+                if t not in self.Nonterminals:
+                    self.Nonterminals[t] =3D []
                 self.Nonterminals[t].append(pnumber)
=20
         # Create a production and add it to the list of productions
-        p =3D Production(pnumber,prodname,syms,prodprec,func,file,line)
+        p =3D Production(pnumber, prodname, syms, prodprec, func, file, =
line)
         self.Productions.append(p)
         self.Prodmap[map] =3D p
=20
@@ -1457,22 +1621,21 @@ class Grammar(object):
         try:
             self.Prodnames[prodname].append(p)
         except KeyError:
-            self.Prodnames[prodname] =3D [ p ]
-        return 0
+            self.Prodnames[prodname] =3D [p]
=20
     # ------------------------------------------------------------------=
-----------
     # set_start()
     #
-    # Sets the starting symbol and creates the augmented grammar.  Produ=
ction=20
+    # Sets the starting symbol and creates the augmented grammar.  Produ=
ction
     # rule 0 is S' -> start where start is the start symbol.
     # ------------------------------------------------------------------=
-----------
=20
-    def set_start(self,start=3DNone):
+    def set_start(self, start=3DNone):
         if not start:
             start =3D self.Productions[1].name
         if start not in self.Nonterminals:
-            raise GrammarError("start symbol %s undefined" % start)
-        self.Productions[0] =3D Production(0,"S'",[start])
+            raise GrammarError('start symbol %s undefined' % start)
+        self.Productions[0] =3D Production(0, "S'", [start])
         self.Nonterminals[start].append(0)
         self.Start =3D start
=20
@@ -1484,26 +1647,20 @@ class Grammar(object):
     # ------------------------------------------------------------------=
-----------
=20
     def find_unreachable(self):
-       =20
+
         # Mark all symbols that are reachable from a symbol s
         def mark_reachable_from(s):
-            if reachable[s]:
-                # We've already reached symbol s.
+            if s in reachable:
                 return
-            reachable[s] =3D 1
-            for p in self.Prodnames.get(s,[]):
+            reachable.add(s)
+            for p in self.Prodnames.get(s, []):
                 for r in p.prod:
                     mark_reachable_from(r)
=20
-        reachable   =3D { }
-        for s in list(self.Terminals) + list(self.Nonterminals):
-            reachable[s] =3D 0
+        reachable =3D set()
+        mark_reachable_from(self.Productions[0].prod[0])
+        return [s for s in self.Nonterminals if s not in reachable]
=20
-        mark_reachable_from( self.Productions[0].prod[0] )
-
-        return [s for s in list(self.Nonterminals)
-                        if not reachable[s]]
-   =20
     # ------------------------------------------------------------------=
-----------
     # infinite_cycles()
     #
@@ -1517,20 +1674,20 @@ class Grammar(object):
=20
         # Terminals:
         for t in self.Terminals:
-            terminates[t] =3D 1
+            terminates[t] =3D True
=20
-        terminates['$end'] =3D 1
+        terminates['$end'] =3D True
=20
         # Nonterminals:
=20
         # Initialize to false:
         for n in self.Nonterminals:
-            terminates[n] =3D 0
+            terminates[n] =3D False
=20
         # Then propagate termination until no change:
-        while 1:
-            some_change =3D 0
-            for (n,pl) in self.Prodnames.items():
+        while True:
+            some_change =3D False
+            for (n, pl) in self.Prodnames.items():
                 # Nonterminal n terminates iff any of its productions te=
rminates.
                 for p in pl:
                     # Production p terminates iff all of its rhs symbols=
 terminate.
@@ -1538,19 +1695,19 @@ class Grammar(object):
                         if not terminates[s]:
                             # The symbol s does not terminate,
                             # so production p does not terminate.
-                            p_terminates =3D 0
+                            p_terminates =3D False
                             break
                     else:
                         # didn't break from the loop,
                         # so every symbol s terminates
                         # so production p terminates.
-                        p_terminates =3D 1
+                        p_terminates =3D True
=20
                     if p_terminates:
                         # symbol n terminates!
                         if not terminates[n]:
-                            terminates[n] =3D 1
-                            some_change =3D 1
+                            terminates[n] =3D True
+                            some_change =3D True
                         # Don't need to consider any more productions fo=
r this n.
                         break
=20
@@ -1558,9 +1715,9 @@ class Grammar(object):
                 break
=20
         infinite =3D []
-        for (s,term) in terminates.items():
+        for (s, term) in terminates.items():
             if not term:
-                if not s in self.Prodnames and not s in self.Terminals a=
nd s !=3D 'error':
+                if s not in self.Prodnames and s not in self.Terminals a=
nd s !=3D 'error':
                     # s is used-but-not-defined, and we've already warne=
d of that,
                     # so it would be overkill to say that it's also non-=
terminating.
                     pass
@@ -1569,22 +1726,22 @@ class Grammar(object):
=20
         return infinite
=20
-
     # ------------------------------------------------------------------=
-----------
     # undefined_symbols()
     #
     # Find all symbols that were used the grammar, but not defined as to=
kens or
     # grammar rules.  Returns a list of tuples (sym, prod) where sym in =
the symbol
-    # and prod is the production where the symbol was used.=20
+    # and prod is the production where the symbol was used.
     # ------------------------------------------------------------------=
-----------
     def undefined_symbols(self):
         result =3D []
         for p in self.Productions:
-            if not p: continue
+            if not p:
+                continue
=20
             for s in p.prod:
-                if not s in self.Prodnames and not s in self.Terminals a=
nd s !=3D 'error':
-                    result.append((s,p))
+                if s not in self.Prodnames and s not in self.Terminals a=
nd s !=3D 'error':
+                    result.append((s, p))
         return result
=20
     # ------------------------------------------------------------------=
-----------
@@ -1595,7 +1752,7 @@ class Grammar(object):
     # ------------------------------------------------------------------=
-----------
     def unused_terminals(self):
         unused_tok =3D []
-        for s,v in self.Terminals.items():
+        for s, v in self.Terminals.items():
             if s !=3D 'error' and not v:
                 unused_tok.append(s)
=20
@@ -1610,7 +1767,7 @@ class Grammar(object):
=20
     def unused_rules(self):
         unused_prod =3D []
-        for s,v in self.Nonterminals.items():
+        for s, v in self.Nonterminals.items():
             if not v:
                 p =3D self.Prodnames[s][0]
                 unused_prod.append(p)
@@ -1622,15 +1779,15 @@ class Grammar(object):
     # Returns a list of tuples (term,precedence) corresponding to preced=
ence
     # rules that were never used by the grammar.  term is the name of th=
e terminal
     # on which precedence was applied and precedence is a string such as=
 'left' or
-    # 'right' corresponding to the type of precedence.=20
+    # 'right' corresponding to the type of precedence.
     # ------------------------------------------------------------------=
-----------
=20
     def unused_precedence(self):
         unused =3D []
         for termname in self.Precedence:
             if not (termname in self.Terminals or termname in self.UsedP=
recedence):
-                unused.append((termname,self.Precedence[termname][0]))
-               =20
+                unused.append((termname, self.Precedence[termname][0]))
+
         return unused
=20
     # ------------------------------------------------------------------=
-------
@@ -1641,19 +1798,20 @@ class Grammar(object):
     # During execution of compute_first1, the result may be incomplete.
     # Afterward (e.g., when called from compute_follow()), it will be co=
mplete.
     # ------------------------------------------------------------------=
-------
-    def _first(self,beta):
+    def _first(self, beta):
=20
         # We are computing First(x1,x2,x3,...,xn)
-        result =3D [ ]
+        result =3D []
         for x in beta:
-            x_produces_empty =3D 0
+            x_produces_empty =3D False
=20
             # Add all the non-<empty> symbols of First[x] to the result.
             for f in self.First[x]:
                 if f =3D=3D '<empty>':
-                    x_produces_empty =3D 1
+                    x_produces_empty =3D True
                 else:
-                    if f not in result: result.append(f)
+                    if f not in result:
+                        result.append(f)
=20
             if x_produces_empty:
                 # We have to consider the next x in beta,
@@ -1692,17 +1850,17 @@ class Grammar(object):
             self.First[n] =3D []
=20
         # Then propagate symbols until no change:
-        while 1:
-            some_change =3D 0
+        while True:
+            some_change =3D False
             for n in self.Nonterminals:
                 for p in self.Prodnames[n]:
                     for f in self._first(p.prod):
                         if f not in self.First[n]:
-                            self.First[n].append( f )
-                            some_change =3D 1
+                            self.First[n].append(f)
+                            some_change =3D True
             if not some_change:
                 break
-       =20
+
         return self.First
=20
     # ------------------------------------------------------------------=
---
@@ -1712,7 +1870,7 @@ class Grammar(object):
     # follow set is the set of all symbols that might follow a given
     # non-terminal.  See the Dragon book, 2nd Ed. p. 189.
     # ------------------------------------------------------------------=
---
-    def compute_follow(self,start=3DNone):
+    def compute_follow(self, start=3DNone):
         # If already computed, return the result
         if self.Follow:
             return self.Follow
@@ -1723,36 +1881,36 @@ class Grammar(object):
=20
         # Add '$end' to the follow list of the start symbol
         for k in self.Nonterminals:
-            self.Follow[k] =3D [ ]
+            self.Follow[k] =3D []
=20
         if not start:
             start =3D self.Productions[1].name
=20
-        self.Follow[start] =3D [ '$end' ]
+        self.Follow[start] =3D ['$end']
=20
-        while 1:
-            didadd =3D 0
+        while True:
+            didadd =3D False
             for p in self.Productions[1:]:
                 # Here is the production set
-                for i in range(len(p.prod)):
-                    B =3D p.prod[i]
+                for i, B in enumerate(p.prod):
                     if B in self.Nonterminals:
                         # Okay. We got a non-terminal in a production
                         fst =3D self._first(p.prod[i+1:])
-                        hasempty =3D 0
+                        hasempty =3D False
                         for f in fst:
                             if f !=3D '<empty>' and f not in self.Follow=
[B]:
                                 self.Follow[B].append(f)
-                                didadd =3D 1
+                                didadd =3D True
                             if f =3D=3D '<empty>':
-                                hasempty =3D 1
+                                hasempty =3D True
                         if hasempty or i =3D=3D (len(p.prod)-1):
                             # Add elements of follow(a) to follow(b)
                             for f in self.Follow[p.name]:
                                 if f not in self.Follow[B]:
                                     self.Follow[B].append(f)
-                                    didadd =3D 1
-            if not didadd: break
+                                    didadd =3D True
+            if not didadd:
+                break
         return self.Follow
=20
=20
@@ -1776,15 +1934,15 @@ class Grammar(object):
             lastlri =3D p
             i =3D 0
             lr_items =3D []
-            while 1:
+            while True:
                 if i > len(p):
                     lri =3D None
                 else:
-                    lri =3D LRItem(p,i)
+                    lri =3D LRItem(p, i)
                     # Precompute the list of productions immediately fol=
lowing
                     try:
                         lri.lr_after =3D self.Prodnames[lri.prod[i+1]]
-                    except (IndexError,KeyError):
+                    except (IndexError, KeyError):
                         lri.lr_after =3D []
                     try:
                         lri.lr_before =3D lri.prod[i-1]
@@ -1792,7 +1950,8 @@ class Grammar(object):
                         lri.lr_before =3D None
=20
                 lastlri.lr_next =3D lri
-                if not lri: break
+                if not lri:
+                    break
                 lr_items.append(lri)
                 lastlri =3D lri
                 i +=3D 1
@@ -1801,12 +1960,13 @@ class Grammar(object):
 # ----------------------------------------------------------------------=
-------
 #                            =3D=3D Class LRTable =3D=3D
 #
-# This basic class represents a basic table of LR parsing information. =20
+# This basic class represents a basic table of LR parsing information.
 # Methods for generating the tables are not defined here.  They are defi=
ned
 # in the derived class LRGeneratedTable.
 # ----------------------------------------------------------------------=
-------
=20
-class VersionError(YaccError): pass
+class VersionError(YaccError):
+    pass
=20
 class LRTable(object):
     def __init__(self):
@@ -1815,19 +1975,15 @@ class LRTable(object):
         self.lr_productions =3D None
         self.lr_method =3D None
=20
-    def read_table(self,module):
-        if isinstance(module,types.ModuleType):
+    def read_table(self, module):
+        if isinstance(module, types.ModuleType):
             parsetab =3D module
         else:
-            if sys.version_info[0] < 3:
-                exec("import %s as parsetab" % module)
-            else:
-                env =3D { }
-                exec("import %s as parsetab" % module, env, env)
-                parsetab =3D env['parsetab']
+            exec('import %s' % module)
+            parsetab =3D sys.modules[module]
=20
         if parsetab._tabversion !=3D __tabversion__:
-            raise VersionError("yacc table file version is out of date")
+            raise VersionError('yacc table file version is out of date')
=20
         self.lr_action =3D parsetab._lr_action
         self.lr_goto =3D parsetab._lr_goto
@@ -1839,17 +1995,20 @@ class LRTable(object):
         self.lr_method =3D parsetab._lr_method
         return parsetab._lr_signature
=20
-    def read_pickle(self,filename):
+    def read_pickle(self, filename):
         try:
             import cPickle as pickle
         except ImportError:
             import pickle
=20
-        in_f =3D open(filename,"rb")
+        if not os.path.exists(filename):
+          raise ImportError
+
+        in_f =3D open(filename, 'rb')
=20
         tabversion =3D pickle.load(in_f)
         if tabversion !=3D __tabversion__:
-            raise VersionError("yacc table file version is out of date")
+            raise VersionError('yacc table file version is out of date')
         self.lr_method =3D pickle.load(in_f)
         signature      =3D pickle.load(in_f)
         self.lr_action =3D pickle.load(in_f)
@@ -1864,14 +2023,15 @@ class LRTable(object):
         return signature
=20
     # Bind all production function names to callable objects in pdict
-    def bind_callables(self,pdict):
+    def bind_callables(self, pdict):
         for p in self.lr_productions:
             p.bind(pdict)
-   =20
+
+
 # ----------------------------------------------------------------------=
-------
 #                           =3D=3D=3D LR Generator =3D=3D=3D
 #
-# The following classes and functions are used to generate LR parsing ta=
bles on=20
+# The following classes and functions are used to generate LR parsing ta=
bles on
 # a grammar.
 # ----------------------------------------------------------------------=
-------
=20
@@ -1892,17 +2052,18 @@ class LRTable(object):
 #          FP   - Set-valued function
 # ----------------------------------------------------------------------=
--------
=20
-def digraph(X,R,FP):
-    N =3D { }
+def digraph(X, R, FP):
+    N =3D {}
     for x in X:
-       N[x] =3D 0
+        N[x] =3D 0
     stack =3D []
-    F =3D { }
+    F =3D {}
     for x in X:
-        if N[x] =3D=3D 0: traverse(x,N,stack,F,X,R,FP)
+        if N[x] =3D=3D 0:
+            traverse(x, N, stack, F, X, R, FP)
     return F
=20
-def traverse(x,N,stack,F,X,R,FP):
+def traverse(x, N, stack, F, X, R, FP):
     stack.append(x)
     d =3D len(stack)
     N[x] =3D d
@@ -1911,20 +2072,22 @@ def traverse(x,N,stack,F,X,R,FP):
     rel =3D R(x)               # Get y's related to x
     for y in rel:
         if N[y] =3D=3D 0:
-             traverse(y,N,stack,F,X,R,FP)
-        N[x] =3D min(N[x],N[y])
-        for a in F.get(y,[]):
-            if a not in F[x]: F[x].append(a)
+            traverse(y, N, stack, F, X, R, FP)
+        N[x] =3D min(N[x], N[y])
+        for a in F.get(y, []):
+            if a not in F[x]:
+                F[x].append(a)
     if N[x] =3D=3D d:
-       N[stack[-1]] =3D MAXINT
-       F[stack[-1]] =3D F[x]
-       element =3D stack.pop()
-       while element !=3D x:
-           N[stack[-1]] =3D MAXINT
-           F[stack[-1]] =3D F[x]
-           element =3D stack.pop()
+        N[stack[-1]] =3D MAXINT
+        F[stack[-1]] =3D F[x]
+        element =3D stack.pop()
+        while element !=3D x:
+            N[stack[-1]] =3D MAXINT
+            F[stack[-1]] =3D F[x]
+            element =3D stack.pop()
=20
-class LALRError(YaccError): pass
+class LALRError(YaccError):
+    pass
=20
 # ----------------------------------------------------------------------=
-------
 #                             =3D=3D LRGeneratedTable =3D=3D
@@ -1934,9 +2097,9 @@ class LALRError(YaccError): pass
 # ----------------------------------------------------------------------=
-------
=20
 class LRGeneratedTable(LRTable):
-    def __init__(self,grammar,method=3D'LALR',log=3DNone):
-        if method not in ['SLR','LALR']:
-            raise LALRError("Unsupported method %s" % method)
+    def __init__(self, grammar, method=3D'LALR', log=3DNone):
+        if method not in ['SLR', 'LALR']:
+            raise LALRError('Unsupported method %s' % method)
=20
         self.grammar =3D grammar
         self.lr_method =3D method
@@ -1971,21 +2134,22 @@ class LRGeneratedTable(LRTable):
=20
     # Compute the LR(0) closure operation on I, where I is a set of LR(0=
) items.
=20
-    def lr0_closure(self,I):
+    def lr0_closure(self, I):
         self._add_count +=3D 1
=20
         # Add everything in I to J
         J =3D I[:]
-        didadd =3D 1
+        didadd =3D True
         while didadd:
-            didadd =3D 0
+            didadd =3D False
             for j in J:
                 for x in j.lr_after:
-                    if getattr(x,"lr0_added",0) =3D=3D self._add_count: =
continue
+                    if getattr(x, 'lr0_added', 0) =3D=3D self._add_count=
:
+                        continue
                     # Add B --> .G to J
                     J.append(x.lr_next)
                     x.lr0_added =3D self._add_count
-                    didadd =3D 1
+                    didadd =3D True
=20
         return J
=20
@@ -1996,43 +2160,43 @@ class LRGeneratedTable(LRTable):
     # objects).  With uniqueness, we can later do fast set comparisons u=
sing
     # id(obj) instead of element-wise comparison.
=20
-    def lr0_goto(self,I,x):
+    def lr0_goto(self, I, x):
         # First we look for a previously cached entry
-        g =3D self.lr_goto_cache.get((id(I),x),None)
-        if g: return g
+        g =3D self.lr_goto_cache.get((id(I), x))
+        if g:
+            return g
=20
         # Now we generate the goto set in a way that guarantees uniquene=
ss
         # of the result
=20
-        s =3D self.lr_goto_cache.get(x,None)
+        s =3D self.lr_goto_cache.get(x)
         if not s:
-            s =3D { }
+            s =3D {}
             self.lr_goto_cache[x] =3D s
=20
-        gs =3D [ ]
+        gs =3D []
         for p in I:
             n =3D p.lr_next
             if n and n.lr_before =3D=3D x:
-                s1 =3D s.get(id(n),None)
+                s1 =3D s.get(id(n))
                 if not s1:
-                    s1 =3D { }
+                    s1 =3D {}
                     s[id(n)] =3D s1
                 gs.append(n)
                 s =3D s1
-        g =3D s.get('$end',None)
+        g =3D s.get('$end')
         if not g:
             if gs:
                 g =3D self.lr0_closure(gs)
                 s['$end'] =3D g
             else:
                 s['$end'] =3D gs
-        self.lr_goto_cache[(id(I),x)] =3D g
+        self.lr_goto_cache[(id(I), x)] =3D g
         return g
=20
     # Compute the LR(0) sets of item function
     def lr0_items(self):
-
-        C =3D [ self.lr0_closure([self.grammar.Productions[0].lr_next]) =
]
+        C =3D [self.lr0_closure([self.grammar.Productions[0].lr_next])]
         i =3D 0
         for I in C:
             self.lr0_cidhash[id(I)] =3D i
@@ -2045,15 +2209,15 @@ class LRGeneratedTable(LRTable):
             i +=3D 1
=20
             # Collect all of the symbols that could possibly be in the g=
oto(I,X) sets
-            asyms =3D { }
+            asyms =3D {}
             for ii in I:
                 for s in ii.usyms:
                     asyms[s] =3D None
=20
             for x in asyms:
-                g =3D self.lr0_goto(I,x)
-                if not g:  continue
-                if id(g) in self.lr0_cidhash: continue
+                g =3D self.lr0_goto(I, x)
+                if not g or id(g) in self.lr0_cidhash:
+                    continue
                 self.lr0_cidhash[id(g)] =3D len(C)
                 C.append(g)
=20
@@ -2088,19 +2252,21 @@ class LRGeneratedTable(LRTable):
     # ------------------------------------------------------------------=
-----------
=20
     def compute_nullable_nonterminals(self):
-        nullable =3D {}
+        nullable =3D set()
         num_nullable =3D 0
-        while 1:
-           for p in self.grammar.Productions[1:]:
-               if p.len =3D=3D 0:
-                    nullable[p.name] =3D 1
+        while True:
+            for p in self.grammar.Productions[1:]:
+                if p.len =3D=3D 0:
+                    nullable.add(p.name)
                     continue
-               for t in p.prod:
-                    if not t in nullable: break
-               else:
-                    nullable[p.name] =3D 1
-           if len(nullable) =3D=3D num_nullable: break
-           num_nullable =3D len(nullable)
+                for t in p.prod:
+                    if t not in nullable:
+                        break
+                else:
+                    nullable.add(p.name)
+            if len(nullable) =3D=3D num_nullable:
+                break
+            num_nullable =3D len(nullable)
         return nullable
=20
     # ------------------------------------------------------------------=
-----------
@@ -2114,16 +2280,16 @@ class LRGeneratedTable(LRTable):
     # The input C is the set of LR(0) items.
     # ------------------------------------------------------------------=
-----------
=20
-    def find_nonterminal_transitions(self,C):
-         trans =3D []
-         for state in range(len(C)):
-             for p in C[state]:
-                 if p.lr_index < p.len - 1:
-                      t =3D (state,p.prod[p.lr_index+1])
-                      if t[1] in self.grammar.Nonterminals:
-                            if t not in trans: trans.append(t)
-             state =3D state + 1
-         return trans
+    def find_nonterminal_transitions(self, C):
+        trans =3D []
+        for stateno, state in enumerate(C):
+            for p in state:
+                if p.lr_index < p.len - 1:
+                    t =3D (stateno, p.prod[p.lr_index+1])
+                    if t[1] in self.grammar.Nonterminals:
+                        if t not in trans:
+                            trans.append(t)
+        return trans
=20
     # ------------------------------------------------------------------=
-----------
     # dr_relation()
@@ -2134,21 +2300,22 @@ class LRGeneratedTable(LRTable):
     # Returns a list of terminals.
     # ------------------------------------------------------------------=
-----------
=20
-    def dr_relation(self,C,trans,nullable):
-        dr_set =3D { }
-        state,N =3D trans
+    def dr_relation(self, C, trans, nullable):
+        dr_set =3D {}
+        state, N =3D trans
         terms =3D []
=20
-        g =3D self.lr0_goto(C[state],N)
+        g =3D self.lr0_goto(C[state], N)
         for p in g:
-           if p.lr_index < p.len - 1:
-               a =3D p.prod[p.lr_index+1]
-               if a in self.grammar.Terminals:
-                   if a not in terms: terms.append(a)
+            if p.lr_index < p.len - 1:
+                a =3D p.prod[p.lr_index+1]
+                if a in self.grammar.Terminals:
+                    if a not in terms:
+                        terms.append(a)
=20
         # This extra bit is to handle the start state
         if state =3D=3D 0 and N =3D=3D self.grammar.Productions[0].prod[=
0]:
-           terms.append('$end')
+            terms.append('$end')
=20
         return terms
=20
@@ -2158,18 +2325,18 @@ class LRGeneratedTable(LRTable):
     # Computes the READS() relation (p,A) READS (t,C).
     # ------------------------------------------------------------------=
-----------
=20
-    def reads_relation(self,C, trans, empty):
+    def reads_relation(self, C, trans, empty):
         # Look for empty transitions
         rel =3D []
         state, N =3D trans
=20
-        g =3D self.lr0_goto(C[state],N)
-        j =3D self.lr0_cidhash.get(id(g),-1)
+        g =3D self.lr0_goto(C[state], N)
+        j =3D self.lr0_cidhash.get(id(g), -1)
         for p in g:
             if p.lr_index < p.len - 1:
-                 a =3D p.prod[p.lr_index + 1]
-                 if a in empty:
-                      rel.append((j,a))
+                a =3D p.prod[p.lr_index + 1]
+                if a in empty:
+                    rel.append((j, a))
=20
         return rel
=20
@@ -2201,8 +2368,7 @@ class LRGeneratedTable(LRTable):
     #
     # ------------------------------------------------------------------=
-----------
=20
-    def compute_lookback_includes(self,C,trans,nullable):
-
+    def compute_lookback_includes(self, C, trans, nullable):
         lookdict =3D {}          # Dictionary of lookback relations
         includedict =3D {}       # Dictionary of include relations
=20
@@ -2212,11 +2378,12 @@ class LRGeneratedTable(LRTable):
             dtrans[t] =3D 1
=20
         # Loop over all transitions and compute lookbacks and includes
-        for state,N in trans:
+        for state, N in trans:
             lookb =3D []
             includes =3D []
             for p in C[state]:
-                if p.name !=3D N: continue
+                if p.name !=3D N:
+                    continue
=20
                 # Okay, we have a name match.  We now follow the product=
ion all the way
                 # through the state machine until we get the . on the ri=
ght hand side
@@ -2224,44 +2391,50 @@ class LRGeneratedTable(LRTable):
                 lr_index =3D p.lr_index
                 j =3D state
                 while lr_index < p.len - 1:
-                     lr_index =3D lr_index + 1
-                     t =3D p.prod[lr_index]
-
-                     # Check to see if this symbol and state are a non-t=
erminal transition
-                     if (j,t) in dtrans:
-                           # Yes.  Okay, there is some chance that this =
is an includes relation
-                           # the only way to know for certain is whether=
 the rest of the
-                           # production derives empty
-
-                           li =3D lr_index + 1
-                           while li < p.len:
-                                if p.prod[li] in self.grammar.Terminals:=
 break      # No forget it
-                                if not p.prod[li] in nullable: break
-                                li =3D li + 1
-                           else:
-                                # Appears to be a relation between (j,t)=
 and (state,N)
-                                includes.append((j,t))
-
-                     g =3D self.lr0_goto(C[j],t)               # Go to n=
ext set
-                     j =3D self.lr0_cidhash.get(id(g),-1)     # Go to ne=
xt state
+                    lr_index =3D lr_index + 1
+                    t =3D p.prod[lr_index]
+
+                    # Check to see if this symbol and state are a non-te=
rminal transition
+                    if (j, t) in dtrans:
+                        # Yes.  Okay, there is some chance that this is =
an includes relation
+                        # the only way to know for certain is whether th=
e rest of the
+                        # production derives empty
+
+                        li =3D lr_index + 1
+                        while li < p.len:
+                            if p.prod[li] in self.grammar.Terminals:
+                                break      # No forget it
+                            if p.prod[li] not in nullable:
+                                break
+                            li =3D li + 1
+                        else:
+                            # Appears to be a relation between (j,t) and=
 (state,N)
+                            includes.append((j, t))
+
+                    g =3D self.lr0_goto(C[j], t)               # Go to n=
ext set
+                    j =3D self.lr0_cidhash.get(id(g), -1)      # Go to n=
ext state
=20
                 # When we get here, j is the final state, now we have to=
 locate the production
                 for r in C[j]:
-                     if r.name !=3D p.name: continue
-                     if r.len !=3D p.len:   continue
-                     i =3D 0
-                     # This look is comparing a production ". A B C" wit=
h "A B C ."
-                     while i < r.lr_index:
-                          if r.prod[i] !=3D p.prod[i+1]: break
-                          i =3D i + 1
-                     else:
-                          lookb.append((j,r))
+                    if r.name !=3D p.name:
+                        continue
+                    if r.len !=3D p.len:
+                        continue
+                    i =3D 0
+                    # This look is comparing a production ". A B C" with=
 "A B C ."
+                    while i < r.lr_index:
+                        if r.prod[i] !=3D p.prod[i+1]:
+                            break
+                        i =3D i + 1
+                    else:
+                        lookb.append((j, r))
             for i in includes:
-                 if not i in includedict: includedict[i] =3D []
-                 includedict[i].append((state,N))
-            lookdict[(state,N)] =3D lookb
+                if i not in includedict:
+                    includedict[i] =3D []
+                includedict[i].append((state, N))
+            lookdict[(state, N)] =3D lookb
=20
-        return lookdict,includedict
+        return lookdict, includedict
=20
     # ------------------------------------------------------------------=
-----------
     # compute_read_sets()
@@ -2275,10 +2448,10 @@ class LRGeneratedTable(LRTable):
     # Returns a set containing the read sets
     # ------------------------------------------------------------------=
-----------
=20
-    def compute_read_sets(self,C, ntrans, nullable):
-        FP =3D lambda x: self.dr_relation(C,x,nullable)
-        R =3D  lambda x: self.reads_relation(C,x,nullable)
-        F =3D digraph(ntrans,R,FP)
+    def compute_read_sets(self, C, ntrans, nullable):
+        FP =3D lambda x: self.dr_relation(C, x, nullable)
+        R =3D  lambda x: self.reads_relation(C, x, nullable)
+        F =3D digraph(ntrans, R, FP)
         return F
=20
     # ------------------------------------------------------------------=
-----------
@@ -2297,11 +2470,11 @@ class LRGeneratedTable(LRTable):
     # Returns a set containing the follow sets
     # ------------------------------------------------------------------=
-----------
=20
-    def compute_follow_sets(self,ntrans,readsets,inclsets):
-         FP =3D lambda x: readsets[x]
-         R  =3D lambda x: inclsets.get(x,[])
-         F =3D digraph(ntrans,R,FP)
-         return F
+    def compute_follow_sets(self, ntrans, readsets, inclsets):
+        FP =3D lambda x: readsets[x]
+        R  =3D lambda x: inclsets.get(x, [])
+        F =3D digraph(ntrans, R, FP)
+        return F
=20
     # ------------------------------------------------------------------=
-----------
     # add_lookaheads()
@@ -2315,15 +2488,16 @@ class LRGeneratedTable(LRTable):
     # in the lookbacks set
     # ------------------------------------------------------------------=
-----------
=20
-    def add_lookaheads(self,lookbacks,followset):
-        for trans,lb in lookbacks.items():
+    def add_lookaheads(self, lookbacks, followset):
+        for trans, lb in lookbacks.items():
             # Loop over productions in lookback
-            for state,p in lb:
-                 if not state in p.lookaheads:
-                      p.lookaheads[state] =3D []
-                 f =3D followset.get(trans,[])
-                 for a in f:
-                      if a not in p.lookaheads[state]: p.lookaheads[stat=
e].append(a)
+            for state, p in lb:
+                if state not in p.lookaheads:
+                    p.lookaheads[state] =3D []
+                f =3D followset.get(trans, [])
+                for a in f:
+                    if a not in p.lookaheads[state]:
+                        p.lookaheads[state].append(a)
=20
     # ------------------------------------------------------------------=
-----------
     # add_lalr_lookaheads()
@@ -2332,7 +2506,7 @@ class LRGeneratedTable(LRTable):
     # with LALR parsing
     # ------------------------------------------------------------------=
-----------
=20
-    def add_lalr_lookaheads(self,C):
+    def add_lalr_lookaheads(self, C):
         # Determine all of the nullable nonterminals
         nullable =3D self.compute_nullable_nonterminals()
=20
@@ -2340,16 +2514,16 @@ class LRGeneratedTable(LRTable):
         trans =3D self.find_nonterminal_transitions(C)
=20
         # Compute read sets
-        readsets =3D self.compute_read_sets(C,trans,nullable)
+        readsets =3D self.compute_read_sets(C, trans, nullable)
=20
         # Compute lookback/includes relations
-        lookd, included =3D self.compute_lookback_includes(C,trans,nulla=
ble)
+        lookd, included =3D self.compute_lookback_includes(C, trans, nul=
lable)
=20
         # Compute LALR FOLLOW sets
-        followsets =3D self.compute_follow_sets(trans,readsets,included)
+        followsets =3D self.compute_follow_sets(trans, readsets, include=
d)
=20
         # Add all of the lookaheads
-        self.add_lookaheads(lookd,followsets)
+        self.add_lookaheads(lookd, followsets)
=20
     # ------------------------------------------------------------------=
-----------
     # lr_parse_table()
@@ -2363,9 +2537,9 @@ class LRGeneratedTable(LRTable):
         action =3D self.lr_action       # Action array
         log    =3D self.log             # Logger for output
=20
-        actionp =3D { }                 # Action production array (tempo=
rary)
-       =20
-        log.info("Parsing method: %s", self.lr_method)
+        actionp =3D {}                  # Action production array (tempo=
rary)
+
+        log.info('Parsing method: %s', self.lr_method)
=20
         # Step 1: Construct C =3D { I0, I1, ... IN}, collection of LR(0)=
 items
         # This determines the number of states
@@ -2379,23 +2553,23 @@ class LRGeneratedTable(LRTable):
         st =3D 0
         for I in C:
             # Loop over each production in I
-            actlist =3D [ ]              # List of actions
-            st_action  =3D { }
-            st_actionp =3D { }
-            st_goto    =3D { }
-            log.info("")
-            log.info("state %d", st)
-            log.info("")
+            actlist =3D []              # List of actions
+            st_action  =3D {}
+            st_actionp =3D {}
+            st_goto    =3D {}
+            log.info('')
+            log.info('state %d', st)
+            log.info('')
             for p in I:
-                log.info("    (%d) %s", p.number, str(p))
-            log.info("")
+                log.info('    (%d) %s', p.number, p)
+            log.info('')
=20
             for p in I:
                     if p.len =3D=3D p.lr_index + 1:
                         if p.name =3D=3D "S'":
                             # Start symbol. Accept!
-                            st_action["$end"] =3D 0
-                            st_actionp["$end"] =3D p
+                            st_action['$end'] =3D 0
+                            st_actionp['$end'] =3D p
                         else:
                             # We are at the end of a production.  Reduce=
!
                             if self.lr_method =3D=3D 'LALR':
@@ -2403,31 +2577,36 @@ class LRGeneratedTable(LRTable):
                             else:
                                 laheads =3D self.grammar.Follow[p.name]
                             for a in laheads:
-                                actlist.append((a,p,"reduce using rule %=
d (%s)" % (p.number,p)))
-                                r =3D st_action.get(a,None)
+                                actlist.append((a, p, 'reduce using rule=
 %d (%s)' % (p.number, p)))
+                                r =3D st_action.get(a)
                                 if r is not None:
                                     # Whoa. Have a shift/reduce or reduc=
e/reduce conflict
                                     if r > 0:
                                         # Need to decide on shift or red=
uce here
                                         # By default we favor shifting. =
Need to add
                                         # some precedence rules here.
-                                        sprec,slevel =3D Productions[st_=
actionp[a].number].prec
-                                        rprec,rlevel =3D Precedence.get(=
a,('right',0))
+
+                                        # Shift precedence comes from th=
e token
+                                        sprec, slevel =3D Precedence.get=
(a, ('right', 0))
+
+                                        # Reduce precedence comes from r=
ule being reduced (p)
+                                        rprec, rlevel =3D Productions[p.=
number].prec
+
                                         if (slevel < rlevel) or ((slevel=
 =3D=3D rlevel) and (rprec =3D=3D 'left')):
                                             # We really need to reduce h=
ere.
                                             st_action[a] =3D -p.number
                                             st_actionp[a] =3D p
                                             if not slevel and not rlevel=
:
-                                                log.info("  ! shift/redu=
ce conflict for %s resolved as reduce",a)
-                                                self.sr_conflicts.append=
((st,a,'reduce'))
+                                                log.info('  ! shift/redu=
ce conflict for %s resolved as reduce', a)
+                                                self.sr_conflicts.append=
((st, a, 'reduce'))
                                             Productions[p.number].reduce=
d +=3D 1
                                         elif (slevel =3D=3D rlevel) and =
(rprec =3D=3D 'nonassoc'):
                                             st_action[a] =3D None
                                         else:
                                             # Hmmm. Guess we'll keep the=
 shift
                                             if not rlevel:
-                                                log.info("  ! shift/redu=
ce conflict for %s resolved as shift",a)
-                                                self.sr_conflicts.append=
((st,a,'shift'))
+                                                log.info('  ! shift/redu=
ce conflict for %s resolved as shift', a)
+                                                self.sr_conflicts.append=
((st, a, 'shift'))
                                     elif r < 0:
                                         # Reduce/reduce conflict.   In t=
his case, we favor the rule
                                         # that was defined first in the =
grammar file
@@ -2436,15 +2615,16 @@ class LRGeneratedTable(LRTable):
                                         if oldp.line > pp.line:
                                             st_action[a] =3D -p.number
                                             st_actionp[a] =3D p
-                                            chosenp,rejectp =3D pp,oldp
+                                            chosenp, rejectp =3D pp, old=
p
                                             Productions[p.number].reduce=
d +=3D 1
                                             Productions[oldp.number].red=
uced -=3D 1
                                         else:
-                                            chosenp,rejectp =3D oldp,pp
-                                        self.rr_conflicts.append((st,cho=
senp,rejectp))
-                                        log.info("  ! reduce/reduce conf=
lict for %s resolved using rule %d (%s)", a,st_actionp[a].number, st_acti=
onp[a])
+                                            chosenp, rejectp =3D oldp, p=
p
+                                        self.rr_conflicts.append((st, ch=
osenp, rejectp))
+                                        log.info('  ! reduce/reduce conf=
lict for %s resolved using rule %d (%s)',
+                                                 a, st_actionp[a].number=
, st_actionp[a])
                                     else:
-                                        raise LALRError("Unknown conflic=
t in state %d" % st)
+                                        raise LALRError('Unknown conflic=
t in state %d' % st)
                                 else:
                                     st_action[a] =3D -p.number
                                     st_actionp[a] =3D p
@@ -2453,99 +2633,106 @@ class LRGeneratedTable(LRTable):
                         i =3D p.lr_index
                         a =3D p.prod[i+1]       # Get symbol right after=
 the "."
                         if a in self.grammar.Terminals:
-                            g =3D self.lr0_goto(I,a)
-                            j =3D self.lr0_cidhash.get(id(g),-1)
+                            g =3D self.lr0_goto(I, a)
+                            j =3D self.lr0_cidhash.get(id(g), -1)
                             if j >=3D 0:
                                 # We are in a shift state
-                                actlist.append((a,p,"shift and go to sta=
te %d" % j))
-                                r =3D st_action.get(a,None)
+                                actlist.append((a, p, 'shift and go to s=
tate %d' % j))
+                                r =3D st_action.get(a)
                                 if r is not None:
                                     # Whoa have a shift/reduce or shift/=
shift conflict
                                     if r > 0:
                                         if r !=3D j:
-                                            raise LALRError("Shift/shift=
 conflict in state %d" % st)
+                                            raise LALRError('Shift/shift=
 conflict in state %d' % st)
                                     elif r < 0:
                                         # Do a precedence check.
                                         #   -  if precedence of reduce r=
ule is higher, we reduce.
                                         #   -  if precedence of reduce i=
s same and left assoc, we reduce.
                                         #   -  otherwise we shift
-                                        rprec,rlevel =3D Productions[st_=
actionp[a].number].prec
-                                        sprec,slevel =3D Precedence.get(=
a,('right',0))
+
+                                        # Shift precedence comes from th=
e token
+                                        sprec, slevel =3D Precedence.get=
(a, ('right', 0))
+
+                                        # Reduce precedence comes from t=
he rule that could have been reduced
+                                        rprec, rlevel =3D Productions[st=
_actionp[a].number].prec
+
                                         if (slevel > rlevel) or ((slevel=
 =3D=3D rlevel) and (rprec =3D=3D 'right')):
                                             # We decide to shift here...=
 highest precedence to shift
                                             Productions[st_actionp[a].nu=
mber].reduced -=3D 1
                                             st_action[a] =3D j
                                             st_actionp[a] =3D p
                                             if not rlevel:
-                                                log.info("  ! shift/redu=
ce conflict for %s resolved as shift",a)
-                                                self.sr_conflicts.append=
((st,a,'shift'))
+                                                log.info('  ! shift/redu=
ce conflict for %s resolved as shift', a)
+                                                self.sr_conflicts.append=
((st, a, 'shift'))
                                         elif (slevel =3D=3D rlevel) and =
(rprec =3D=3D 'nonassoc'):
                                             st_action[a] =3D None
                                         else:
                                             # Hmmm. Guess we'll keep the=
 reduce
                                             if not slevel and not rlevel=
:
-                                                log.info("  ! shift/redu=
ce conflict for %s resolved as reduce",a)
-                                                self.sr_conflicts.append=
((st,a,'reduce'))
+                                                log.info('  ! shift/redu=
ce conflict for %s resolved as reduce', a)
+                                                self.sr_conflicts.append=
((st, a, 'reduce'))
=20
                                     else:
-                                        raise LALRError("Unknown conflic=
t in state %d" % st)
+                                        raise LALRError('Unknown conflic=
t in state %d' % st)
                                 else:
                                     st_action[a] =3D j
                                     st_actionp[a] =3D p
=20
             # Print the actions associated with each terminal
-            _actprint =3D { }
-            for a,p,m in actlist:
+            _actprint =3D {}
+            for a, p, m in actlist:
                 if a in st_action:
                     if p is st_actionp[a]:
-                        log.info("    %-15s %s",a,m)
-                        _actprint[(a,m)] =3D 1
-            log.info("")
+                        log.info('    %-15s %s', a, m)
+                        _actprint[(a, m)] =3D 1
+            log.info('')
             # Print the actions that were not used. (debugging)
             not_used =3D 0
-            for a,p,m in actlist:
+            for a, p, m in actlist:
                 if a in st_action:
                     if p is not st_actionp[a]:
-                        if not (a,m) in _actprint:
-                            log.debug("  ! %-15s [ %s ]",a,m)
+                        if not (a, m) in _actprint:
+                            log.debug('  ! %-15s [ %s ]', a, m)
                             not_used =3D 1
-                            _actprint[(a,m)] =3D 1
+                            _actprint[(a, m)] =3D 1
             if not_used:
-                log.debug("")
+                log.debug('')
=20
             # Construct the goto table for this state
=20
-            nkeys =3D { }
+            nkeys =3D {}
             for ii in I:
                 for s in ii.usyms:
                     if s in self.grammar.Nonterminals:
                         nkeys[s] =3D None
             for n in nkeys:
-                g =3D self.lr0_goto(I,n)
-                j =3D self.lr0_cidhash.get(id(g),-1)
+                g =3D self.lr0_goto(I, n)
+                j =3D self.lr0_cidhash.get(id(g), -1)
                 if j >=3D 0:
                     st_goto[n] =3D j
-                    log.info("    %-30s shift and go to state %d",n,j)
+                    log.info('    %-30s shift and go to state %d', n, j)
=20
             action[st] =3D st_action
             actionp[st] =3D st_actionp
             goto[st] =3D st_goto
             st +=3D 1
=20
-
     # ------------------------------------------------------------------=
-----------
     # write()
     #
     # This function writes the LR parsing tables to a file
     # ------------------------------------------------------------------=
-----------
=20
-    def write_table(self,modulename,outputdir=3D'',signature=3D""):
-        basemodulename =3D modulename.split(".")[-1]
-        filename =3D os.path.join(outputdir,basemodulename) + ".py"
+    def write_table(self, tabmodule, outputdir=3D'', signature=3D''):
+        if isinstance(tabmodule, types.ModuleType):
+            raise IOError("Won't overwrite existing tabmodule")
+
+        basemodulename =3D tabmodule.split('.')[-1]
+        filename =3D os.path.join(outputdir, basemodulename) + '.py'
         try:
-            f =3D open(filename,"w")
+            f =3D open(filename, 'w')
=20
-            f.write("""
+            f.write('''
 # %s
 # This file is automatically generated. Do not edit.
 _tabversion =3D %r
@@ -2553,105 +2740,103 @@ _tabversion =3D %r
 _lr_method =3D %r
=20
 _lr_signature =3D %r
-    """ % (filename, __tabversion__, self.lr_method, signature))
+    ''' % (os.path.basename(filename), __tabversion__, self.lr_method, s=
ignature))
=20
             # Change smaller to 0 to go back to original tables
             smaller =3D 1
=20
             # Factor out names to try and make smaller
             if smaller:
-                items =3D { }
-
-                for s,nd in self.lr_action.items():
-                   for name,v in nd.items():
-                      i =3D items.get(name)
-                      if not i:
-                         i =3D ([],[])
-                         items[name] =3D i
-                      i[0].append(s)
-                      i[1].append(v)
-
-                f.write("\n_lr_action_items =3D {")
-                for k,v in items.items():
-                    f.write("%r:([" % k)
+                items =3D {}
+
+                for s, nd in self.lr_action.items():
+                    for name, v in nd.items():
+                        i =3D items.get(name)
+                        if not i:
+                            i =3D ([], [])
+                            items[name] =3D i
+                        i[0].append(s)
+                        i[1].append(v)
+
+                f.write('\n_lr_action_items =3D {')
+                for k, v in items.items():
+                    f.write('%r:([' % k)
                     for i in v[0]:
-                        f.write("%r," % i)
-                    f.write("],[")
+                        f.write('%r,' % i)
+                    f.write('],[')
                     for i in v[1]:
-                        f.write("%r," % i)
+                        f.write('%r,' % i)
=20
-                    f.write("]),")
-                f.write("}\n")
+                    f.write(']),')
+                f.write('}\n')
=20
-                f.write("""
-_lr_action =3D { }
+                f.write('''
+_lr_action =3D {}
 for _k, _v in _lr_action_items.items():
    for _x,_y in zip(_v[0],_v[1]):
-      if not _x in _lr_action:  _lr_action[_x] =3D { }
+      if not _x in _lr_action:  _lr_action[_x] =3D {}
       _lr_action[_x][_k] =3D _y
 del _lr_action_items
-""")
+''')
=20
             else:
-                f.write("\n_lr_action =3D { ");
-                for k,v in self.lr_action.items():
-                    f.write("(%r,%r):%r," % (k[0],k[1],v))
-                f.write("}\n");
+                f.write('\n_lr_action =3D { ')
+                for k, v in self.lr_action.items():
+                    f.write('(%r,%r):%r,' % (k[0], k[1], v))
+                f.write('}\n')
=20
             if smaller:
                 # Factor out names to try and make smaller
-                items =3D { }
-
-                for s,nd in self.lr_goto.items():
-                   for name,v in nd.items():
-                      i =3D items.get(name)
-                      if not i:
-                         i =3D ([],[])
-                         items[name] =3D i
-                      i[0].append(s)
-                      i[1].append(v)
-
-                f.write("\n_lr_goto_items =3D {")
-                for k,v in items.items():
-                    f.write("%r:([" % k)
+                items =3D {}
+
+                for s, nd in self.lr_goto.items():
+                    for name, v in nd.items():
+                        i =3D items.get(name)
+                        if not i:
+                            i =3D ([], [])
+                            items[name] =3D i
+                        i[0].append(s)
+                        i[1].append(v)
+
+                f.write('\n_lr_goto_items =3D {')
+                for k, v in items.items():
+                    f.write('%r:([' % k)
                     for i in v[0]:
-                        f.write("%r," % i)
-                    f.write("],[")
+                        f.write('%r,' % i)
+                    f.write('],[')
                     for i in v[1]:
-                        f.write("%r," % i)
+                        f.write('%r,' % i)
=20
-                    f.write("]),")
-                f.write("}\n")
+                    f.write(']),')
+                f.write('}\n')
=20
-                f.write("""
-_lr_goto =3D { }
+                f.write('''
+_lr_goto =3D {}
 for _k, _v in _lr_goto_items.items():
-   for _x,_y in zip(_v[0],_v[1]):
-       if not _x in _lr_goto: _lr_goto[_x] =3D { }
+   for _x, _y in zip(_v[0], _v[1]):
+       if not _x in _lr_goto: _lr_goto[_x] =3D {}
        _lr_goto[_x][_k] =3D _y
 del _lr_goto_items
-""")
+''')
             else:
-                f.write("\n_lr_goto =3D { ");
-                for k,v in self.lr_goto.items():
-                    f.write("(%r,%r):%r," % (k[0],k[1],v))
-                f.write("}\n");
+                f.write('\n_lr_goto =3D { ')
+                for k, v in self.lr_goto.items():
+                    f.write('(%r,%r):%r,' % (k[0], k[1], v))
+                f.write('}\n')
=20
             # Write production table
-            f.write("_lr_productions =3D [\n")
+            f.write('_lr_productions =3D [\n')
             for p in self.lr_productions:
                 if p.func:
-                    f.write("  (%r,%r,%d,%r,%r,%d),\n" % (p.str,p.name, =
p.len, p.func,p.file,p.line))
+                    f.write('  (%r,%r,%d,%r,%r,%d),\n' % (p.str, p.name,=
 p.len,
+                                                          p.func, os.pat=
h.basename(p.file), p.line))
                 else:
-                    f.write("  (%r,%r,%d,None,None,None),\n" % (str(p),p=
.name, p.len))
-            f.write("]\n")
+                    f.write('  (%r,%r,%d,None,None,None),\n' % (str(p), =
p.name, p.len))
+            f.write(']\n')
             f.close()
=20
-        except IOError:
-            e =3D sys.exc_info()[1]
-            sys.stderr.write("Unable to create '%s'\n" % filename)
-            sys.stderr.write(str(e)+"\n")
-            return
+        except IOError as e:
+            raise
=20
=20
     # ------------------------------------------------------------------=
-----------
@@ -2660,26 +2845,25 @@ del _lr_goto_items
     # This function pickles the LR parsing tables to a supplied file obj=
ect
     # ------------------------------------------------------------------=
-----------
=20
-    def pickle_table(self,filename,signature=3D""):
+    def pickle_table(self, filename, signature=3D''):
         try:
             import cPickle as pickle
         except ImportError:
             import pickle
-        outf =3D open(filename,"wb")
-        pickle.dump(__tabversion__,outf,pickle_protocol)
-        pickle.dump(self.lr_method,outf,pickle_protocol)
-        pickle.dump(signature,outf,pickle_protocol)
-        pickle.dump(self.lr_action,outf,pickle_protocol)
-        pickle.dump(self.lr_goto,outf,pickle_protocol)
-
-        outp =3D []
-        for p in self.lr_productions:
-            if p.func:
-                outp.append((p.str,p.name, p.len, p.func,p.file,p.line))
-            else:
-                outp.append((str(p),p.name,p.len,None,None,None))
-        pickle.dump(outp,outf,pickle_protocol)
-        outf.close()
+        with open(filename, 'wb') as outf:
+            pickle.dump(__tabversion__, outf, pickle_protocol)
+            pickle.dump(self.lr_method, outf, pickle_protocol)
+            pickle.dump(signature, outf, pickle_protocol)
+            pickle.dump(self.lr_action, outf, pickle_protocol)
+            pickle.dump(self.lr_goto, outf, pickle_protocol)
+
+            outp =3D []
+            for p in self.lr_productions:
+                if p.func:
+                    outp.append((p.str, p.name, p.len, p.func, os.path.b=
asename(p.file), p.line))
+                else:
+                    outp.append((str(p), p.name, p.len, None, None, None=
))
+            pickle.dump(outp, outf, pickle_protocol)
=20
 # ----------------------------------------------------------------------=
-------
 #                            =3D=3D=3D INTROSPECTION =3D=3D=3D
@@ -2697,26 +2881,18 @@ del _lr_goto_items
 # ----------------------------------------------------------------------=
-------
=20
 def get_caller_module_dict(levels):
-    try:
-        raise RuntimeError
-    except RuntimeError:
-        e,b,t =3D sys.exc_info()
-        f =3D t.tb_frame
-        while levels > 0:
-            f =3D f.f_back                  =20
-            levels -=3D 1
-        ldict =3D f.f_globals.copy()
-        if f.f_globals !=3D f.f_locals:
-            ldict.update(f.f_locals)
-
-        return ldict
+    f =3D sys._getframe(levels)
+    ldict =3D f.f_globals.copy()
+    if f.f_globals !=3D f.f_locals:
+        ldict.update(f.f_locals)
+    return ldict
=20
 # ----------------------------------------------------------------------=
-------
 # parse_grammar()
 #
 # This takes a raw grammar rule string and parses it into production dat=
a
 # ----------------------------------------------------------------------=
-------
-def parse_grammar(doc,file,line):
+def parse_grammar(doc, file, line):
     grammar =3D []
     # Split the doc string into lines
     pstrings =3D doc.splitlines()
@@ -2725,12 +2901,13 @@ def parse_grammar(doc,file,line):
     for ps in pstrings:
         dline +=3D 1
         p =3D ps.split()
-        if not p: continue
+        if not p:
+            continue
         try:
             if p[0] =3D=3D '|':
                 # This is a continuation of a previous rule
                 if not lastp:
-                    raise SyntaxError("%s:%d: Misplaced '|'" % (file,dli=
ne))
+                    raise SyntaxError("%s:%d: Misplaced '|'" % (file, dl=
ine))
                 prodname =3D lastp
                 syms =3D p[1:]
             else:
@@ -2739,13 +2916,13 @@ def parse_grammar(doc,file,line):
                 syms   =3D p[2:]
                 assign =3D p[1]
                 if assign !=3D ':' and assign !=3D '::=3D':
-                    raise SyntaxError("%s:%d: Syntax error. Expected ':'=
" % (file,dline))
+                    raise SyntaxError("%s:%d: Syntax error. Expected ':'=
" % (file, dline))
=20
-            grammar.append((file,dline,prodname,syms))
+            grammar.append((file, dline, prodname, syms))
         except SyntaxError:
             raise
         except Exception:
-            raise SyntaxError("%s:%d: Syntax error in rule '%s'" % (file=
,dline,ps.strip()))
+            raise SyntaxError('%s:%d: Syntax error in rule %r' % (file, =
dline, ps.strip()))
=20
     return grammar
=20
@@ -2757,14 +2934,14 @@ def parse_grammar(doc,file,line):
 # etc.
 # ----------------------------------------------------------------------=
-------
 class ParserReflect(object):
-    def __init__(self,pdict,log=3DNone):
+    def __init__(self, pdict, log=3DNone):
         self.pdict      =3D pdict
         self.start      =3D None
         self.error_func =3D None
         self.tokens     =3D None
-        self.files      =3D {}
+        self.modules    =3D set()
         self.grammar    =3D []
-        self.error      =3D 0
+        self.error      =3D False
=20
         if log is None:
             self.log =3D PlyLogger(sys.stderr)
@@ -2778,7 +2955,7 @@ class ParserReflect(object):
         self.get_tokens()
         self.get_precedence()
         self.get_pfunctions()
-       =20
+
     # Validate all of the information
     def validate_all(self):
         self.validate_start()
@@ -2786,36 +2963,28 @@ class ParserReflect(object):
         self.validate_tokens()
         self.validate_precedence()
         self.validate_pfunctions()
-        self.validate_files()
+        self.validate_modules()
         return self.error
=20
     # Compute a signature over the grammar
     def signature(self):
-        try:
-            import hashlib
-        except ImportError:
-            raise RuntimeError("Unable to import hashlib")
-        try:
-            sig =3D hashlib.new('MD5', usedforsecurity=3DFalse)
-        except TypeError:
-            # Some configurations don't appear to support two arguments
-            sig =3D hashlib.new('MD5')
+        parts =3D []
         try:
             if self.start:
-                sig.update(self.start.encode('latin-1'))
+                parts.append(self.start)
             if self.prec:
-                sig.update("".join(["".join(p) for p in self.prec]).enco=
de('latin-1'))
+                parts.append(''.join([''.join(p) for p in self.prec]))
             if self.tokens:
-                sig.update(" ".join(self.tokens).encode('latin-1'))
+                parts.append(' '.join(self.tokens))
             for f in self.pfuncs:
                 if f[3]:
-                    sig.update(f[3].encode('latin-1'))
-        except (TypeError,ValueError):
+                    parts.append(f[3])
+        except (TypeError, ValueError):
             pass
-        return sig.digest()
+        return ''.join(parts)
=20
     # ------------------------------------------------------------------=
-----------
-    # validate_file()
+    # validate_modules()
     #
     # This method checks to see if there are duplicated p_rulename() fun=
ctions
     # in the parser module file.  Without this function, it is really ea=
sy for
@@ -2825,32 +2994,29 @@ class ParserReflect(object):
     # to try and detect duplicates.
     # ------------------------------------------------------------------=
-----------
=20
-    def validate_files(self):
+    def validate_modules(self):
         # Match def p_funcname(
         fre =3D re.compile(r'\s*def\s+(p_[a-zA-Z_0-9]*)\(')
=20
-        for filename in self.files.keys():
-            base,ext =3D os.path.splitext(filename)
-            if ext !=3D '.py': return 1          # No idea. Assume it's =
okay.
-
+        for module in self.modules:
             try:
-                f =3D open(filename)
-                lines =3D f.readlines()
-                f.close()
+                lines, linen =3D inspect.getsourcelines(module)
             except IOError:
                 continue
=20
-            counthash =3D { }
-            for linen,l in enumerate(lines):
+            counthash =3D {}
+            for linen, line in enumerate(lines):
                 linen +=3D 1
-                m =3D fre.match(l)
+                m =3D fre.match(line)
                 if m:
                     name =3D m.group(1)
                     prev =3D counthash.get(name)
                     if not prev:
                         counthash[name] =3D linen
                     else:
-                        self.log.warning("%s:%d: Function %s redefined. =
Previously defined on line %d", filename,linen,name,prev)
+                        filename =3D inspect.getsourcefile(module)
+                        self.log.warning('%s:%d: Function %s redefined. =
Previously defined on line %d',
+                                         filename, linen, name, prev)
=20
     # Get the start symbol
     def get_start(self):
@@ -2859,7 +3025,7 @@ class ParserReflect(object):
     # Validate the start symbol
     def validate_start(self):
         if self.start is not None:
-            if not isinstance(self.start,str):
+            if not isinstance(self.start, string_types):
                 self.log.error("'start' must be a string")
=20
     # Look for error handler
@@ -2869,39 +3035,41 @@ class ParserReflect(object):
     # Validate the error function
     def validate_error_func(self):
         if self.error_func:
-            if isinstance(self.error_func,types.FunctionType):
+            if isinstance(self.error_func, types.FunctionType):
                 ismethod =3D 0
             elif isinstance(self.error_func, types.MethodType):
                 ismethod =3D 1
             else:
                 self.log.error("'p_error' defined, but is not a function=
 or method")
-                self.error =3D 1
+                self.error =3D True
                 return
=20
-            eline =3D func_code(self.error_func).co_firstlineno
-            efile =3D func_code(self.error_func).co_filename
-            self.files[efile] =3D 1
+            eline =3D self.error_func.__code__.co_firstlineno
+            efile =3D self.error_func.__code__.co_filename
+            module =3D inspect.getmodule(self.error_func)
+            self.modules.add(module)
=20
-            if (func_code(self.error_func).co_argcount !=3D 1+ismethod):
-                self.log.error("%s:%d: p_error() requires 1 argument",ef=
ile,eline)
-                self.error =3D 1
+            argcount =3D self.error_func.__code__.co_argcount - ismethod
+            if argcount !=3D 1:
+                self.log.error('%s:%d: p_error() requires 1 argument', e=
file, eline)
+                self.error =3D True
=20
     # Get the tokens map
     def get_tokens(self):
-        tokens =3D self.pdict.get("tokens",None)
+        tokens =3D self.pdict.get('tokens')
         if not tokens:
-            self.log.error("No token list is defined")
-            self.error =3D 1
+            self.log.error('No token list is defined')
+            self.error =3D True
             return
=20
-        if not isinstance(tokens,(list, tuple)):
-            self.log.error("tokens must be a list or tuple")
-            self.error =3D 1
+        if not isinstance(tokens, (list, tuple)):
+            self.log.error('tokens must be a list or tuple')
+            self.error =3D True
             return
-       =20
+
         if not tokens:
-            self.log.error("tokens is empty")
-            self.error =3D 1
+            self.log.error('tokens is empty')
+            self.error =3D True
             return
=20
         self.tokens =3D tokens
@@ -2911,120 +3079,129 @@ class ParserReflect(object):
         # Validate the tokens.
         if 'error' in self.tokens:
             self.log.error("Illegal token name 'error'. Is a reserved wo=
rd")
-            self.error =3D 1
+            self.error =3D True
             return
=20
-        terminals =3D {}
+        terminals =3D set()
         for n in self.tokens:
             if n in terminals:
-                self.log.warning("Token '%s' multiply defined", n)
-            terminals[n] =3D 1
+                self.log.warning('Token %r multiply defined', n)
+            terminals.add(n)
=20
     # Get the precedence map (if any)
     def get_precedence(self):
-        self.prec =3D self.pdict.get("precedence",None)
+        self.prec =3D self.pdict.get('precedence')
=20
     # Validate and parse the precedence map
     def validate_precedence(self):
         preclist =3D []
         if self.prec:
-            if not isinstance(self.prec,(list,tuple)):
-                self.log.error("precedence must be a list or tuple")
-                self.error =3D 1
+            if not isinstance(self.prec, (list, tuple)):
+                self.log.error('precedence must be a list or tuple')
+                self.error =3D True
                 return
-            for level,p in enumerate(self.prec):
-                if not isinstance(p,(list,tuple)):
-                    self.log.error("Bad precedence table")
-                    self.error =3D 1
+            for level, p in enumerate(self.prec):
+                if not isinstance(p, (list, tuple)):
+                    self.log.error('Bad precedence table')
+                    self.error =3D True
                     return
=20
                 if len(p) < 2:
-                    self.log.error("Malformed precedence entry %s. Must =
be (assoc, term, ..., term)",p)
-                    self.error =3D 1
+                    self.log.error('Malformed precedence entry %s. Must =
be (assoc, term, ..., term)', p)
+                    self.error =3D True
                     return
                 assoc =3D p[0]
-                if not isinstance(assoc,str):
-                    self.log.error("precedence associativity must be a s=
tring")
-                    self.error =3D 1
+                if not isinstance(assoc, string_types):
+                    self.log.error('precedence associativity must be a s=
tring')
+                    self.error =3D True
                     return
                 for term in p[1:]:
-                    if not isinstance(term,str):
-                        self.log.error("precedence items must be strings=
")
-                        self.error =3D 1
+                    if not isinstance(term, string_types):
+                        self.log.error('precedence items must be strings=
')
+                        self.error =3D True
                         return
-                    preclist.append((term,assoc,level+1))
+                    preclist.append((term, assoc, level+1))
         self.preclist =3D preclist
=20
     # Get all p_functions from the grammar
     def get_pfunctions(self):
         p_functions =3D []
         for name, item in self.pdict.items():
-            if name[:2] !=3D 'p_': continue
-            if name =3D=3D 'p_error': continue
-            if isinstance(item,(types.FunctionType,types.MethodType)):
-                line =3D func_code(item).co_firstlineno
-                file =3D func_code(item).co_filename
-                p_functions.append((line,file,name,item.__doc__))
-
-        # Sort all of the actions by line number
-        p_functions.sort()
+            if not name.startswith('p_') or name =3D=3D 'p_error':
+                continue
+            if isinstance(item, (types.FunctionType, types.MethodType)):
+                line =3D getattr(item, 'co_firstlineno', item.__code__.c=
o_firstlineno)
+                module =3D inspect.getmodule(item)
+                p_functions.append((line, module, name, item.__doc__))
+
+        # Sort all of the actions by line number; make sure to stringify
+        # modules to make them sortable, since `line` may not uniquely s=
ort all
+        # p functions
+        p_functions.sort(key=3Dlambda p_function: (
+            p_function[0],
+            str(p_function[1]),
+            p_function[2],
+            p_function[3]))
         self.pfuncs =3D p_functions
=20
-
     # Validate all of the p_functions
     def validate_pfunctions(self):
         grammar =3D []
         # Check for non-empty symbols
         if len(self.pfuncs) =3D=3D 0:
-            self.log.error("no rules of the form p_rulename are defined"=
)
-            self.error =3D 1
-            return=20
-       =20
-        for line, file, name, doc in self.pfuncs:
+            self.log.error('no rules of the form p_rulename are defined'=
)
+            self.error =3D True
+            return
+
+        for line, module, name, doc in self.pfuncs:
+            file =3D inspect.getsourcefile(module)
             func =3D self.pdict[name]
             if isinstance(func, types.MethodType):
                 reqargs =3D 2
             else:
                 reqargs =3D 1
-            if func_code(func).co_argcount > reqargs:
-                self.log.error("%s:%d: Rule '%s' has too many arguments"=
,file,line,func.__name__)
-                self.error =3D 1
-            elif func_code(func).co_argcount < reqargs:
-                self.log.error("%s:%d: Rule '%s' requires an argument",f=
ile,line,func.__name__)
-                self.error =3D 1
+            if func.__code__.co_argcount > reqargs:
+                self.log.error('%s:%d: Rule %r has too many arguments', =
file, line, func.__name__)
+                self.error =3D True
+            elif func.__code__.co_argcount < reqargs:
+                self.log.error('%s:%d: Rule %r requires an argument', fi=
le, line, func.__name__)
+                self.error =3D True
             elif not func.__doc__:
-                self.log.warning("%s:%d: No documentation string specifi=
ed in function '%s' (ignored)",file,line,func.__name__)
+                self.log.warning('%s:%d: No documentation string specifi=
ed in function %r (ignored)',
+                                 file, line, func.__name__)
             else:
                 try:
-                    parsed_g =3D parse_grammar(doc,file,line)
+                    parsed_g =3D parse_grammar(doc, file, line)
                     for g in parsed_g:
                         grammar.append((name, g))
-                except SyntaxError:
-                    e =3D sys.exc_info()[1]
+                except SyntaxError as e:
                     self.log.error(str(e))
-                    self.error =3D 1
+                    self.error =3D True
=20
                 # Looks like a valid grammar rule
                 # Mark the file in which defined.
-                self.files[file] =3D 1
+                self.modules.add(module)
=20
         # Secondary validation step that looks for p_ definitions that a=
re not functions
         # or functions that look like they might be grammar rules.
=20
-        for n,v in self.pdict.items():
-            if n[0:2] =3D=3D 'p_' and isinstance(v, (types.FunctionType,=
 types.MethodType)): continue
-            if n[0:2] =3D=3D 't_': continue
-            if n[0:2] =3D=3D 'p_' and n !=3D 'p_error':
-                self.log.warning("'%s' not defined as a function", n)
-            if ((isinstance(v,types.FunctionType) and func_code(v).co_ar=
gcount =3D=3D 1) or
-                (isinstance(v,types.MethodType) and func_code(v).co_argc=
ount =3D=3D 2)):
-                try:
-                    doc =3D v.__doc__.split(" ")
-                    if doc[1] =3D=3D ':':
-                        self.log.warning("%s:%d: Possible grammar rule '=
%s' defined without p_ prefix",
-                                         func_code(v).co_filename, func_=
code(v).co_firstlineno,n)
-                except Exception:
-                    pass
+        for n, v in self.pdict.items():
+            if n.startswith('p_') and isinstance(v, (types.FunctionType,=
 types.MethodType)):
+                continue
+            if n.startswith('t_'):
+                continue
+            if n.startswith('p_') and n !=3D 'p_error':
+                self.log.warning('%r not defined as a function', n)
+            if ((isinstance(v, types.FunctionType) and v.__code__.co_arg=
count =3D=3D 1) or
+                   (isinstance(v, types.MethodType) and v.__func__.__cod=
e__.co_argcount =3D=3D 2)):
+                if v.__doc__:
+                    try:
+                        doc =3D v.__doc__.split(' ')
+                        if doc[1] =3D=3D ':':
+                            self.log.warning('%s:%d: Possible grammar ru=
le %r defined without p_ prefix',
+                                             v.__code__.co_filename, v._=
_code__.co_firstlineno, n)
+                    except IndexError:
+                        pass
=20
         self.grammar =3D grammar
=20
@@ -3034,14 +3211,17 @@ class ParserReflect(object):
 # Build a parser
 # ----------------------------------------------------------------------=
-------
=20
-def yacc(method=3D'LALR', debug=3Dyaccdebug, module=3DNone, tabmodule=3D=
tab_module, start=3DNone,=20
-         check_recursion=3D1, optimize=3D0, write_tables=3D1, debugfile=3D=
debug_file,outputdir=3D'',
-         debuglog=3DNone, errorlog =3D None, picklefile=3DNone):
+def yacc(method=3D'LALR', debug=3Dyaccdebug, module=3DNone, tabmodule=3D=
tab_module, start=3DNone,
+         check_recursion=3DTrue, optimize=3DFalse, write_tables=3DTrue, =
debugfile=3Ddebug_file,
+         outputdir=3DNone, debuglog=3DNone, errorlog=3DNone, picklefile=3D=
None):
=20
-    global parse                 # Reference to the parsing method of th=
e last built parser
+    if tabmodule is None:
+        tabmodule =3D tab_module
=20
-    # If pickling is enabled, table files are not created
+    # Reference to the parsing method of the last built parser
+    global parse
=20
+    # If pickling is enabled, table files are not created
     if picklefile:
         write_tables =3D 0
=20
@@ -3050,17 +3230,50 @@ def yacc(method=3D'LALR', debug=3Dyaccdebug, modu=
le=3DNone, tabmodule=3Dtab_module, star
=20
     # Get the module dictionary used for the parser
     if module:
-        _items =3D [(k,getattr(module,k)) for k in dir(module)]
+        _items =3D [(k, getattr(module, k)) for k in dir(module)]
         pdict =3D dict(_items)
+        # If no __file__ attribute is available, try to obtain it from t=
he __module__ instead
+        if '__file__' not in pdict:
+            pdict['__file__'] =3D sys.modules[pdict['__module__']].__fil=
e__
     else:
         pdict =3D get_caller_module_dict(2)
=20
+    if outputdir is None:
+        # If no output directory is set, the location of the output file=
s
+        # is determined according to the following rules:
+        #     - If tabmodule specifies a package, files go into that pac=
kage directory
+        #     - Otherwise, files go in the same directory as the specify=
ing module
+        if isinstance(tabmodule, types.ModuleType):
+            srcfile =3D tabmodule.__file__
+        else:
+            if '.' not in tabmodule:
+                srcfile =3D pdict['__file__']
+            else:
+                parts =3D tabmodule.split('.')
+                pkgname =3D '.'.join(parts[:-1])
+                exec('import %s' % pkgname)
+                srcfile =3D getattr(sys.modules[pkgname], '__file__', ''=
)
+        outputdir =3D os.path.dirname(srcfile)
+
+    # Determine if the module is package of a package or not.
+    # If so, fix the tabmodule setting so that tables load correctly
+    pkg =3D pdict.get('__package__')
+    if pkg and isinstance(tabmodule, str):
+        if '.' not in tabmodule:
+            tabmodule =3D pkg + '.' + tabmodule
+
+
+
+    # Set start symbol if it's specified directly using an argument
+    if start is not None:
+        pdict['start'] =3D start
+
     # Collect parser information from the dictionary
-    pinfo =3D ParserReflect(pdict,log=3Derrorlog)
+    pinfo =3D ParserReflect(pdict, log=3Derrorlog)
     pinfo.get_all()
=20
     if pinfo.error:
-        raise YaccError("Unable to build parser")
+        raise YaccError('Unable to build parser')
=20
     # Check signature against table files (if any)
     signature =3D pinfo.signature()
@@ -3075,35 +3288,36 @@ def yacc(method=3D'LALR', debug=3Dyaccdebug, modu=
le=3DNone, tabmodule=3Dtab_module, star
         if optimize or (read_signature =3D=3D signature):
             try:
                 lr.bind_callables(pinfo.pdict)
-                parser =3D LRParser(lr,pinfo.error_func)
+                parser =3D LRParser(lr, pinfo.error_func)
                 parse =3D parser.parse
                 return parser
-            except Exception:
-                e =3D sys.exc_info()[1]
-                errorlog.warning("There was a problem loading the table =
file: %s", repr(e))
-    except VersionError:
-        e =3D sys.exc_info()
+            except Exception as e:
+                errorlog.warning('There was a problem loading the table =
file: %r', e)
+    except VersionError as e:
         errorlog.warning(str(e))
-    except Exception:
+    except ImportError:
         pass
=20
     if debuglog is None:
         if debug:
-            debuglog =3D PlyLogger(open(debugfile,"w"))
+            try:
+                debuglog =3D PlyLogger(open(os.path.join(outputdir, debu=
gfile), 'w'))
+            except IOError as e:
+                errorlog.warning("Couldn't open %r. %s" % (debugfile, e)=
)
+                debuglog =3D NullLogger()
         else:
             debuglog =3D NullLogger()
=20
-    debuglog.info("Created by PLY version %s (http://www.dabeaz.com/ply)=
", __version__)
-
+    debuglog.info('Created by PLY version %s (http://www.dabeaz.com/ply)=
', __version__)
=20
-    errors =3D 0
+    errors =3D False
=20
     # Validate the parser information
     if pinfo.validate_all():
-        raise YaccError("Unable to build parser")
-   =20
+        raise YaccError('Unable to build parser')
+
     if not pinfo.error_func:
-        errorlog.warning("no p_error() function is defined")
+        errorlog.warning('no p_error() function is defined')
=20
     # Create a grammar object
     grammar =3D Grammar(pinfo.tokens)
@@ -3111,20 +3325,18 @@ def yacc(method=3D'LALR', debug=3Dyaccdebug, modu=
le=3DNone, tabmodule=3Dtab_module, star
     # Set precedence level for terminals
     for term, assoc, level in pinfo.preclist:
         try:
-            grammar.set_precedence(term,assoc,level)
-        except GrammarError:
-            e =3D sys.exc_info()[1]
-            errorlog.warning("%s",str(e))
+            grammar.set_precedence(term, assoc, level)
+        except GrammarError as e:
+            errorlog.warning('%s', e)
=20
     # Add productions to the grammar
     for funcname, gram in pinfo.grammar:
         file, line, prodname, syms =3D gram
         try:
-            grammar.add_production(prodname,syms,funcname,file,line)
-        except GrammarError:
-            e =3D sys.exc_info()[1]
-            errorlog.error("%s",str(e))
-            errors =3D 1
+            grammar.add_production(prodname, syms, funcname, file, line)
+        except GrammarError as e:
+            errorlog.error('%s', e)
+            errors =3D True
=20
     # Set the grammar start symbols
     try:
@@ -3132,146 +3344,151 @@ def yacc(method=3D'LALR', debug=3Dyaccdebug, mo=
dule=3DNone, tabmodule=3Dtab_module, star
             grammar.set_start(pinfo.start)
         else:
             grammar.set_start(start)
-    except GrammarError:
-        e =3D sys.exc_info()[1]
+    except GrammarError as e:
         errorlog.error(str(e))
-        errors =3D 1
+        errors =3D True
=20
     if errors:
-        raise YaccError("Unable to build parser")
+        raise YaccError('Unable to build parser')
=20
     # Verify the grammar structure
     undefined_symbols =3D grammar.undefined_symbols()
     for sym, prod in undefined_symbols:
-        errorlog.error("%s:%d: Symbol '%s' used, but not defined as a to=
ken or a rule",prod.file,prod.line,sym)
-        errors =3D 1
+        errorlog.error('%s:%d: Symbol %r used, but not defined as a toke=
n or a rule', prod.file, prod.line, sym)
+        errors =3D True
=20
     unused_terminals =3D grammar.unused_terminals()
     if unused_terminals:
-        debuglog.info("")
-        debuglog.info("Unused terminals:")
-        debuglog.info("")
+        debuglog.info('')
+        debuglog.info('Unused terminals:')
+        debuglog.info('')
         for term in unused_terminals:
-            errorlog.warning("Token '%s' defined, but not used", term)
-            debuglog.info("    %s", term)
+            errorlog.warning('Token %r defined, but not used', term)
+            debuglog.info('    %s', term)
=20
     # Print out all productions to the debug log
     if debug:
-        debuglog.info("")
-        debuglog.info("Grammar")
-        debuglog.info("")
-        for n,p in enumerate(grammar.Productions):
-            debuglog.info("Rule %-5d %s", n, p)
+        debuglog.info('')
+        debuglog.info('Grammar')
+        debuglog.info('')
+        for n, p in enumerate(grammar.Productions):
+            debuglog.info('Rule %-5d %s', n, p)
=20
     # Find unused non-terminals
     unused_rules =3D grammar.unused_rules()
     for prod in unused_rules:
-        errorlog.warning("%s:%d: Rule '%s' defined, but not used", prod.=
file, prod.line, prod.name)
+        errorlog.warning('%s:%d: Rule %r defined, but not used', prod.fi=
le, prod.line, prod.name)
=20
     if len(unused_terminals) =3D=3D 1:
-        errorlog.warning("There is 1 unused token")
+        errorlog.warning('There is 1 unused token')
     if len(unused_terminals) > 1:
-        errorlog.warning("There are %d unused tokens", len(unused_termin=
als))
+        errorlog.warning('There are %d unused tokens', len(unused_termin=
als))
=20
     if len(unused_rules) =3D=3D 1:
-        errorlog.warning("There is 1 unused rule")
+        errorlog.warning('There is 1 unused rule')
     if len(unused_rules) > 1:
-        errorlog.warning("There are %d unused rules", len(unused_rules))
+        errorlog.warning('There are %d unused rules', len(unused_rules))
=20
     if debug:
-        debuglog.info("")
-        debuglog.info("Terminals, with rules where they appear")
-        debuglog.info("")
+        debuglog.info('')
+        debuglog.info('Terminals, with rules where they appear')
+        debuglog.info('')
         terms =3D list(grammar.Terminals)
         terms.sort()
         for term in terms:
-            debuglog.info("%-20s : %s", term, " ".join([str(s) for s in =
grammar.Terminals[term]]))
-       =20
-        debuglog.info("")
-        debuglog.info("Nonterminals, with rules where they appear")
-        debuglog.info("")
+            debuglog.info('%-20s : %s', term, ' '.join([str(s) for s in =
grammar.Terminals[term]]))
+
+        debuglog.info('')
+        debuglog.info('Nonterminals, with rules where they appear')
+        debuglog.info('')
         nonterms =3D list(grammar.Nonterminals)
         nonterms.sort()
         for nonterm in nonterms:
-            debuglog.info("%-20s : %s", nonterm, " ".join([str(s) for s =
in grammar.Nonterminals[nonterm]]))
-        debuglog.info("")
+            debuglog.info('%-20s : %s', nonterm, ' '.join([str(s) for s =
in grammar.Nonterminals[nonterm]]))
+        debuglog.info('')
=20
     if check_recursion:
         unreachable =3D grammar.find_unreachable()
         for u in unreachable:
-            errorlog.warning("Symbol '%s' is unreachable",u)
+            errorlog.warning('Symbol %r is unreachable', u)
=20
         infinite =3D grammar.infinite_cycles()
         for inf in infinite:
-            errorlog.error("Infinite recursion detected for symbol '%s'"=
, inf)
-            errors =3D 1
-       =20
+            errorlog.error('Infinite recursion detected for symbol %r', =
inf)
+            errors =3D True
+
     unused_prec =3D grammar.unused_precedence()
     for term, assoc in unused_prec:
-        errorlog.error("Precedence rule '%s' defined for unknown symbol =
'%s'", assoc, term)
-        errors =3D 1
+        errorlog.error('Precedence rule %r defined for unknown symbol %r=
', assoc, term)
+        errors =3D True
=20
     if errors:
-        raise YaccError("Unable to build parser")
-   =20
+        raise YaccError('Unable to build parser')
+
     # Run the LRGeneratedTable on the grammar
     if debug:
-        errorlog.debug("Generating %s tables", method)
-           =20
-    lr =3D LRGeneratedTable(grammar,method,debuglog)
+        errorlog.debug('Generating %s tables', method)
+
+    lr =3D LRGeneratedTable(grammar, method, debuglog)
=20
     if debug:
         num_sr =3D len(lr.sr_conflicts)
=20
         # Report shift/reduce and reduce/reduce conflicts
         if num_sr =3D=3D 1:
-            errorlog.warning("1 shift/reduce conflict")
+            errorlog.warning('1 shift/reduce conflict')
         elif num_sr > 1:
-            errorlog.warning("%d shift/reduce conflicts", num_sr)
+            errorlog.warning('%d shift/reduce conflicts', num_sr)
=20
         num_rr =3D len(lr.rr_conflicts)
         if num_rr =3D=3D 1:
-            errorlog.warning("1 reduce/reduce conflict")
+            errorlog.warning('1 reduce/reduce conflict')
         elif num_rr > 1:
-            errorlog.warning("%d reduce/reduce conflicts", num_rr)
+            errorlog.warning('%d reduce/reduce conflicts', num_rr)
=20
     # Write out conflicts to the output file
     if debug and (lr.sr_conflicts or lr.rr_conflicts):
-        debuglog.warning("")
-        debuglog.warning("Conflicts:")
-        debuglog.warning("")
+        debuglog.warning('')
+        debuglog.warning('Conflicts:')
+        debuglog.warning('')
=20
         for state, tok, resolution in lr.sr_conflicts:
-            debuglog.warning("shift/reduce conflict for %s in state %d r=
esolved as %s",  tok, state, resolution)
-       =20
-        already_reported =3D {}
+            debuglog.warning('shift/reduce conflict for %s in state %d r=
esolved as %s',  tok, state, resolution)
+
+        already_reported =3D set()
         for state, rule, rejected in lr.rr_conflicts:
-            if (state,id(rule),id(rejected)) in already_reported:
+            if (state, id(rule), id(rejected)) in already_reported:
                 continue
-            debuglog.warning("reduce/reduce conflict in state %d resolve=
d using rule (%s)", state, rule)
-            debuglog.warning("rejected rule (%s) in state %d", rejected,=
state)
-            errorlog.warning("reduce/reduce conflict in state %d resolve=
d using rule (%s)", state, rule)
-            errorlog.warning("rejected rule (%s) in state %d", rejected,=
 state)
-            already_reported[state,id(rule),id(rejected)] =3D 1
-       =20
+            debuglog.warning('reduce/reduce conflict in state %d resolve=
d using rule (%s)', state, rule)
+            debuglog.warning('rejected rule (%s) in state %d', rejected,=
 state)
+            errorlog.warning('reduce/reduce conflict in state %d resolve=
d using rule (%s)', state, rule)
+            errorlog.warning('rejected rule (%s) in state %d', rejected,=
 state)
+            already_reported.add((state, id(rule), id(rejected)))
+
         warned_never =3D []
         for state, rule, rejected in lr.rr_conflicts:
             if not rejected.reduced and (rejected not in warned_never):
-                debuglog.warning("Rule (%s) is never reduced", rejected)
-                errorlog.warning("Rule (%s) is never reduced", rejected)
+                debuglog.warning('Rule (%s) is never reduced', rejected)
+                errorlog.warning('Rule (%s) is never reduced', rejected)
                 warned_never.append(rejected)
=20
     # Write the table file if requested
     if write_tables:
-        lr.write_table(tabmodule,outputdir,signature)
+        try:
+            lr.write_table(tabmodule, outputdir, signature)
+        except IOError as e:
+            errorlog.warning("Couldn't create %r. %s" % (tabmodule, e))
=20
     # Write a pickled version of the tables
     if picklefile:
-        lr.pickle_table(picklefile,signature)
+        try:
+            lr.pickle_table(picklefile, signature)
+        except IOError as e:
+            errorlog.warning("Couldn't create %r. %s" % (picklefile, e))
=20
     # Build the parser
     lr.bind_callables(pinfo.pdict)
-    parser =3D LRParser(lr,pinfo.error_func)
+    parser =3D LRParser(lr, pinfo.error_func)
=20
     parse =3D parser.parse
     return parser
diff --git a/lib/bb/_vendor/ply/ygen.py b/lib/bb/_vendor/ply/ygen.py
new file mode 100644
index 000000000..acf5ca1a3
--- /dev/null
+++ b/lib/bb/_vendor/ply/ygen.py
@@ -0,0 +1,74 @@
+# ply: ygen.py
+#
+# This is a support program that auto-generates different versions of th=
e YACC parsing
+# function with different features removed for the purposes of performan=
ce.
+#
+# Users should edit the method LParser.parsedebug() in yacc.py.   The so=
urce code=20
+# for that method is then used to create the other methods.   See the co=
mments in
+# yacc.py for further details.
+
+import os.path
+import shutil
+
+def get_source_range(lines, tag):
+    srclines =3D enumerate(lines)
+    start_tag =3D '#--! %s-start' % tag
+    end_tag =3D '#--! %s-end' % tag
+
+    for start_index, line in srclines:
+        if line.strip().startswith(start_tag):
+            break
+
+    for end_index, line in srclines:
+        if line.strip().endswith(end_tag):
+            break
+
+    return (start_index + 1, end_index)
+
+def filter_section(lines, tag):
+    filtered_lines =3D []
+    include =3D True
+    tag_text =3D '#--! %s' % tag
+    for line in lines:
+        if line.strip().startswith(tag_text):
+            include =3D not include
+        elif include:
+            filtered_lines.append(line)
+    return filtered_lines
+
+def main():
+    dirname =3D os.path.dirname(__file__)
+    shutil.copy2(os.path.join(dirname, 'yacc.py'), os.path.join(dirname,=
 'yacc.py.bak'))
+    with open(os.path.join(dirname, 'yacc.py'), 'r') as f:
+        lines =3D f.readlines()
+
+    parse_start, parse_end =3D get_source_range(lines, 'parsedebug')
+    parseopt_start, parseopt_end =3D get_source_range(lines, 'parseopt')
+    parseopt_notrack_start, parseopt_notrack_end =3D get_source_range(li=
nes, 'parseopt-notrack')
+
+    # Get the original source
+    orig_lines =3D lines[parse_start:parse_end]
+
+    # Filter the DEBUG sections out
+    parseopt_lines =3D filter_section(orig_lines, 'DEBUG')
+
+    # Filter the TRACKING sections out
+    parseopt_notrack_lines =3D filter_section(parseopt_lines, 'TRACKING'=
)
+
+    # Replace the parser source sections with updated versions
+    lines[parseopt_notrack_start:parseopt_notrack_end] =3D parseopt_notr=
ack_lines
+    lines[parseopt_start:parseopt_end] =3D parseopt_lines
+
+    lines =3D [line.rstrip()+'\n' for line in lines]
+    with open(os.path.join(dirname, 'yacc.py'), 'w') as f:
+        f.writelines(lines)
+
+    print('Updated yacc.py')
+
+if __name__ =3D=3D '__main__':
+    main()
+
+
+
+
+
diff --git a/lib/bb/_vendor/progressbar.pyi b/lib/bb/_vendor/progressbar.=
pyi
new file mode 100644
index 000000000..834805762
--- /dev/null
+++ b/lib/bb/_vendor/progressbar.pyi
@@ -0,0 +1 @@
+from progressbar import *
\ No newline at end of file
diff --git a/lib/bb/_vendor/progressbar/__init__.py b/lib/bb/_vendor/prog=
ressbar/__init__.py
index c545a6275..623493bc9 100644
--- a/lib/bb/_vendor/progressbar/__init__.py
+++ b/lib/bb/_vendor/progressbar/__init__.py
@@ -42,9 +42,9 @@ automatically enable features like auto-resizing when t=
he system supports it.
 """
=20
 __author__ =3D 'Nilton Volpato'
-__author_email__ =3D 'first-name dot last-name @ gmail.com'
+__author_email__ =3D 'nilton.volpato@gmail.com'
 __date__ =3D '2011-05-14'
-__version__ =3D '2.3'
+__version__ =3D '2.5'
=20
 from .compat import *
 from .widgets import *
diff --git a/lib/bb/_vendor/progressbar/progressbar.py b/lib/bb/_vendor/p=
rogressbar/progressbar.py
index 1562774ba..3cc49547d 100644
--- a/lib/bb/_vendor/progressbar/progressbar.py
+++ b/lib/bb/_vendor/progressbar/progressbar.py
@@ -42,9 +42,6 @@ from .compat import *  # for: any, next
 from . import widgets
=20
=20
-class UnknownLength: pass
-
-
 class ProgressBar(object):
     """The ProgressBar class which updates and prints the bar.
=20
@@ -99,7 +96,7 @@ class ProgressBar(object):
     _DEFAULT_WIDGETS =3D [widgets.Percentage(), ' ', widgets.Bar()]
=20
     def __init__(self, maxval=3DNone, widgets=3DNone, term_width=3DNone,=
 poll=3D1,
-                 left_justify=3DTrue, fd=3Dsys.stderr):
+                 left_justify=3DTrue, fd=3DNone):
         """Initializes a progress bar with sane defaults."""
=20
         # Don't share a reference with any other progress bars
@@ -108,7 +105,7 @@ class ProgressBar(object):
=20
         self.maxval =3D maxval if maxval !=3D 0 else self._DEFAULT_MAXVA=
L
         self.widgets =3D widgets
-        self.fd =3D fd
+        self.fd =3D fd if fd is not None else sys.stderr
         self.left_justify =3D left_justify
         self._fd_console =3D None
=20
@@ -124,11 +121,11 @@ class ProgressBar(object):
                 # temporarily/permanently self.fd to any StringIO or oth=
er
                 # file descriptor later.
                 self._fd_console =3D fd
-                self._handle_resize(None, None)
+                self._handle_resize()
                 signal.signal(signal.SIGWINCH, self._handle_resize)
                 self.signal_set =3D True
             except (SystemExit, KeyboardInterrupt): raise
-            except Exception as e:
+            except:
                 self.term_width =3D self._env_size()
=20
         self.__iterable =3D None
@@ -150,7 +147,7 @@ class ProgressBar(object):
             self.maxval =3D len(iterable)
         except:
             if self.maxval is None:
-                self.maxval =3D UnknownLength
+                self.maxval =3D widgets.UnknownLength
=20
         self.__iterable =3D iter(iterable)
         return self
@@ -195,6 +192,8 @@ class ProgressBar(object):
=20
     def percentage(self):
         """Returns the progress as a percentage."""
+        if self.maxval is widgets.UnknownLength:
+                return float("NaN")
         if self.currval >=3D self.maxval:
             return 100.0
         return (self.currval * 100.0 / self.maxval) if self.maxval else =
100.00
@@ -256,8 +255,8 @@ class ProgressBar(object):
     def update(self, value=3DNone):
         """Updates the ProgressBar to a new value."""
=20
-        if value is not None and value is not UnknownLength:
-            if (self.maxval is not UnknownLength
+        if value is not None and value is not widgets.UnknownLength:
+            if (self.maxval is not widgets.UnknownLength
                 and not 0 <=3D value <=3D self.maxval):
=20
                 self.maxval =3D value
@@ -300,7 +299,7 @@ class ProgressBar(object):
         self.num_intervals =3D max(100, self.term_width)
         self.next_update =3D 0
=20
-        if self.maxval is not UnknownLength:
+        if self.maxval is not widgets.UnknownLength:
             if self.maxval < 0: raise ValueError('Value out of range')
             self.update_interval =3D self.maxval / self.num_intervals
=20
diff --git a/lib/bb/_vendor/progressbar/widgets.py b/lib/bb/_vendor/progr=
essbar/widgets.py
index 0772aa536..d844fc367 100644
--- a/lib/bb/_vendor/progressbar/widgets.py
+++ b/lib/bb/_vendor/progressbar/widgets.py
@@ -34,6 +34,8 @@ except ImportError:
 else:
     AbstractWidget =3D ABCMeta('AbstractWidget', (object,), {})
=20
+class UnknownLength:
+  pass
=20
 def format_updatable(updatable, pbar):
     if hasattr(updatable, 'update'): return updatable.update(pbar)
@@ -109,7 +111,7 @@ class ETA(Timer):
     def update(self, pbar):
         """Updates the widget to show the ETA or total time when finishe=
d."""
=20
-        if pbar.currval =3D=3D 0:
+        if pbar.maxval is UnknownLength or pbar.currval =3D=3D 0:
             return 'ETA:  --:--:--'
         elif pbar.finished:
             return 'Time: %s' % self.format_time(pbar.seconds_elapsed)
@@ -147,7 +149,7 @@ class AdaptiveETA(Timer):
=20
     def update(self, pbar):
         """Updates the widget to show the ETA or total time when finishe=
d."""
-        if pbar.currval =3D=3D 0:
+        if pbar.maxval is UnknownLength or pbar.currval =3D=3D 0:
             return 'ETA:  --:--:--'
         elif pbar.finished:
             return 'Time: %s' % self.format_time(pbar.seconds_elapsed)
@@ -167,7 +169,7 @@ class AdaptiveETA(Timer):
 class FileTransferSpeed(Widget):
     """Widget for showing the transfer speed (useful for file transfers)=
."""
=20
-    FORMAT =3D '%6.2f %s%s/s'
+    FMT =3D '%6.2f %s%s/s'
     PREFIXES =3D ' kMGTPEZY'
     __slots__ =3D ('unit',)
=20
@@ -184,7 +186,7 @@ class FileTransferSpeed(Widget):
             power =3D int(math.log(speed, 1000))
             scaled =3D speed / 1000.**power
=20
-        return self.FORMAT % (scaled, self.PREFIXES[power], self.unit)
+        return self.FMT % (scaled, self.PREFIXES[power], self.unit)
=20
=20
 class AnimatedMarker(Widget):
@@ -271,7 +273,7 @@ class SimpleProgress(Widget):
         self.sep =3D sep
=20
     def update(self, pbar):
-        return '%d%s%d' % (pbar.currval, self.sep, pbar.maxval)
+        return '%d%s%s' % (pbar.currval, self.sep, pbar.maxval)
=20
=20
 class Bar(WidgetHFill):
@@ -304,7 +306,7 @@ class Bar(WidgetHFill):
=20
         width -=3D len(left) + len(right)
         # Marked must *always* have length of 1
-        if pbar.maxval:
+        if pbar.maxval is not UnknownLength and pbar.maxval:
           marked *=3D int(pbar.currval / pbar.maxval * width)
         else:
           marked =3D ''
diff --git a/lib/bb/_vendor/simplediff.pyi b/lib/bb/_vendor/simplediff.py=
i
new file mode 100644
index 000000000..26dabde82
--- /dev/null
+++ b/lib/bb/_vendor/simplediff.pyi
@@ -0,0 +1 @@
+from simplediff import *
\ No newline at end of file
diff --git a/lib/bb/_vendor/simplediff/__init__.py b/lib/bb/_vendor/simpl=
ediff/__init__.py
index 57ee3c5c4..4e6b59eb2 100644
--- a/lib/bb/_vendor/simplediff/__init__.py
+++ b/lib/bb/_vendor/simplediff/__init__.py
@@ -11,7 +11,7 @@ May be used and distributed under the zlib/libpng licen=
se
 '''
=20
 __all__ =3D ['diff', 'string_diff', 'html_diff']
-__version__ =3D '1.0'
+__version__ =3D '1.1'
=20
=20
 def diff(old, new):

--=20
2.49.0


