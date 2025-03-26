Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16696C36011
	for <webhook@archiver.kernel.org>; Wed, 26 Mar 2025 12:25:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.21068.1742991930877681492
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Mar 2025 05:25:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 203A012FC
	for <bitbake-devel@lists.openembedded.org>; Wed, 26 Mar 2025 05:25:36 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C171B3F63F
	for <bitbake-devel@lists.openembedded.org>; Wed, 26 Mar 2025 05:25:29 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v3 7/7] tests/fetch: add a test for download paths without a proper filename
Date: Wed, 26 Mar 2025 12:25:23 +0000
Message-ID: <20250326122523.293551-7-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326122523.293551-1-ross.burton@arm.com>
References: <20250326122523.293551-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Mar 2025 12:25:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17501

For example the miniupnpd recipe has a SRC_URI like this:

    http://miniupnp.tuxfamily.org/files/download.php?file=3D${BP}.tar.gz

In this case the path is /files/download.php, which isn't useful when
the latest_upstream logic bails early if there is no version in the path.

The logic now also checks in the downloadfilename, so add a test that
this works as expected.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 .../software/miniupnp/download.php            | 3528 +++++++++++++++++
 bitbake/lib/bb/tests/fetch.py                 |    6 +
 2 files changed, 3534 insertions(+)
 create mode 100644 bitbake/lib/bb/tests/fetch-testdata/software/miniupnp=
/download.php

diff --git a/bitbake/lib/bb/tests/fetch-testdata/software/miniupnp/downlo=
ad.php b/bitbake/lib/bb/tests/fetch-testdata/software/miniupnp/download.p=
hp
new file mode 100644
index 00000000000..e27ee134f22
--- /dev/null
+++ b/bitbake/lib/bb/tests/fetch-testdata/software/miniupnp/download.php
@@ -0,0 +1,3528 @@
+<?xml version=3D"1.0" encoding=3D"UTF-8"?>
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
+ "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
+<html xmlns=3D"http://www.w3.org/1999/xhtml" xml:lang=3D"en" lang=3D"en"=
>
+<head>
+<title>MiniUPnP download zone</title>
+<link href=3D"../css/miniupnp.css" rel=3D"stylesheet" type=3D"text/css"/=
>
+<meta name=3D"description" content=3D"files download of the miniupnp pro=
ject"/>
+<meta name=3D"keywords" content=3D"upnp,download,openbsd,freebsd,linux,w=
indows"/>
+<meta name=3D"viewport" content=3D"width=3Ddevice-width" />
+<link href=3D"rss.php" title=3D"MiniUPnPd, MiniUPnPc and MiniSSDPd Files=
" type=3D"application/rss+xml" rel=3D"alternate" />
+<link rel=3D"canonical" href=3D"http://miniupnp.free.fr/files/" />
+<link rel=3D"alternate" hreflang=3D"fr" href=3D"/files/index_fr.php" />
+<script async=3D"async" src=3D"//pagead2.googlesyndication.com/pagead/js=
/adsbygoogle.js" type=3D"text/javascript"></script>
+<script type=3D"text/javascript">
+     (adsbygoogle =3D window.adsbygoogle || []).push({
+          google_ad_client: "ca-pub-6883148866513192",
+          enable_page_level_ads: true
+     });
+</script>
+</head>
+<body>
+<h2>MiniUPnP Project</h2>
+
+<p align=3D"center">
+<a href=3D"../">Home</a> |
+<b>Downloads</b> |
+<a href=3D"../devicelist.php">Compatibility list</a> |
+<a href=3D"../libnatpmp.html">libnatpmp</a> |
+<a href=3D"../minissdpd.html">MiniSSDPd</a> |
+<a href=3D"../xchat-upnp.html">xchat upnp patch</a> |
+<a href=3D"../search.html">Search</a> |
+<a href=3D"https://miniupnp.tuxfamily.org/forum/">Forum</a>
+</p>
+<p align=3D"center">
+<b>English</b> | <a href=3D"/files/index_fr.php">Fran&ccedil;ais</a>
+</p>
+
+<div align=3D"center">
+<script type=3D"text/javascript"><!--
+google_ad_client =3D "pub-6883148866513192";
+/* 728x90, created 7/10/08 */
+google_ad_slot =3D "0774293141";
+google_ad_width =3D 728;
+google_ad_height =3D 90;
+//-->
+</script>
+<script type=3D"text/javascript"
+src=3D"https://pagead2.googlesyndication.com/pagead/show_ads.js">
+</script>
+</div>
+
+<h2>MiniUPnP download zone</h2>
+<p>
+Find on this page the source of miniupnp and=20
+some related files. You will also find precompiled binaries
+of the UPnP client sample program for windows compiled using
+<a href=3D"https://mingw.osdn.io/">MinGW</a>. There are also Windows
+binaries (including python module) automatically built using
+<a href=3D"https://ci.appveyor.com/project/miniupnp/miniupnp/build/artif=
acts">AppVeyor</a>.
+</p>
+<p>If you just need one of the software installed on your machine,
+you probably don't need to download and compile the source files.
+It is very likely that a package/port already exists for
+your system/distribution. Refer to your system documentation
+to find how to search and install a package/port.
+Mac OS X does have port systems too : see
+<a href=3D"http://www.macports.org/">MacPorts</a> or
+<a href=3D"http://mxcl.github.com/homebrew/">Homebrew</a> or
+<a href=3D"http://www.finkproject.org/">Fink</a>.
+</p>
+<p>
+The miniupnpc (client) sources have been successfully compiled
+under Windows XP/vista/7/10/etc. (using
+<a href=3D"https://mingw.osdn.io/">MinGW</a>,
+<a href=3D"https://www.mingw-w64.org/">Mingw-w64</a>
+or <a href=3D"http://www.cygwin.com/">Cygwin</a>),
+Linux, OpenBSD, FreeBSD, NetBSD, DragonFlyBSD,
+Solaris, MacOS X and AmigaOS. <br/>
+The Makefile of the client is made for GNU make :
+check which version your system have=20
+with the command "make --version". On some systems, such as OpenBSD,=20
+you have to use "gmake". Under Windows with MinGW, GNU make is
+called "mingw32-make" and a sligthly modified version of the Makefile
+should be used : Makefile.mingw. Run "mingw32make.bat" to compile. <br/>
+If you have any compatibility problem, please post on the
+<a href=3D"https://miniupnp.tuxfamily.org/forum/">forum</a>
+or contact me by email.
+</p>
+<!--
+<p>A devoted user compiled miniupnp<strong>c</strong> for
+Openwrt (currently Kamikaze 7.09)
+and his work is available here :=20
+<a href=3D"http://replay.waybackmachine.org/20081120030628/http://www.my=
antihero.net/pub/openwrt/packages/">http://myantihero.net/pub/openwrt/pac=
kages/</a>.</p>
+-->
+<p>Get miniupnpc under AmigaOS 4 on
+<a href=3D"http://os4depot.net/index.php?function=3Dshowfile&amp;file=3D=
network/misc/miniupnpc.lha">OS4Depot</a>.
+</p>
+<p>
+Dario Meloni has made a Ruby Gem embedding miniupnpc :
+<a href=3D"https://rubygems.org/gems/mupnp">https://rubygems.org/gems/mu=
pnp</a>.
+</p>
+<p>
+The python module is available on pypi.org :
+<a href=3D"https://pypi.org/project/miniupnpc/">pip install miniupnpc</a=
>.
+</p>
+<p>
+The daemon (starting in November 2006) compiles with BSD make under BSD
+and Solaris.<br/>
+To compile the daemon under linux, use "make -f Makefile.linux"<br/>
+To compile for <a href=3D"http://openwrt.org/">OpenWRT</a>
+please read the README.openwrt file, or use the packages=20
+<a href=3D"https://openwrt.org/packages/pkgdata/miniupnpd">miniupnpc</a>=
 and
+<a href=3D"https://openwrt.org/packages/pkgdata/miniupnpd">miniupnpd</a>=
.
+<!-- The
+<a href=3D"http://www.x-wrt.org/">X-Wrt</a> project is providing
+precompiled ipkg packages for OpenWrt for both OpenWrt=20
+<a href=3D"ftp://ftp.berlios.de/pub/xwrt/packages/">White Russian</a>
+and OpenWrt
+<a href=3D"ftp://ftp.berlios.de/pub/xwrt/kamikaze/packages">kamikaze</a>=
.=20
+Check
+<a href=3D"ftp://ftp.berlios.de/pub/xwrt/">ftp://ftp.berlios.de/pub/xwrt=
/</a>.
+For White Russian, take a look at
+<a href=3D"http://jackassofalltrades.com/openwrt/">this</a>. -->
+<br/>
+<a href=3D"http://pfsense.com">pfSense</a> users are advised to use the=20
+miniupnpd port available for their system. Recent versions of
+pfSense include MiniUPnPd in the base system.
+<br/>
+For <a href=3D"http://en.wikipedia.org/wiki/WRT54G">Linksys WRT54G</a>
+and WRT54GL owners,
+<a href=3D"http://sourceforge.net/projects/tarifa/">Tarifa firmware</a>
+is another alternative to get miniUPnPd running on the router.
+</p>
+<p>
+Please read README and
+LICENCE files included with the distribution for further informations.
+</p>
+<p>
+The MiniUPnP daemon (miniupnpd) is working under
+<a href=3D"http://www.openbsd.org/">OpenBSD</a>,
+<a href=3D"http://www.netbsd.org/">NetBSD</a>,
+<a href=3D"http://www.freebsd.org/">FreeBSD</a>,
+<a href=3D"http://www.dragonflybsd.org/">DragonFlyBSD</a>,
+<a href=3D"http://www.apple.com/macosx/">Mac OS X</a> and
+(<a href=3D"https://en.wikipedia.org/wiki/OpenSolaris">Open</a>)<a href=3D=
"http://www.oracle.com/us/products/servers-storage/solaris/solaris11/over=
view/index.html">Solaris</a>
+with <a href=3D"http://www.openbsd.org/faq/pf/">pf</a>,
+with <a href=3D"https://en.wikipedia.org/wiki/IPFilter">IP Filter</a> or
+with <a href=3D"http://en.wikipedia.org/wiki/Ipfirewall">ipfw</a>.
+The linux version uses either libiptc which permits to access
+<a href=3D"http://netfilter.org/">netfilter</a>
+rules inside the kernel the same way as
+<a href=3D"https://www.netfilter.org/projects/iptables/index.html">iptab=
les</a>, or
+<a href=3D"https://www.netfilter.org/projects/libnftnl/index.html">libnf=
tnl</a>
+which is the equivalent for
+<a href=3D"https://www.netfilter.org/projects/nftables/index.html">nftab=
les</a>.
+</p>
+
+<p>Releases are now GPG signed with the key <a href=3D"../A31ACAAF.asc">=
A31ACAAF</a>.
+Previous signing key was <a href=3D"../A5C0863C.asc">A5C0863C</a>.
+Get it from your favorite
+<a href=3D"https://pgp.mit.edu/pks/lookup?search=3D0xA31ACAAF&amp;op=3Di=
ndex&amp;fingerprint=3Don">key server</a>.</p>
+
+<h4>REST API</h4>
+<p>You can use the REST API to get the latest releases available:</p>
+<ul>
+<li><a href=3D"rest.php/tags/miniupnpd?count=3D1">rest.php/tags/miniupnp=
d?count=3D1</a>: latest miniupnpd.</li>
+<li><a href=3D"rest.php/tags?count=3D1">rest.php/tags?count=3D1</a>: min=
iupnpc, miniupnpd and minissdpd.</li>
+</ul>
+
+<h4>You can help !</h4>
+<p>If you make a package/port for your favorite OS distribution,
+inform me so I can upload the package here or add a link to your=20
+repository.
+</p>
+
+<h4>Latest files</h4>
+<table>
+<tr><th>name</th>
+<th>size</th>
+<th>date</th>
+<th>comment</th>
+<th><!-- Changelog --></th>
+<th><!-- Signature --></th>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'miniupnpc-2.3.2.tar.gz'>miniupnpc-2.3=
.2.tar.gz</a></td>
+	<td class=3D"filesize">140137</td>
+	<td class=3D"filedate">05/03/2025 10:31</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td><a href=3D"changelog.php?file=3Dminiupnpc-2.3.2.tar.gz">changelog</=
a></td>
+	<td><a href=3D"miniupnpc-2.3.2.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'miniupnpd-2.3.7.tar.gz'>miniupnpd-2.3=
.7.tar.gz</a></td>
+	<td class=3D"filesize">265329</td>
+	<td class=3D"filedate">22/06/2024 22:31</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td><a href=3D"changelog.php?file=3Dminiupnpd-2.3.7.tar.gz">changelog</=
a></td>
+	<td><a href=3D"miniupnpd-2.3.7.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'libnatpmp-20230423.tar.gz'>libnatpmp-=
20230423.tar.gz</a></td>
+	<td class=3D"filesize">26506</td>
+	<td class=3D"filedate">23/04/2023 11:02</td>
+	<td class=3D"comment">latest libnatpmp source code</td>
+	<td><a href=3D"changelog.php?file=3Dlibnatpmp-20230423.tar.gz">changelo=
g</a></td>
+	<td><a href=3D"libnatpmp-20230423.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'minissdpd-1.6.0.tar.gz'>minissdpd-1.6=
.0.tar.gz</a></td>
+	<td class=3D"filesize">39077</td>
+	<td class=3D"filedate">22/10/2022 18:41</td>
+	<td class=3D"comment">MiniSSDPd release source code</td>
+	<td><a href=3D"changelog.php?file=3Dminissdpd-1.6.0.tar.gz">changelog</=
a></td>
+	<td><a href=3D"minissdpd-1.6.0.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'upnpc-exe-win32-20220515.zip'>upnpc-e=
xe-win32-20220515.zip</a></td>
+	<td class=3D"filesize">69503</td>
+	<td class=3D"filedate">15/05/2022 14:31</td>
+	<td class=3D"comment">Windows executable</td>
+	<td><a href=3D"changelog.php?file=3Dupnpc-exe-win32-20220515.zip">chang=
elog</a></td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'minissdpd-1.5.20211105.tar.gz'>miniss=
dpd-1.5.20211105.tar.gz</a></td>
+	<td class=3D"filesize">38870</td>
+	<td class=3D"filedate">04/11/2021 23:34</td>
+	<td class=3D"comment">latest MiniSSDPd source code</td>
+	<td><a href=3D"changelog.php?file=3Dminissdpd-1.5.20211105.tar.gz">chan=
gelog</a></td>
+	<td><a href=3D"minissdpd-1.5.20211105.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'miniupnpc-2.1.20201016.tar.gz'>miniup=
npc-2.1.20201016.tar.gz</a></td>
+	<td class=3D"filesize">97682</td>
+	<td class=3D"filedate">15/10/2020 22:31</td>
+	<td class=3D"comment">latest MiniUPnP client source code</td>
+	<td><a href=3D"changelog.php?file=3Dminiupnpc-2.1.20201016.tar.gz">chan=
gelog</a></td>
+	<td><a href=3D"miniupnpc-2.1.20201016.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'miniupnpd-2.1.20200510.tar.gz'>miniup=
npd-2.1.20200510.tar.gz</a></td>
+	<td class=3D"filesize">245426</td>
+	<td class=3D"filedate">10/05/2020 18:23</td>
+	<td class=3D"comment">latest MiniUPnP daemon source code</td>
+	<td><a href=3D"changelog.php?file=3Dminiupnpd-2.1.20200510.tar.gz">chan=
gelog</a></td>
+	<td><a href=3D"miniupnpd-2.1.20200510.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'xchat-upnp20110811.patch'>xchat-upnp2=
0110811.patch</a></td>
+	<td class=3D"filesize">10329</td>
+	<td class=3D"filedate">11/08/2011 15:18</td>
+	<td class=3D"comment">Patch to add UPnP capabilities to xchat</td>
+	<td><a href=3D"changelog.php?file=3Dxchat-upnp20110811.patch">changelog=
</a></td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'minidlna_1.0.21.minissdp1.patch'>mini=
dlna_1.0.21.minissdp1.patch</a></td>
+	<td class=3D"filesize">7598</td>
+	<td class=3D"filedate">25/07/2011 14:57</td>
+	<td class=3D"comment">Patch for MiniDLNA to use miniSSDPD</td>
+	<td><a href=3D"changelog.php?file=3Dminidlna_1.0.21.minissdp1.patch">ch=
angelog</a></td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'miniupnpc-new20060630.tar.gz'>miniupn=
pc-new20060630.tar.gz</a></td>
+	<td class=3D"filesize">14840</td>
+	<td class=3D"filedate">04/11/2006 18:16</td>
+	<td class=3D"comment">Jo&atilde;o Paulo Barraca version of the upnp cli=
ent</td>
+	<td><a href=3D"changelog.php?file=3Dminiupnpc-new20060630.tar.gz">chang=
elog</a></td>
+	<td></td>
+</tr>
+</table>
+
+<h4>All files</h4>
+<table>
+<tr><th>name</th>
+<th>size</th>
+<th>date</th>
+<th>comment</th>
+<th><!-- signature --></th>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.3.2.t=
ar.gz'>miniupnpc-2.3.2.tar.gz</a></td>
+	<td class=3D"filesize">140137</td>
+	<td class=3D"filedate">05/03/2025 10:31:36 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td><a href=3D"miniupnpc-2.3.2.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.3.1.t=
ar.gz'>miniupnpc-2.3.1.tar.gz</a></td>
+	<td class=3D"filesize">139499</td>
+	<td class=3D"filedate">23/02/2025 16:44:16 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td><a href=3D"miniupnpc-2.3.1.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.3.0.t=
ar.gz'>miniupnpc-2.3.0.tar.gz</a></td>
+	<td class=3D"filesize">105071</td>
+	<td class=3D"filedate">10/01/2025 23:16:45 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td><a href=3D"miniupnpc-2.3.0.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.3.7.t=
ar.gz'>miniupnpd-2.3.7.tar.gz</a></td>
+	<td class=3D"filesize">265329</td>
+	<td class=3D"filedate">22/06/2024 22:31:38 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td><a href=3D"miniupnpd-2.3.7.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.2.8.t=
ar.gz'>miniupnpc-2.2.8.tar.gz</a></td>
+	<td class=3D"filesize">104603</td>
+	<td class=3D"filedate">08/06/2024 22:13:39 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td><a href=3D"miniupnpc-2.2.8.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.3.6.t=
ar.gz'>miniupnpd-2.3.6.tar.gz</a></td>
+	<td class=3D"filesize">263018</td>
+	<td class=3D"filedate">19/03/2024 23:39:51 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td><a href=3D"miniupnpd-2.3.6.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.2.7.t=
ar.gz'>miniupnpc-2.2.7.tar.gz</a></td>
+	<td class=3D"filesize">104258</td>
+	<td class=3D"filedate">19/03/2024 23:25:18 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td><a href=3D"miniupnpc-2.2.7.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.3.5.t=
ar.gz'>miniupnpd-2.3.5.tar.gz</a></td>
+	<td class=3D"filesize">261952</td>
+	<td class=3D"filedate">02/03/2024 11:04:07 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td><a href=3D"miniupnpd-2.3.5.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.3.4.t=
ar.gz'>miniupnpd-2.3.4.tar.gz</a></td>
+	<td class=3D"filesize">260810</td>
+	<td class=3D"filedate">04/01/2024 00:53:17 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td><a href=3D"miniupnpd-2.3.4.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.2.6.t=
ar.gz'>miniupnpc-2.2.6.tar.gz</a></td>
+	<td class=3D"filesize">103949</td>
+	<td class=3D"filedate">04/01/2024 00:27:14 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td><a href=3D"miniupnpc-2.2.6.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.2.5.t=
ar.gz'>miniupnpc-2.2.5.tar.gz</a></td>
+	<td class=3D"filesize">103654</td>
+	<td class=3D"filedate">11/06/2023 23:14:56 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td><a href=3D"miniupnpc-2.2.5.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2023042=
3.tar.gz'>libnatpmp-20230423.tar.gz</a></td>
+	<td class=3D"filesize">26506</td>
+	<td class=3D"filedate">23/04/2023 11:02:09 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td><a href=3D"libnatpmp-20230423.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.3.3.t=
ar.gz'>miniupnpd-2.3.3.tar.gz</a></td>
+	<td class=3D"filesize">260079</td>
+	<td class=3D"filedate">17/02/2023 03:07:46 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td><a href=3D"miniupnpd-2.3.3.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.3.2.t=
ar.gz'>miniupnpd-2.3.2.tar.gz</a></td>
+	<td class=3D"filesize">259686</td>
+	<td class=3D"filedate">19/01/2023 23:18:08 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td><a href=3D"miniupnpd-2.3.2.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.6.0.t=
ar.gz'>minissdpd-1.6.0.tar.gz</a></td>
+	<td class=3D"filesize">39077</td>
+	<td class=3D"filedate">22/10/2022 18:41:54 +0000</td>
+	<td class=3D"comment">MiniSSDPd release source code</td>
+	<td><a href=3D"minissdpd-1.6.0.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.2.4.t=
ar.gz'>miniupnpc-2.2.4.tar.gz</a></td>
+	<td class=3D"filesize">102932</td>
+	<td class=3D"filedate">21/10/2022 21:01:01 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td><a href=3D"miniupnpc-2.2.4.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.3.1.t=
ar.gz'>miniupnpd-2.3.1.tar.gz</a></td>
+	<td class=3D"filesize">258050</td>
+	<td class=3D"filedate">16/10/2022 05:58:44 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td><a href=3D"miniupnpd-2.3.1.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0220515.zip'>upnpc-exe-win32-20220515.zip</a></td>
+	<td class=3D"filesize">69503</td>
+	<td class=3D"filedate">15/05/2022 14:31:25 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dhexchat-2.16.patc=
h'>hexchat-2.16.patch</a></td>
+	<td class=3D"filesize">8147</td>
+	<td class=3D"filedate">19/03/2022 16:52:05 +0000</td>
+	<td class=3D"comment"></td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.3.0.t=
ar.gz'>miniupnpd-2.3.0.tar.gz</a></td>
+	<td class=3D"filesize">256069</td>
+	<td class=3D"filedate">23/01/2022 00:23:32 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td><a href=3D"miniupnpd-2.3.0.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.5.202=
11105.tar.gz'>minissdpd-1.5.20211105.tar.gz</a></td>
+	<td class=3D"filesize">38870</td>
+	<td class=3D"filedate">04/11/2021 23:34:49 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td><a href=3D"minissdpd-1.5.20211105.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.2.3.t=
ar.gz'>miniupnpc-2.2.3.tar.gz</a></td>
+	<td class=3D"filesize">101360</td>
+	<td class=3D"filedate">28/09/2021 21:43:32 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td><a href=3D"miniupnpc-2.2.3.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.2.3.t=
ar.gz'>miniupnpd-2.2.3.tar.gz</a></td>
+	<td class=3D"filesize">254752</td>
+	<td class=3D"filedate">21/08/2021 08:35:13 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td><a href=3D"miniupnpd-2.2.3.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.2.2.t=
ar.gz'>miniupnpd-2.2.2.tar.gz</a></td>
+	<td class=3D"filesize">250649</td>
+	<td class=3D"filedate">13/05/2021 11:30:11 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td><a href=3D"miniupnpd-2.2.2.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.2.2.t=
ar.gz'>miniupnpc-2.2.2.tar.gz</a></td>
+	<td class=3D"filesize">100008</td>
+	<td class=3D"filedate">02/03/2021 23:44:52 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td><a href=3D"miniupnpc-2.2.2.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.2.1.t=
ar.gz'>miniupnpd-2.2.1.tar.gz</a></td>
+	<td class=3D"filesize">250023</td>
+	<td class=3D"filedate">20/12/2020 18:08:08 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td><a href=3D"miniupnpd-2.2.1.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.2.1.t=
ar.gz'>miniupnpc-2.2.1.tar.gz</a></td>
+	<td class=3D"filesize">99595</td>
+	<td class=3D"filedate">20/12/2020 18:08:02 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td><a href=3D"miniupnpc-2.2.1.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.2.0.t=
ar.gz'>miniupnpc-2.2.0.tar.gz</a></td>
+	<td class=3D"filesize">98348</td>
+	<td class=3D"filedate">09/11/2020 19:51:24 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td><a href=3D"miniupnpc-2.2.0.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.2.0.t=
ar.gz'>miniupnpd-2.2.0.tar.gz</a></td>
+	<td class=3D"filesize">249858</td>
+	<td class=3D"filedate">31/10/2020 09:20:59 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td><a href=3D"miniupnpd-2.2.0.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.2.0-R=
C3.tar.gz'>miniupnpd-2.2.0-RC3.tar.gz</a></td>
+	<td class=3D"filesize">249879</td>
+	<td class=3D"filedate">30/10/2020 21:49:49 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td><a href=3D"miniupnpd-2.2.0-RC3.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.1.202=
01016.tar.gz'>miniupnpc-2.1.20201016.tar.gz</a></td>
+	<td class=3D"filesize">97682</td>
+	<td class=3D"filedate">15/10/2020 22:31:09 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td><a href=3D"miniupnpc-2.1.20201016.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.2.0-R=
C2.tar.gz'>miniupnpd-2.2.0-RC2.tar.gz</a></td>
+	<td class=3D"filesize">248756</td>
+	<td class=3D"filedate">28/09/2020 21:57:22 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td><a href=3D"miniupnpd-2.2.0-RC2.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.1.202=
00928.tar.gz'>miniupnpc-2.1.20200928.tar.gz</a></td>
+	<td class=3D"filesize">96508</td>
+	<td class=3D"filedate">28/09/2020 21:56:09 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td><a href=3D"miniupnpc-2.1.20200928.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.5.202=
00928.tar.gz'>minissdpd-1.5.20200928.tar.gz</a></td>
+	<td class=3D"filesize">37860</td>
+	<td class=3D"filedate">28/09/2020 21:55:40 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td><a href=3D"minissdpd-1.5.20200928.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.2.0-R=
C1.tar.gz'>miniupnpd-2.2.0-RC1.tar.gz</a></td>
+	<td class=3D"filesize">247772</td>
+	<td class=3D"filedate">06/06/2020 18:34:50 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td><a href=3D"miniupnpd-2.2.0-RC1.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.2.0-R=
C0.tar.gz'>miniupnpd-2.2.0-RC0.tar.gz</a></td>
+	<td class=3D"filesize">245507</td>
+	<td class=3D"filedate">16/05/2020 18:03:17 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td><a href=3D"miniupnpd-2.2.0-RC0.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.1.202=
00510.tar.gz'>miniupnpd-2.1.20200510.tar.gz</a></td>
+	<td class=3D"filesize">245426</td>
+	<td class=3D"filedate">10/05/2020 18:23:13 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td><a href=3D"miniupnpd-2.1.20200510.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.1.202=
00329.tar.gz'>miniupnpd-2.1.20200329.tar.gz</a></td>
+	<td class=3D"filesize">243725</td>
+	<td class=3D"filedate">29/03/2020 09:11:02 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td><a href=3D"miniupnpd-2.1.20200329.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.1.201=
91224.tar.gz'>miniupnpc-2.1.20191224.tar.gz</a></td>
+	<td class=3D"filesize">94740</td>
+	<td class=3D"filedate">23/12/2019 23:37:32 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td><a href=3D"miniupnpc-2.1.20191224.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.1.201=
91006.tar.gz'>miniupnpd-2.1.20191006.tar.gz</a></td>
+	<td class=3D"filesize">243255</td>
+	<td class=3D"filedate">06/10/2019 21:02:31 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td><a href=3D"miniupnpd-2.1.20191006.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.1.201=
91005.tar.gz'>miniupnpd-2.1.20191005.tar.gz</a></td>
+	<td class=3D"filesize">244100</td>
+	<td class=3D"filedate">05/10/2019 21:33:08 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td><a href=3D"miniupnpd-2.1.20191005.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.1.201=
91003.tar.gz'>miniupnpd-2.1.20191003.tar.gz</a></td>
+	<td class=3D"filesize">243287</td>
+	<td class=3D"filedate">02/10/2019 22:23:51 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td><a href=3D"miniupnpd-2.1.20191003.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.1.201=
90924.tar.gz'>miniupnpd-2.1.20190924.tar.gz</a></td>
+	<td class=3D"filesize">241008</td>
+	<td class=3D"filedate">24/09/2019 11:58:15 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td><a href=3D"miniupnpd-2.1.20190924.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.1.201=
90902.tar.gz'>miniupnpd-2.1.20190902.tar.gz</a></td>
+	<td class=3D"filesize">240742</td>
+	<td class=3D"filedate">01/09/2019 23:03:03 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td><a href=3D"miniupnpd-2.1.20190902.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.1.201=
90824.tar.gz'>miniupnpd-2.1.20190824.tar.gz</a></td>
+	<td class=3D"filesize">240490</td>
+	<td class=3D"filedate">24/08/2019 09:21:52 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td><a href=3D"miniupnpd-2.1.20190824.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.5.201=
90824.tar.gz'>minissdpd-1.5.20190824.tar.gz</a></td>
+	<td class=3D"filesize">37300</td>
+	<td class=3D"filedate">24/08/2019 09:17:32 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td><a href=3D"minissdpd-1.5.20190824.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.1.201=
90824.tar.gz'>miniupnpc-2.1.20190824.tar.gz</a></td>
+	<td class=3D"filesize">94564</td>
+	<td class=3D"filedate">24/08/2019 09:12:50 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td><a href=3D"miniupnpc-2.1.20190824.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.1.201=
90630.tar.gz'>miniupnpd-2.1.20190630.tar.gz</a></td>
+	<td class=3D"filesize">240466</td>
+	<td class=3D"filedate">30/06/2019 20:27:38 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td><a href=3D"miniupnpd-2.1.20190630.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.1.201=
90625.tar.gz'>miniupnpd-2.1.20190625.tar.gz</a></td>
+	<td class=3D"filesize">240120</td>
+	<td class=3D"filedate">25/06/2019 21:33:49 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td><a href=3D"miniupnpd-2.1.20190625.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.1.201=
90625.tar.gz'>miniupnpc-2.1.20190625.tar.gz</a></td>
+	<td class=3D"filesize">94461</td>
+	<td class=3D"filedate">25/06/2019 21:33:26 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td><a href=3D"miniupnpc-2.1.20190625.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.1.201=
90502.tar.gz'>miniupnpd-2.1.20190502.tar.gz</a></td>
+	<td class=3D"filesize">236052</td>
+	<td class=3D"filedate">02/05/2019 17:22:23 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td><a href=3D"miniupnpd-2.1.20190502.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.1.201=
90408.tar.gz'>miniupnpc-2.1.20190408.tar.gz</a></td>
+	<td class=3D"filesize">94216</td>
+	<td class=3D"filedate">08/04/2019 12:50:21 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td><a href=3D"miniupnpc-2.1.20190408.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.1.201=
90408.tar.gz'>miniupnpd-2.1.20190408.tar.gz</a></td>
+	<td class=3D"filesize">235989</td>
+	<td class=3D"filedate">08/04/2019 12:50:01 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td><a href=3D"miniupnpd-2.1.20190408.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.1.201=
90403.tar.gz'>miniupnpc-2.1.20190403.tar.gz</a></td>
+	<td class=3D"filesize">94204</td>
+	<td class=3D"filedate">03/04/2019 15:41:36 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td><a href=3D"miniupnpc-2.1.20190403.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.1.201=
90403.tar.gz'>miniupnpd-2.1.20190403.tar.gz</a></td>
+	<td class=3D"filesize">235909</td>
+	<td class=3D"filedate">03/04/2019 15:41:17 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td><a href=3D"miniupnpd-2.1.20190403.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.5.201=
90210.tar.gz'>minissdpd-1.5.20190210.tar.gz</a></td>
+	<td class=3D"filesize">37227</td>
+	<td class=3D"filedate">10/02/2019 15:21:49 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td><a href=3D"minissdpd-1.5.20190210.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.1.201=
90210.tar.gz'>miniupnpc-2.1.20190210.tar.gz</a></td>
+	<td class=3D"filesize">94125</td>
+	<td class=3D"filedate">10/02/2019 12:46:09 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td><a href=3D"miniupnpc-2.1.20190210.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.1.201=
90210.tar.gz'>miniupnpd-2.1.20190210.tar.gz</a></td>
+	<td class=3D"filesize">235093</td>
+	<td class=3D"filedate">10/02/2019 11:20:11 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td><a href=3D"miniupnpd-2.1.20190210.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.1.201=
80706.tar.gz'>miniupnpd-2.1.20180706.tar.gz</a></td>
+	<td class=3D"filesize">233675</td>
+	<td class=3D"filedate">06/07/2018 12:44:24 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td><a href=3D"miniupnpd-2.1.20180706.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.1.tar=
.gz'>miniupnpd-2.1.tar.gz</a></td>
+	<td class=3D"filesize">225458</td>
+	<td class=3D"filedate">08/05/2018 21:50:32 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td><a href=3D"miniupnpd-2.1.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.1.tar=
.gz'>miniupnpc-2.1.tar.gz</a></td>
+	<td class=3D"filesize">91914</td>
+	<td class=3D"filedate">07/05/2018 11:10:59 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td><a href=3D"miniupnpc-2.1.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.0.201=
80503.tar.gz'>miniupnpd-2.0.20180503.tar.gz</a></td>
+	<td class=3D"filesize">225454</td>
+	<td class=3D"filedate">03/05/2018 08:33:10 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.0.201=
80503.tar.gz'>miniupnpc-2.0.20180503.tar.gz</a></td>
+	<td class=3D"filesize">88207</td>
+	<td class=3D"filedate">03/05/2018 08:31:22 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.0.201=
80422.tar.gz'>miniupnpd-2.0.20180422.tar.gz</a></td>
+	<td class=3D"filesize">224942</td>
+	<td class=3D"filedate">22/04/2018 19:48:54 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.0.201=
80412.tar.gz'>miniupnpd-2.0.20180412.tar.gz</a></td>
+	<td class=3D"filesize">224831</td>
+	<td class=3D"filedate">12/04/2018 08:16:25 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.0.201=
80410.tar.gz'>miniupnpd-2.0.20180410.tar.gz</a></td>
+	<td class=3D"filesize">224736</td>
+	<td class=3D"filedate">10/04/2018 07:58:28 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.0.201=
80410.tar.gz'>miniupnpc-2.0.20180410.tar.gz</a></td>
+	<td class=3D"filesize">87363</td>
+	<td class=3D"filedate">10/04/2018 07:52:55 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.0.201=
80406.tar.gz'>miniupnpc-2.0.20180406.tar.gz</a></td>
+	<td class=3D"filesize">87374</td>
+	<td class=3D"filedate">06/04/2018 10:55:21 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.5.201=
80223.tar.gz'>minissdpd-1.5.20180223.tar.gz</a></td>
+	<td class=3D"filesize">36179</td>
+	<td class=3D"filedate">23/02/2018 14:24:07 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.0.201=
80222.tar.gz'>miniupnpc-2.0.20180222.tar.gz</a></td>
+	<td class=3D"filesize">87018</td>
+	<td class=3D"filedate">22/02/2018 15:09:24 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.0.201=
80222.tar.gz'>miniupnpd-2.0.20180222.tar.gz</a></td>
+	<td class=3D"filesize">223697</td>
+	<td class=3D"filedate">22/02/2018 15:09:14 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.0.201=
80203.tar.gz'>miniupnpd-2.0.20180203.tar.gz</a></td>
+	<td class=3D"filesize">223084</td>
+	<td class=3D"filedate">03/02/2018 22:34:46 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.0.201=
80203.tar.gz'>miniupnpc-2.0.20180203.tar.gz</a></td>
+	<td class=3D"filesize">86772</td>
+	<td class=3D"filedate">03/02/2018 22:34:32 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.5.201=
80203.tar.gz'>minissdpd-1.5.20180203.tar.gz</a></td>
+	<td class=3D"filesize">35848</td>
+	<td class=3D"filedate">03/02/2018 22:33:08 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.0.201=
71212.tar.gz'>miniupnpc-2.0.20171212.tar.gz</a></td>
+	<td class=3D"filesize">86607</td>
+	<td class=3D"filedate">12/12/2017 12:03:38 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.0.201=
71212.tar.gz'>miniupnpd-2.0.20171212.tar.gz</a></td>
+	<td class=3D"filesize">222617</td>
+	<td class=3D"filedate">12/12/2017 12:03:32 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.0.201=
71102.tar.gz'>miniupnpc-2.0.20171102.tar.gz</a></td>
+	<td class=3D"filesize">86363</td>
+	<td class=3D"filedate">02/11/2017 17:58:34 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.0.201=
70509.tar.gz'>miniupnpc-2.0.20170509.tar.gz</a></td>
+	<td class=3D"filesize">86055</td>
+	<td class=3D"filedate">09/05/2017 10:14:56 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.0.201=
70421.tar.gz'>miniupnpc-2.0.20170421.tar.gz</a></td>
+	<td class=3D"filesize">85984</td>
+	<td class=3D"filedate">21/04/2017 12:02:26 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.0.201=
70421.tar.gz'>miniupnpd-2.0.20170421.tar.gz</a></td>
+	<td class=3D"filesize">219191</td>
+	<td class=3D"filedate">21/04/2017 12:02:06 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.0.201=
61216.tar.gz'>miniupnpd-2.0.20161216.tar.gz</a></td>
+	<td class=3D"filesize">218119</td>
+	<td class=3D"filedate">16/12/2016 09:34:08 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.0.201=
61216.tar.gz'>miniupnpc-2.0.20161216.tar.gz</a></td>
+	<td class=3D"filesize">85780</td>
+	<td class=3D"filedate">16/12/2016 09:34:03 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.5.201=
61216.tar.gz'>minissdpd-1.5.20161216.tar.gz</a></td>
+	<td class=3D"filesize">35078</td>
+	<td class=3D"filedate">16/12/2016 09:33:59 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2.0.tar=
.gz'>miniupnpd-2.0.tar.gz</a></td>
+	<td class=3D"filesize">217802</td>
+	<td class=3D"filedate">19/04/2016 21:12:01 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td><a href=3D"miniupnpd-2.0.tar.gz.sig">Signature</a></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2.0.tar=
.gz'>miniupnpc-2.0.tar.gz</a></td>
+	<td class=3D"filesize">85287</td>
+	<td class=3D"filedate">19/04/2016 21:07:52 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.5.201=
60301.tar.gz'>minissdpd-1.5.20160301.tar.gz</a></td>
+	<td class=3D"filesize">34827</td>
+	<td class=3D"filedate">01/03/2016 18:08:23 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.9.201=
60222.tar.gz'>miniupnpd-1.9.20160222.tar.gz</a></td>
+	<td class=3D"filesize">217541</td>
+	<td class=3D"filedate">22/02/2016 10:21:40 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.9.201=
60216.tar.gz'>miniupnpd-1.9.20160216.tar.gz</a></td>
+	<td class=3D"filesize">217007</td>
+	<td class=3D"filedate">16/02/2016 12:41:44 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.9.201=
60212.tar.gz'>miniupnpd-1.9.20160212.tar.gz</a></td>
+	<td class=3D"filesize">215866</td>
+	<td class=3D"filedate">12/02/2016 15:22:04 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.9.201=
60209.tar.gz'>miniupnpd-1.9.20160209.tar.gz</a></td>
+	<td class=3D"filesize">213416</td>
+	<td class=3D"filedate">09/02/2016 09:47:03 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
60209.tar.gz'>miniupnpc-1.9.20160209.tar.gz</a></td>
+	<td class=3D"filesize">85268</td>
+	<td class=3D"filedate">09/02/2016 09:44:50 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.5.201=
60119.tar.gz'>minissdpd-1.5.20160119.tar.gz</a></td>
+	<td class=3D"filesize">34711</td>
+	<td class=3D"filedate">19/01/2016 13:39:51 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.9.201=
60113.tar.gz'>miniupnpd-1.9.20160113.tar.gz</a></td>
+	<td class=3D"filesize">211437</td>
+	<td class=3D"filedate">13/01/2016 16:03:14 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.5.tar=
.gz'>minissdpd-1.5.tar.gz</a></td>
+	<td class=3D"filesize">34404</td>
+	<td class=3D"filedate">13/01/2016 15:26:53 +0000</td>
+	<td class=3D"comment">MiniSSDPd release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.9.201=
51212.tar.gz'>miniupnpd-1.9.20151212.tar.gz</a></td>
+	<td class=3D"filesize">210912</td>
+	<td class=3D"filedate">12/12/2015 10:06:07 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.9.201=
51118.tar.gz'>miniupnpd-1.9.20151118.tar.gz</a></td>
+	<td class=3D"filesize">210322</td>
+	<td class=3D"filedate">18/11/2015 08:59:46 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
51026.tar.gz'>miniupnpc-1.9.20151026.tar.gz</a></td>
+	<td class=3D"filesize">84208</td>
+	<td class=3D"filedate">26/10/2015 17:07:34 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
51008.tar.gz'>miniupnpc-1.9.20151008.tar.gz</a></td>
+	<td class=3D"filesize">83538</td>
+	<td class=3D"filedate">08/10/2015 16:22:28 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.9.201=
50922.tar.gz'>miniupnpd-1.9.20150922.tar.gz</a></td>
+	<td class=3D"filesize">208700</td>
+	<td class=3D"filedate">22/09/2015 10:21:50 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0150918.zip'>upnpc-exe-win32-20150918.zip</a></td>
+	<td class=3D"filesize">100004</td>
+	<td class=3D"filedate">18/09/2015 12:50:51 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
50917.tar.gz'>miniupnpc-1.9.20150917.tar.gz</a></td>
+	<td class=3D"filesize">82609</td>
+	<td class=3D"filedate">17/09/2015 14:09:14 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0150824.zip'>upnpc-exe-win32-20150824.zip</a></td>
+	<td class=3D"filesize">99520</td>
+	<td class=3D"filedate">24/08/2015 15:25:18 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.4.tar=
.gz'>minissdpd-1.4.tar.gz</a></td>
+	<td class=3D"filesize">32017</td>
+	<td class=3D"filedate">06/08/2015 13:38:37 +0000</td>
+	<td class=3D"comment">MiniSSDPd release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
50730.tar.gz'>miniupnpc-1.9.20150730.tar.gz</a></td>
+	<td class=3D"filesize">81431</td>
+	<td class=3D"filedate">29/07/2015 22:10:00 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.9.201=
50721.tar.gz'>miniupnpd-1.9.20150721.tar.gz</a></td>
+	<td class=3D"filesize">207562</td>
+	<td class=3D"filedate">21/07/2015 13:35:51 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
50721.tar.gz'>miniupnpc-1.9.20150721.tar.gz</a></td>
+	<td class=3D"filesize">80521</td>
+	<td class=3D"filedate">21/07/2015 13:27:00 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2015060=
9.tar.gz'>libnatpmp-20150609.tar.gz</a></td>
+	<td class=3D"filesize">24392</td>
+	<td class=3D"filedate">09/06/2015 15:40:28 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
50609.tar.gz'>miniupnpc-1.9.20150609.tar.gz</a></td>
+	<td class=3D"filesize">79311</td>
+	<td class=3D"filedate">09/06/2015 15:39:48 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.9.201=
50609.tar.gz'>miniupnpd-1.9.20150609.tar.gz</a></td>
+	<td class=3D"filesize">207088</td>
+	<td class=3D"filedate">09/06/2015 15:39:36 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.3.201=
50527.tar.gz'>minissdpd-1.3.20150527.tar.gz</a></td>
+	<td class=3D"filesize">31025</td>
+	<td class=3D"filedate">27/05/2015 09:17:15 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
50522.tar.gz'>miniupnpc-1.9.20150522.tar.gz</a></td>
+	<td class=3D"filesize">79080</td>
+	<td class=3D"filedate">22/05/2015 11:02:27 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.3.201=
50522.tar.gz'>minissdpd-1.3.20150522.tar.gz</a></td>
+	<td class=3D"filesize">30334</td>
+	<td class=3D"filedate">22/05/2015 11:02:04 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.9.201=
50430.tar.gz'>miniupnpd-1.9.20150430.tar.gz</a></td>
+	<td class=3D"filesize">205930</td>
+	<td class=3D"filedate">30/04/2015 09:09:27 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
50430.tar.gz'>miniupnpc-1.9.20150430.tar.gz</a></td>
+	<td class=3D"filesize">78459</td>
+	<td class=3D"filedate">30/04/2015 08:39:31 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
50427.tar.gz'>miniupnpc-1.9.20150427.tar.gz</a></td>
+	<td class=3D"filesize">78424</td>
+	<td class=3D"filedate">27/04/2015 16:08:42 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.9.201=
50427.tar.gz'>miniupnpd-1.9.20150427.tar.gz</a></td>
+	<td class=3D"filesize">191157</td>
+	<td class=3D"filedate">27/04/2015 16:08:27 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.9.201=
50307.tar.gz'>miniupnpd-1.9.20150307.tar.gz</a></td>
+	<td class=3D"filesize">190913</td>
+	<td class=3D"filedate">07/03/2015 16:11:51 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
50206.tar.gz'>miniupnpc-1.9.20150206.tar.gz</a></td>
+	<td class=3D"filesize">76864</td>
+	<td class=3D"filedate">06/02/2015 14:38:00 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.9.201=
41209.tar.gz'>miniupnpd-1.9.20141209.tar.gz</a></td>
+	<td class=3D"filesize">193183</td>
+	<td class=3D"filedate">09/12/2014 09:58:34 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.3.tar=
.gz'>minissdpd-1.3.tar.gz</a></td>
+	<td class=3D"filesize">30326</td>
+	<td class=3D"filedate">09/12/2014 09:57:30 +0000</td>
+	<td class=3D"comment">MiniSSDPd release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.2.201=
41204.tar.gz'>minissdpd-1.2.20141204.tar.gz</a></td>
+	<td class=3D"filesize">26978</td>
+	<td class=3D"filedate">04/12/2014 10:55:26 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.9.201=
41204.tar.gz'>miniupnpd-1.9.20141204.tar.gz</a></td>
+	<td class=3D"filesize">192597</td>
+	<td class=3D"filedate">04/12/2014 10:55:03 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.2.201=
41128.tar.gz'>minissdpd-1.2.20141128.tar.gz</a></td>
+	<td class=3D"filesize">26795</td>
+	<td class=3D"filedate">28/11/2014 16:33:10 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.9.201=
41128.tar.gz'>miniupnpd-1.9.20141128.tar.gz</a></td>
+	<td class=3D"filesize">192558</td>
+	<td class=3D"filedate">28/11/2014 13:31:36 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
41128.tar.gz'>miniupnpc-1.9.20141128.tar.gz</a></td>
+	<td class=3D"filesize">76541</td>
+	<td class=3D"filedate">28/11/2014 13:31:15 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
41117.tar.gz'>miniupnpc-1.9.20141117.tar.gz</a></td>
+	<td class=3D"filesize">73865</td>
+	<td class=3D"filedate">17/11/2014 09:51:36 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
41113.tar.gz'>miniupnpc-1.9.20141113.tar.gz</a></td>
+	<td class=3D"filesize">72857</td>
+	<td class=3D"filedate">13/11/2014 10:36:44 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.2.201=
41108.tar.gz'>minissdpd-1.2.20141108.tar.gz</a></td>
+	<td class=3D"filesize">22001</td>
+	<td class=3D"filedate">08/11/2014 13:55:41 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
41108.tar.gz'>miniupnpc-1.9.20141108.tar.gz</a></td>
+	<td class=3D"filesize">72781</td>
+	<td class=3D"filedate">08/11/2014 13:53:48 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.9.201=
41108.tar.gz'>miniupnpd-1.9.20141108.tar.gz</a></td>
+	<td class=3D"filesize">192413</td>
+	<td class=3D"filedate">08/11/2014 13:53:38 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.9.tar=
.gz'>miniupnpd-1.9.tar.gz</a></td>
+	<td class=3D"filesize">192183</td>
+	<td class=3D"filedate">27/10/2014 16:45:34 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
41027.tar.gz'>miniupnpc-1.9.20141027.tar.gz</a></td>
+	<td class=3D"filesize">76763</td>
+	<td class=3D"filedate">27/10/2014 16:45:25 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.201=
41022.tar.gz'>miniupnpd-1.8.20141022.tar.gz</a></td>
+	<td class=3D"filesize">191630</td>
+	<td class=3D"filedate">22/10/2014 09:17:41 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.201=
41021.tar.gz'>miniupnpd-1.8.20141021.tar.gz</a></td>
+	<td class=3D"filesize">191270</td>
+	<td class=3D"filedate">21/10/2014 14:18:58 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
40911.tar.gz'>miniupnpc-1.9.20140911.tar.gz</a></td>
+	<td class=3D"filesize">76855</td>
+	<td class=3D"filedate">11/09/2014 14:15:23 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.2.201=
40906.tar.gz'>minissdpd-1.2.20140906.tar.gz</a></td>
+	<td class=3D"filesize">21956</td>
+	<td class=3D"filedate">06/09/2014 08:34:10 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.201=
40906.tar.gz'>miniupnpd-1.8.20140906.tar.gz</a></td>
+	<td class=3D"filesize">191183</td>
+	<td class=3D"filedate">06/09/2014 08:34:02 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
40906.tar.gz'>miniupnpc-1.9.20140906.tar.gz</a></td>
+	<td class=3D"filesize">76791</td>
+	<td class=3D"filedate">06/09/2014 08:33:45 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
40701.tar.gz'>miniupnpc-1.9.20140701.tar.gz</a></td>
+	<td class=3D"filesize">76735</td>
+	<td class=3D"filedate">01/07/2014 13:06:51 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
40610.tar.gz'>miniupnpc-1.9.20140610.tar.gz</a></td>
+	<td class=3D"filesize">76674</td>
+	<td class=3D"filedate">10/06/2014 10:28:27 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.2.201=
40610.tar.gz'>minissdpd-1.2.20140610.tar.gz</a></td>
+	<td class=3D"filesize">21909</td>
+	<td class=3D"filedate">10/06/2014 10:03:29 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.201=
40523.tar.gz'>miniupnpd-1.8.20140523.tar.gz</a></td>
+	<td class=3D"filesize">190936</td>
+	<td class=3D"filedate">23/05/2014 15:48:03 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0140422.zip'>upnpc-exe-win32-20140422.zip</a></td>
+	<td class=3D"filesize">97505</td>
+	<td class=3D"filedate">22/04/2014 10:10:07 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.201=
40422.tar.gz'>miniupnpd-1.8.20140422.tar.gz</a></td>
+	<td class=3D"filesize">187225</td>
+	<td class=3D"filedate">22/04/2014 08:58:56 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.201=
40401.tar.gz'>miniupnpd-1.8.20140401.tar.gz</a></td>
+	<td class=3D"filesize">183131</td>
+	<td class=3D"filedate">01/04/2014 10:07:20 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.201=
40401.tar.gz'>miniupnpc-1.9.20140401.tar.gz</a></td>
+	<td class=3D"filesize">74703</td>
+	<td class=3D"filedate">01/04/2014 09:49:46 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2014040=
1.tar.gz'>libnatpmp-20140401.tar.gz</a></td>
+	<td class=3D"filesize">23302</td>
+	<td class=3D"filedate">01/04/2014 09:49:44 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.201=
40313.tar.gz'>miniupnpd-1.8.20140313.tar.gz</a></td>
+	<td class=3D"filesize">177120</td>
+	<td class=3D"filedate">13/03/2014 10:39:11 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.201=
40310.tar.gz'>miniupnpd-1.8.20140310.tar.gz</a></td>
+	<td class=3D"filesize">176585</td>
+	<td class=3D"filedate">09/03/2014 23:16:49 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.201=
40225.tar.gz'>miniupnpd-1.8.20140225.tar.gz</a></td>
+	<td class=3D"filesize">175183</td>
+	<td class=3D"filedate">25/02/2014 11:01:29 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.201=
40203.tar.gz'>miniupnpd-1.8.20140203.tar.gz</a></td>
+	<td class=3D"filesize">170112</td>
+	<td class=3D"filedate">03/02/2014 09:56:05 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.9.tar=
.gz'>miniupnpc-1.9.tar.gz</a></td>
+	<td class=3D"filesize">74230</td>
+	<td class=3D"filedate">31/01/2014 13:57:40 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.201=
40127.tar.gz'>miniupnpd-1.8.20140127.tar.gz</a></td>
+	<td class=3D"filesize">170467</td>
+	<td class=3D"filedate">27/01/2014 11:25:34 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0140117.zip'>upnpc-exe-win32-20140117.zip</a></td>
+	<td class=3D"filesize">97270</td>
+	<td class=3D"filedate">17/01/2014 11:37:53 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.201=
31216.tar.gz'>miniupnpd-1.8.20131216.tar.gz</a></td>
+	<td class=3D"filesize">170277</td>
+	<td class=3D"filedate">16/12/2013 16:15:40 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.201=
31213.tar.gz'>miniupnpd-1.8.20131213.tar.gz</a></td>
+	<td class=3D"filesize">169753</td>
+	<td class=3D"filedate">13/12/2013 16:18:10 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.8.201=
31209.tar.gz'>miniupnpc-1.8.20131209.tar.gz</a></td>
+	<td class=3D"filesize">73900</td>
+	<td class=3D"filedate">09/12/2013 20:52:54 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2013112=
6.tar.gz'>libnatpmp-20131126.tar.gz</a></td>
+	<td class=3D"filesize">22972</td>
+	<td class=3D"filedate">26/11/2013 08:51:36 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.8.201=
31007.tar.gz'>miniupnpc-1.8.20131007.tar.gz</a></td>
+	<td class=3D"filesize">73750</td>
+	<td class=3D"filedate">07/10/2013 10:10:25 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2013091=
1.tar.gz'>libnatpmp-20130911.tar.gz</a></td>
+	<td class=3D"filesize">18744</td>
+	<td class=3D"filedate">11/09/2013 07:35:51 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2013091=
0.tar.gz'>libnatpmp-20130910.tar.gz</a></td>
+	<td class=3D"filesize">18734</td>
+	<td class=3D"filedate">10/09/2013 20:15:34 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.2.201=
30907.tar.gz'>minissdpd-1.2.20130907.tar.gz</a></td>
+	<td class=3D"filesize">20237</td>
+	<td class=3D"filedate">07/09/2013 06:46:31 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.2.201=
30819.tar.gz'>minissdpd-1.2.20130819.tar.gz</a></td>
+	<td class=3D"filesize">20772</td>
+	<td class=3D"filedate">19/08/2013 16:50:29 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.8.201=
30801.tar.gz'>miniupnpc-1.8.20130801.tar.gz</a></td>
+	<td class=3D"filesize">73426</td>
+	<td class=3D"filedate">01/08/2013 21:38:05 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.201=
30730.tar.gz'>miniupnpd-1.8.20130730.tar.gz</a></td>
+	<td class=3D"filesize">149904</td>
+	<td class=3D"filedate">30/07/2013 11:37:48 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.201=
30607.tar.gz'>miniupnpd-1.8.20130607.tar.gz</a></td>
+	<td class=3D"filesize">149521</td>
+	<td class=3D"filedate">07/06/2013 08:46:17 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.201=
30521.tar.gz'>miniupnpd-1.8.20130521.tar.gz</a></td>
+	<td class=3D"filesize">149276</td>
+	<td class=3D"filedate">21/05/2013 09:01:33 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.201=
30503.tar.gz'>miniupnpd-1.8.20130503.tar.gz</a></td>
+	<td class=3D"filesize">148420</td>
+	<td class=3D"filedate">03/05/2013 19:27:16 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.8.201=
30503.tar.gz'>miniupnpc-1.8.20130503.tar.gz</a></td>
+	<td class=3D"filesize">71858</td>
+	<td class=3D"filedate">03/05/2013 19:27:07 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.201=
30426.tar.gz'>miniupnpd-1.8.20130426.tar.gz</a></td>
+	<td class=3D"filesize">147890</td>
+	<td class=3D"filedate">26/04/2013 16:57:20 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.8.201=
30211.tar.gz'>miniupnpc-1.8.20130211.tar.gz</a></td>
+	<td class=3D"filesize">70723</td>
+	<td class=3D"filedate">11/02/2013 10:32:44 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.201=
30207.tar.gz'>miniupnpd-1.8.20130207.tar.gz</a></td>
+	<td class=3D"filesize">147325</td>
+	<td class=3D"filedate">07/02/2013 12:29:32 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.8.tar=
.gz'>miniupnpc-1.8.tar.gz</a></td>
+	<td class=3D"filesize">70624</td>
+	<td class=3D"filedate">06/02/2013 14:31:06 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.8.tar=
.gz'>miniupnpd-1.8.tar.gz</a></td>
+	<td class=3D"filesize">146679</td>
+	<td class=3D"filedate">06/02/2013 14:30:59 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0121009.zip'>upnpc-exe-win32-20121009.zip</a></td>
+	<td class=3D"filesize">96513</td>
+	<td class=3D"filedate">09/10/2012 17:54:12 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.7.201=
21005.tar.gz'>miniupnpd-1.7.20121005.tar.gz</a></td>
+	<td class=3D"filesize">144393</td>
+	<td class=3D"filedate">04/10/2012 22:39:05 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.7.201=
20830.tar.gz'>miniupnpc-1.7.20120830.tar.gz</a></td>
+	<td class=3D"filesize">70074</td>
+	<td class=3D"filedate">30/08/2012 08:41:51 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.7.201=
20824.tar.gz'>miniupnpd-1.7.20120824.tar.gz</a></td>
+	<td class=3D"filesize">141960</td>
+	<td class=3D"filedate">24/08/2012 18:15:01 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2012082=
1.tar.gz'>libnatpmp-20120821.tar.gz</a></td>
+	<td class=3D"filesize">17832</td>
+	<td class=3D"filedate">21/08/2012 17:24:46 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.7.201=
20714.tar.gz'>miniupnpc-1.7.20120714.tar.gz</a></td>
+	<td class=3D"filesize">69570</td>
+	<td class=3D"filedate">14/07/2012 14:40:47 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.7.201=
20711.tar.gz'>miniupnpc-1.7.20120711.tar.gz</a></td>
+	<td class=3D"filesize">69580</td>
+	<td class=3D"filedate">10/07/2012 22:27:05 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.7.201=
20711.tar.gz'>miniupnpd-1.7.20120711.tar.gz</a></td>
+	<td class=3D"filesize">141380</td>
+	<td class=3D"filedate">10/07/2012 22:26:58 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.7.tar=
.gz'>miniupnpd-1.7.tar.gz</a></td>
+	<td class=3D"filesize">138047</td>
+	<td class=3D"filedate">27/05/2012 23:13:30 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.7.tar=
.gz'>miniupnpc-1.7.tar.gz</a></td>
+	<td class=3D"filesize">68327</td>
+	<td class=3D"filedate">24/05/2012 18:17:48 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.2.tar=
.gz'>minissdpd-1.2.tar.gz</a></td>
+	<td class=3D"filesize">19874</td>
+	<td class=3D"filedate">24/05/2012 18:06:24 +0000</td>
+	<td class=3D"comment">MiniSSDPd release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.6.201=
20509.tar.gz'>miniupnpd-1.6.20120509.tar.gz</a></td>
+	<td class=3D"filesize">137147</td>
+	<td class=3D"filedate">09/05/2012 10:45:44 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.6.201=
20509.tar.gz'>miniupnpc-1.6.20120509.tar.gz</a></td>
+	<td class=3D"filesize">68205</td>
+	<td class=3D"filedate">09/05/2012 10:45:41 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.1.201=
20509.tar.gz'>minissdpd-1.1.20120509.tar.gz</a></td>
+	<td class=3D"filesize">18123</td>
+	<td class=3D"filedate">09/05/2012 10:45:39 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.6.201=
20502.tar.gz'>miniupnpd-1.6.20120502.tar.gz</a></td>
+	<td class=3D"filesize">136688</td>
+	<td class=3D"filedate">01/05/2012 22:51:18 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.6.201=
20502.tar.gz'>miniupnpc-1.6.20120502.tar.gz</a></td>
+	<td class=3D"filesize">68170</td>
+	<td class=3D"filedate">01/05/2012 22:51:11 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.6.201=
20426.tar.gz'>miniupnpd-1.6.20120426.tar.gz</a></td>
+	<td class=3D"filesize">134764</td>
+	<td class=3D"filedate">26/04/2012 16:24:29 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.6.201=
20424.tar.gz'>miniupnpd-1.6.20120424.tar.gz</a></td>
+	<td class=3D"filesize">132522</td>
+	<td class=3D"filedate">23/04/2012 22:43:17 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.6.201=
20424.tar.gz'>miniupnpc-1.6.20120424.tar.gz</a></td>
+	<td class=3D"filesize">68067</td>
+	<td class=3D"filedate">23/04/2012 22:43:10 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.6.201=
20420.tar.gz'>miniupnpd-1.6.20120420.tar.gz</a></td>
+	<td class=3D"filesize">131972</td>
+	<td class=3D"filedate">20/04/2012 14:58:57 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.6.201=
20420.tar.gz'>miniupnpc-1.6.20120420.tar.gz</a></td>
+	<td class=3D"filesize">68068</td>
+	<td class=3D"filedate">20/04/2012 14:58:39 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.6.201=
20419.tar.gz'>miniupnpd-1.6.20120419.tar.gz</a></td>
+	<td class=3D"filesize">131088</td>
+	<td class=3D"filedate">18/04/2012 23:41:36 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.6.201=
20418.tar.gz'>miniupnpd-1.6.20120418.tar.gz</a></td>
+	<td class=3D"filesize">130879</td>
+	<td class=3D"filedate">18/04/2012 21:01:10 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.1.201=
20410.tar.gz'>minissdpd-1.1.20120410.tar.gz</a></td>
+	<td class=3D"filesize">18059</td>
+	<td class=3D"filedate">09/04/2012 22:45:38 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.6.201=
20410.tar.gz'>miniupnpc-1.6.20120410.tar.gz</a></td>
+	<td class=3D"filesize">67934</td>
+	<td class=3D"filedate">09/04/2012 22:45:10 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.6.201=
20406.tar.gz'>miniupnpd-1.6.20120406.tar.gz</a></td>
+	<td class=3D"filesize">128992</td>
+	<td class=3D"filedate">06/04/2012 17:52:57 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.6.201=
20320.tar.gz'>miniupnpc-1.6.20120320.tar.gz</a></td>
+	<td class=3D"filesize">67374</td>
+	<td class=3D"filedate">20/03/2012 16:55:48 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.6.201=
20320.tar.gz'>miniupnpd-1.6.20120320.tar.gz</a></td>
+	<td class=3D"filesize">127968</td>
+	<td class=3D"filedate">20/03/2012 16:46:07 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.6.201=
20305.tar.gz'>miniupnpd-1.6.20120305.tar.gz</a></td>
+	<td class=3D"filesize">126985</td>
+	<td class=3D"filedate">05/03/2012 20:42:01 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.6.201=
20207.tar.gz'>miniupnpd-1.6.20120207.tar.gz</a></td>
+	<td class=3D"filesize">127425</td>
+	<td class=3D"filedate">07/02/2012 10:21:16 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.6.201=
20203.tar.gz'>miniupnpd-1.6.20120203.tar.gz</a></td>
+	<td class=3D"filesize">126599</td>
+	<td class=3D"filedate">03/02/2012 15:14:13 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.6.201=
20125.tar.gz'>miniupnpc-1.6.20120125.tar.gz</a></td>
+	<td class=3D"filesize">67354</td>
+	<td class=3D"filedate">25/01/2012 21:12:28 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.6.201=
20121.tar.gz'>miniupnpc-1.6.20120121.tar.gz</a></td>
+	<td class=3D"filesize">67347</td>
+	<td class=3D"filedate">21/01/2012 14:07:41 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.6.201=
20121.tar.gz'>miniupnpd-1.6.20120121.tar.gz</a></td>
+	<td class=3D"filesize">126021</td>
+	<td class=3D"filedate">21/01/2012 14:07:33 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.1.201=
20121.tar.gz'>minissdpd-1.1.20120121.tar.gz</a></td>
+	<td class=3D"filesize">17762</td>
+	<td class=3D"filedate">21/01/2012 14:07:16 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0120121.zip'>upnpc-exe-win32-20120121.zip</a></td>
+	<td class=3D"filesize">94575</td>
+	<td class=3D"filedate">21/01/2012 13:59:11 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0111212.zip'>upnpc-exe-win32-20111212.zip</a></td>
+	<td class=3D"filesize">94507</td>
+	<td class=3D"filedate">12/12/2011 12:33:48 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.6.201=
11118.tar.gz'>miniupnpd-1.6.20111118.tar.gz</a></td>
+	<td class=3D"filesize">125683</td>
+	<td class=3D"filedate">18/11/2011 11:26:12 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.1.201=
11007.tar.gz'>minissdpd-1.1.20111007.tar.gz</a></td>
+	<td class=3D"filesize">17611</td>
+	<td class=3D"filedate">07/10/2011 09:47:51 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dxchat-upnp2011081=
1.patch'>xchat-upnp20110811.patch</a></td>
+	<td class=3D"filesize">10329</td>
+	<td class=3D"filedate">11/08/2011 15:18:25 +0000</td>
+	<td class=3D"comment">Patch to add UPnP capabilities to xchat</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dxchat-upnp2011081=
1-2.8.8.patch'>xchat-upnp20110811-2.8.8.patch</a></td>
+	<td class=3D"filesize">11529</td>
+	<td class=3D"filedate">11/08/2011 15:18:23 +0000</td>
+	<td class=3D"comment">Patch to add UPnP capabilities to xchat</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2011080=
8.tar.gz'>libnatpmp-20110808.tar.gz</a></td>
+	<td class=3D"filesize">17762</td>
+	<td class=3D"filedate">08/08/2011 21:21:34 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2011073=
0.tar.gz'>libnatpmp-20110730.tar.gz</a></td>
+	<td class=3D"filesize">17687</td>
+	<td class=3D"filedate">30/07/2011 13:19:31 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.1.tar=
.gz'>minissdpd-1.1.tar.gz</a></td>
+	<td class=3D"filesize">17481</td>
+	<td class=3D"filedate">30/07/2011 13:17:30 +0000</td>
+	<td class=3D"comment">MiniSSDPd release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.6.201=
10730.tar.gz'>miniupnpd-1.6.20110730.tar.gz</a></td>
+	<td class=3D"filesize">125583</td>
+	<td class=3D"filedate">30/07/2011 13:17:09 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.0.201=
10729.tar.gz'>minissdpd-1.0.20110729.tar.gz</a></td>
+	<td class=3D"filesize">15898</td>
+	<td class=3D"filedate">29/07/2011 08:47:26 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.6.tar=
.gz'>miniupnpc-1.6.tar.gz</a></td>
+	<td class=3D"filesize">66454</td>
+	<td class=3D"filedate">25/07/2011 18:03:09 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.6.tar=
.gz'>miniupnpd-1.6.tar.gz</a></td>
+	<td class=3D"filesize">124917</td>
+	<td class=3D"filedate">25/07/2011 16:37:57 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminidlna_1.0.21.m=
inissdp1.patch'>minidlna_1.0.21.minissdp1.patch</a></td>
+	<td class=3D"filesize">7598</td>
+	<td class=3D"filedate">25/07/2011 14:57:50 +0000</td>
+	<td class=3D"comment">Patch for MiniDLNA to use miniSSDPD</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2011071=
5.tar.gz'>libnatpmp-20110715.tar.gz</a></td>
+	<td class=3D"filesize">17943</td>
+	<td class=3D"filedate">15/07/2011 08:31:40 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.5.201=
10715.tar.gz'>miniupnpd-1.5.20110715.tar.gz</a></td>
+	<td class=3D"filesize">124519</td>
+	<td class=3D"filedate">15/07/2011 07:55:17 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0110714.zip'>upnpc-exe-win32-20110714.zip</a></td>
+	<td class=3D"filesize">94236</td>
+	<td class=3D"filedate">13/07/2011 23:16:01 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.5.201=
10623.tar.gz'>miniupnpd-1.5.20110623.tar.gz</a></td>
+	<td class=3D"filesize">123529</td>
+	<td class=3D"filedate">22/06/2011 22:29:15 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.5.201=
10620.tar.gz'>miniupnpd-1.5.20110620.tar.gz</a></td>
+	<td class=3D"filesize">123221</td>
+	<td class=3D"filedate">20/06/2011 14:11:11 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.5.201=
10618.tar.gz'>miniupnpd-1.5.20110618.tar.gz</a></td>
+	<td class=3D"filesize">123176</td>
+	<td class=3D"filedate">17/06/2011 23:29:18 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.5.201=
10618.tar.gz'>miniupnpc-1.5.20110618.tar.gz</a></td>
+	<td class=3D"filesize">66401</td>
+	<td class=3D"filedate">17/06/2011 23:29:17 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2011061=
8.tar.gz'>libnatpmp-20110618.tar.gz</a></td>
+	<td class=3D"filesize">17901</td>
+	<td class=3D"filedate">17/06/2011 23:29:16 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.0.201=
10618.tar.gz'>minissdpd-1.0.20110618.tar.gz</a></td>
+	<td class=3D"filesize">15193</td>
+	<td class=3D"filedate">17/06/2011 23:29:16 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename" colspan=3D"2"><a href=3D'download.php?file=3Dmin=
idlna_cvs20110529_minissdp1.patch'>minidlna_cvs20110529_minissdp1.patch</=
a></td>
+	<td class=3D"filedate">29/05/2011 21:19:09 +0000</td>
+	<td class=3D"comment">Patch for MiniDLNA to use miniSSDPD</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.5.201=
10528.tar.gz'>miniupnpd-1.5.20110528.tar.gz</a></td>
+	<td class=3D"filesize">121985</td>
+	<td class=3D"filedate">28/05/2011 09:39:04 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminidlna_1.0.19_m=
inissdp1.patch'>minidlna_1.0.19_minissdp1.patch</a></td>
+	<td class=3D"filesize">9080</td>
+	<td class=3D"filedate">27/05/2011 09:55:04 +0000</td>
+	<td class=3D"comment">Patch for MiniDLNA to use miniSSDPD</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.5.201=
10527.tar.gz'>miniupnpd-1.5.20110527.tar.gz</a></td>
+	<td class=3D"filesize">120896</td>
+	<td class=3D"filedate">27/05/2011 08:28:35 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.5.201=
10527.tar.gz'>miniupnpc-1.5.20110527.tar.gz</a></td>
+	<td class=3D"filesize">66279</td>
+	<td class=3D"filedate">27/05/2011 08:28:34 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2011052=
7.tar.gz'>libnatpmp-20110527.tar.gz</a></td>
+	<td class=3D"filesize">17627</td>
+	<td class=3D"filedate">27/05/2011 08:28:33 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.0.201=
10523.tar.gz'>minissdpd-1.0.20110523.tar.gz</a></td>
+	<td class=3D"filesize">15024</td>
+	<td class=3D"filedate">23/05/2011 12:55:31 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.5.201=
10520.tar.gz'>miniupnpd-1.5.20110520.tar.gz</a></td>
+	<td class=3D"filesize">119227</td>
+	<td class=3D"filedate">20/05/2011 18:00:41 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.5.201=
10519.tar.gz'>miniupnpd-1.5.20110519.tar.gz</a></td>
+	<td class=3D"filesize">114735</td>
+	<td class=3D"filedate">18/05/2011 22:29:06 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.5.201=
10516.tar.gz'>miniupnpd-1.5.20110516.tar.gz</a></td>
+	<td class=3D"filesize">113348</td>
+	<td class=3D"filedate">16/05/2011 09:32:51 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.5.201=
10515.tar.gz'>miniupnpd-1.5.20110515.tar.gz</a></td>
+	<td class=3D"filesize">113135</td>
+	<td class=3D"filedate">15/05/2011 21:51:29 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.5.201=
10515.tar.gz'>miniupnpc-1.5.20110515.tar.gz</a></td>
+	<td class=3D"filesize">66112</td>
+	<td class=3D"filedate">15/05/2011 21:51:28 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.5.201=
10513.tar.gz'>miniupnpd-1.5.20110513.tar.gz</a></td>
+	<td class=3D"filesize">111029</td>
+	<td class=3D"filedate">13/05/2011 14:03:12 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.5.201=
10506.tar.gz'>miniupnpc-1.5.20110506.tar.gz</a></td>
+	<td class=3D"filesize">65536</td>
+	<td class=3D"filedate">06/05/2011 16:35:38 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.4-v6.=
20100505.zip'>miniupnpc-1.4-v6.20100505.zip</a></td>
+	<td class=3D"filesize">91833</td>
+	<td class=3D"filedate">18/04/2011 20:14:11 +0000</td>
+	<td class=3D"comment"></td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.4-v6.=
20100823.zip'>miniupnpd-1.4-v6.20100823.zip</a></td>
+	<td class=3D"filesize">222235</td>
+	<td class=3D"filedate">18/04/2011 20:14:07 +0000</td>
+	<td class=3D"comment"></td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.5.201=
10418.tar.gz'>miniupnpc-1.5.20110418.tar.gz</a></td>
+	<td class=3D"filesize">61820</td>
+	<td class=3D"filedate">18/04/2011 20:09:22 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0110418.zip'>upnpc-exe-win32-20110418.zip</a></td>
+	<td class=3D"filesize">94183</td>
+	<td class=3D"filedate">18/04/2011 17:53:26 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.5.201=
10314.tar.gz'>miniupnpc-1.5.20110314.tar.gz</a></td>
+	<td class=3D"filesize">57210</td>
+	<td class=3D"filedate">14/03/2011 14:27:29 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.5.201=
10309.tar.gz'>miniupnpd-1.5.20110309.tar.gz</a></td>
+	<td class=3D"filesize">100073</td>
+	<td class=3D"filedate">09/03/2011 15:36:12 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.5.201=
10302.tar.gz'>miniupnpd-1.5.20110302.tar.gz</a></td>
+	<td class=3D"filesize">100756</td>
+	<td class=3D"filedate">02/03/2011 16:17:44 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.5.201=
10221.tar.gz'>miniupnpd-1.5.20110221.tar.gz</a></td>
+	<td class=3D"filesize">100092</td>
+	<td class=3D"filedate">20/02/2011 23:48:17 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0110215.zip'>upnpc-exe-win32-20110215.zip</a></td>
+	<td class=3D"filesize">55409</td>
+	<td class=3D"filedate">15/02/2011 23:05:00 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.5.201=
10215.tar.gz'>miniupnpc-1.5.20110215.tar.gz</a></td>
+	<td class=3D"filesize">54880</td>
+	<td class=3D"filedate">15/02/2011 11:16:04 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.5.201=
10214.tar.gz'>miniupnpd-1.5.20110214.tar.gz</a></td>
+	<td class=3D"filesize">99629</td>
+	<td class=3D"filedate">14/02/2011 18:00:43 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminidlna_1.0.18_m=
inissdp1.patch'>minidlna_1.0.18_minissdp1.patch</a></td>
+	<td class=3D"filesize">9747</td>
+	<td class=3D"filedate">02/02/2011 15:12:19 +0000</td>
+	<td class=3D"comment">Patch for MiniDLNA to use miniSSDPD</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.5.201=
10127.tar.gz'>miniupnpd-1.5.20110127.tar.gz</a></td>
+	<td class=3D"filesize">97421</td>
+	<td class=3D"filedate">27/01/2011 17:51:25 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.5.tar=
.gz'>miniupnpd-1.5.tar.gz</a></td>
+	<td class=3D"filesize">98993</td>
+	<td class=3D"filedate">04/01/2011 09:45:10 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.5.tar=
.gz'>miniupnpc-1.5.tar.gz</a></td>
+	<td class=3D"filesize">53309</td>
+	<td class=3D"filedate">04/01/2011 09:45:06 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2011010=
3.tar.gz'>libnatpmp-20110103.tar.gz</a></td>
+	<td class=3D"filesize">17529</td>
+	<td class=3D"filedate">03/01/2011 17:33:16 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.4.201=
01221.tar.gz'>miniupnpc-1.4.20101221.tar.gz</a></td>
+	<td class=3D"filesize">52342</td>
+	<td class=3D"filedate">21/12/2010 16:15:38 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0101213.zip'>upnpc-exe-win32-20101213.zip</a></td>
+	<td class=3D"filesize">52359</td>
+	<td class=3D"filedate">12/12/2010 23:44:01 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2010121=
1.tar.gz'>libnatpmp-20101211.tar.gz</a></td>
+	<td class=3D"filesize">17324</td>
+	<td class=3D"filedate">11/12/2010 17:20:36 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.4.201=
01209.tar.gz'>miniupnpc-1.4.20101209.tar.gz</a></td>
+	<td class=3D"filesize">51900</td>
+	<td class=3D"filedate">09/12/2010 16:17:30 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.4.201=
00921.tar.gz'>miniupnpd-1.4.20100921.tar.gz</a></td>
+	<td class=3D"filesize">95483</td>
+	<td class=3D"filedate">21/09/2010 15:50:00 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0100825.zip'>upnpc-exe-win32-20100825.zip</a></td>
+	<td class=3D"filesize">50636</td>
+	<td class=3D"filedate">25/08/2010 08:42:59 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.4.201=
00609.tar.gz'>miniupnpc-1.4.20100609.tar.gz</a></td>
+	<td class=3D"filesize">50390</td>
+	<td class=3D"filedate">09/06/2010 11:03:11 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0100513.zip'>upnpc-exe-win32-20100513.zip</a></td>
+	<td class=3D"filesize">50950</td>
+	<td class=3D"filedate">13/05/2010 16:54:33 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.4.201=
00511.tar.gz'>miniupnpd-1.4.20100511.tar.gz</a></td>
+	<td class=3D"filesize">93281</td>
+	<td class=3D"filedate">11/05/2010 16:22:33 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0100418.zip'>upnpc-exe-win32-20100418.zip</a></td>
+	<td class=3D"filesize">40758</td>
+	<td class=3D"filedate">17/04/2010 23:00:37 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.4.201=
00418.tar.gz'>miniupnpc-1.4.20100418.tar.gz</a></td>
+	<td class=3D"filesize">50245</td>
+	<td class=3D"filedate">17/04/2010 22:18:31 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.4.201=
00412.tar.gz'>miniupnpc-1.4.20100412.tar.gz</a></td>
+	<td class=3D"filesize">50145</td>
+	<td class=3D"filedate">12/04/2010 20:42:53 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.4.201=
00407.tar.gz'>miniupnpc-1.4.20100407.tar.gz</a></td>
+	<td class=3D"filesize">49756</td>
+	<td class=3D"filedate">07/04/2010 10:05:08 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.4.201=
00405.tar.gz'>miniupnpc-1.4.20100405.tar.gz</a></td>
+	<td class=3D"filesize">49549</td>
+	<td class=3D"filedate">05/04/2010 14:34:38 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.4.201=
00308.tar.gz'>miniupnpd-1.4.20100308.tar.gz</a></td>
+	<td class=3D"filesize">92889</td>
+	<td class=3D"filedate">08/03/2010 17:18:00 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2010020=
2.tar.gz'>libnatpmp-20100202.tar.gz</a></td>
+	<td class=3D"filesize">17231</td>
+	<td class=3D"filedate">02/02/2010 18:41:13 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.4.201=
00202.tar.gz'>miniupnpc-1.4.20100202.tar.gz</a></td>
+	<td class=3D"filesize">46710</td>
+	<td class=3D"filedate">02/02/2010 18:41:13 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.4.201=
00106.tar.gz'>miniupnpc-1.4.20100106.tar.gz</a></td>
+	<td class=3D"filesize">46659</td>
+	<td class=3D"filedate">06/01/2010 10:08:21 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.4.200=
91222.tar.gz'>miniupnpd-1.4.20091222.tar.gz</a></td>
+	<td class=3D"filesize">90993</td>
+	<td class=3D"filedate">22/12/2009 17:23:48 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2009121=
9.tar.gz'>libnatpmp-20091219.tar.gz</a></td>
+	<td class=3D"filesize">16839</td>
+	<td class=3D"filedate">19/12/2009 14:35:22 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.4.200=
91213.tar.gz'>miniupnpc-1.4.20091213.tar.gz</a></td>
+	<td class=3D"filesize">46510</td>
+	<td class=3D"filedate">12/12/2009 23:05:40 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.4.200=
91211.tar.gz'>miniupnpc-1.4.20091211.tar.gz</a></td>
+	<td class=3D"filesize">45852</td>
+	<td class=3D"filedate">11/12/2009 16:43:01 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0091210.zip'>upnpc-exe-win32-20091210.zip</a></td>
+	<td class=3D"filesize">38666</td>
+	<td class=3D"filedate">10/12/2009 18:50:27 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.4.200=
91208.tar.gz'>miniupnpc-1.4.20091208.tar.gz</a></td>
+	<td class=3D"filesize">43392</td>
+	<td class=3D"filedate">08/12/2009 10:58:26 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.4.200=
91203.tar.gz'>miniupnpc-1.4.20091203.tar.gz</a></td>
+	<td class=3D"filesize">42040</td>
+	<td class=3D"filedate">03/12/2009 13:56:28 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.4.200=
91106.tar.gz'>miniupnpd-1.4.20091106.tar.gz</a></td>
+	<td class=3D"filesize">90787</td>
+	<td class=3D"filedate">06/11/2009 21:18:50 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.4.tar=
.gz'>miniupnpd-1.4.tar.gz</a></td>
+	<td class=3D"filesize">90071</td>
+	<td class=3D"filedate">30/10/2009 09:20:05 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.4.tar=
.gz'>miniupnpc-1.4.tar.gz</a></td>
+	<td class=3D"filesize">41790</td>
+	<td class=3D"filedate">30/10/2009 09:20:04 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2009101=
6.tar.gz'>miniupnpc-20091016.tar.gz</a></td>
+	<td class=3D"filesize">41792</td>
+	<td class=3D"filedate">16/10/2009 09:04:35 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2009101=
0.tar.gz'>miniupnpd-20091010.tar.gz</a></td>
+	<td class=3D"filesize">90043</td>
+	<td class=3D"filedate">10/10/2009 19:21:30 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2009101=
0.tar.gz'>miniupnpc-20091010.tar.gz</a></td>
+	<td class=3D"filesize">41671</td>
+	<td class=3D"filedate">10/10/2009 19:21:28 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2009092=
1.tar.gz'>miniupnpd-20090921.tar.gz</a></td>
+	<td class=3D"filesize">89476</td>
+	<td class=3D"filedate">21/09/2009 13:00:04 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2009092=
1.tar.gz'>miniupnpc-20090921.tar.gz</a></td>
+	<td class=3D"filesize">41630</td>
+	<td class=3D"filedate">21/09/2009 13:00:03 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2009090=
4.tar.gz'>miniupnpd-20090904.tar.gz</a></td>
+	<td class=3D"filesize">89344</td>
+	<td class=3D"filedate">04/09/2009 16:24:26 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2009082=
0.tar.gz'>miniupnpd-20090820.tar.gz</a></td>
+	<td class=3D"filesize">89149</td>
+	<td class=3D"filedate">20/08/2009 09:35:58 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2009080=
7.tar.gz'>miniupnpc-20090807.tar.gz</a></td>
+	<td class=3D"filesize">41288</td>
+	<td class=3D"filedate">07/08/2009 14:46:11 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2009072=
9.tar.gz'>miniupnpc-20090729.tar.gz</a></td>
+	<td class=3D"filesize">40588</td>
+	<td class=3D"filedate">29/07/2009 08:47:43 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dxchat-upnp2006102=
2.patch'>xchat-upnp20061022.patch</a></td>
+	<td class=3D"filesize">10258</td>
+	<td class=3D"filedate">17/07/2009 15:49:46 +0000</td>
+	<td class=3D"comment">Patch to add UPnP capabilities to xchat</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2009071=
3.tar.gz'>miniupnpc-20090713.tar.gz</a></td>
+	<td class=3D"filesize">40206</td>
+	<td class=3D"filedate">13/07/2009 08:53:49 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2009071=
3.tar.gz'>libnatpmp-20090713.tar.gz</a></td>
+	<td class=3D"filesize">14262</td>
+	<td class=3D"filedate">13/07/2009 08:53:49 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2009060=
5.tar.gz'>miniupnpd-20090605.tar.gz</a></td>
+	<td class=3D"filesize">83774</td>
+	<td class=3D"filedate">04/06/2009 23:32:20 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2009060=
5.tar.gz'>miniupnpc-20090605.tar.gz</a></td>
+	<td class=3D"filesize">40077</td>
+	<td class=3D"filedate">04/06/2009 23:32:16 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2009060=
5.tar.gz'>libnatpmp-20090605.tar.gz</a></td>
+	<td class=3D"filesize">13817</td>
+	<td class=3D"filedate">04/06/2009 23:32:15 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2009051=
6.tar.gz'>miniupnpd-20090516.tar.gz</a></td>
+	<td class=3D"filesize">83689</td>
+	<td class=3D"filedate">16/05/2009 08:47:31 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.3.tar=
.gz'>miniupnpc-1.3.tar.gz</a></td>
+	<td class=3D"filesize">40058</td>
+	<td class=3D"filedate">17/04/2009 21:27:55 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.3.tar=
.gz'>miniupnpd-1.3.tar.gz</a></td>
+	<td class=3D"filesize">83464</td>
+	<td class=3D"filedate">17/04/2009 20:11:21 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2009031=
0.tar.gz'>libnatpmp-20090310.tar.gz</a></td>
+	<td class=3D"filesize">11847</td>
+	<td class=3D"filedate">10/03/2009 10:19:45 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2009021=
4.tar.gz'>miniupnpd-20090214.tar.gz</a></td>
+	<td class=3D"filesize">82921</td>
+	<td class=3D"filedate">14/02/2009 11:27:03 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2009021=
3.tar.gz'>miniupnpd-20090213.tar.gz</a></td>
+	<td class=3D"filesize">82594</td>
+	<td class=3D"filedate">13/02/2009 19:48:01 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2009012=
9.tar.gz'>libnatpmp-20090129.tar.gz</a></td>
+	<td class=3D"filesize">11748</td>
+	<td class=3D"filedate">29/01/2009 21:50:31 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2009012=
9.tar.gz'>miniupnpc-20090129.tar.gz</a></td>
+	<td class=3D"filesize">39976</td>
+	<td class=3D"filedate">29/01/2009 21:50:30 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2009012=
9.tar.gz'>miniupnpd-20090129.tar.gz</a></td>
+	<td class=3D"filesize">82487</td>
+	<td class=3D"filedate">29/01/2009 21:50:27 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2008100=
9.tar.gz'>miniupnpd-20081009.tar.gz</a></td>
+	<td class=3D"filesize">81732</td>
+	<td class=3D"filedate">09/10/2008 12:53:02 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.0.tar=
.gz'>minissdpd-1.0.tar.gz</a></td>
+	<td class=3D"filesize">12996</td>
+	<td class=3D"filedate">07/10/2008 14:03:49 +0000</td>
+	<td class=3D"comment">MiniSSDPd release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.2.tar=
.gz'>miniupnpc-1.2.tar.gz</a></td>
+	<td class=3D"filesize">38787</td>
+	<td class=3D"filedate">07/10/2008 14:03:47 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.2.tar=
.gz'>miniupnpd-1.2.tar.gz</a></td>
+	<td class=3D"filesize">81025</td>
+	<td class=3D"filedate">07/10/2008 14:03:45 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2008100=
6.tar.gz'>miniupnpd-20081006.tar.gz</a></td>
+	<td class=3D"filesize">80510</td>
+	<td class=3D"filedate">06/10/2008 15:50:34 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-2008100=
6.tar.gz'>minissdpd-20081006.tar.gz</a></td>
+	<td class=3D"filesize">12230</td>
+	<td class=3D"filedate">06/10/2008 15:50:33 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2008100=
6.tar.gz'>libnatpmp-20081006.tar.gz</a></td>
+	<td class=3D"filesize">11710</td>
+	<td class=3D"filedate">06/10/2008 15:50:31 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename" colspan=3D"2"><a href=3D'download.php?file=3Dmed=
iatomb_minissdp-20081006.patch'>mediatomb_minissdp-20081006.patch</a></td=
>
+	<td class=3D"filedate">06/10/2008 15:48:18 +0000</td>
+	<td class=3D"comment"></td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2008100=
2.tar.gz'>miniupnpc-20081002.tar.gz</a></td>
+	<td class=3D"filesize">38291</td>
+	<td class=3D"filedate">02/10/2008 09:20:18 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2008100=
1.tar.gz'>miniupnpd-20081001.tar.gz</a></td>
+	<td class=3D"filesize">79696</td>
+	<td class=3D"filedate">01/10/2008 13:11:20 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0080925.zip'>upnpc-exe-win32-20080925.zip</a></td>
+	<td class=3D"filesize">36602</td>
+	<td class=3D"filedate">25/09/2008 06:59:33 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2008071=
0.tar.gz'>miniupnpd-20080710.tar.gz</a></td>
+	<td class=3D"filesize">78898</td>
+	<td class=3D"filedate">10/07/2008 09:38:41 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2008070=
7.tar.gz'>libnatpmp-20080707.tar.gz</a></td>
+	<td class=3D"filesize">11679</td>
+	<td class=3D"filedate">06/07/2008 22:05:23 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.1.tar=
.gz'>miniupnpc-1.1.tar.gz</a></td>
+	<td class=3D"filesize">38235</td>
+	<td class=3D"filedate">04/07/2008 16:45:24 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2008070=
3.tar.gz'>miniupnpc-20080703.tar.gz</a></td>
+	<td class=3D"filesize">38204</td>
+	<td class=3D"filedate">03/07/2008 15:47:37 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2008070=
3.tar.gz'>libnatpmp-20080703.tar.gz</a></td>
+	<td class=3D"filesize">11570</td>
+	<td class=3D"filedate">03/07/2008 15:47:25 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0080703.zip'>upnpc-exe-win32-20080703.zip</a></td>
+	<td class=3D"filesize">36137</td>
+	<td class=3D"filedate">02/07/2008 23:35:14 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2008070=
2.tar.gz'>libnatpmp-20080702.tar.gz</a></td>
+	<td class=3D"filesize">8873</td>
+	<td class=3D"filedate">02/07/2008 17:32:35 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2008063=
0.tar.gz'>libnatpmp-20080630.tar.gz</a></td>
+	<td class=3D"filesize">8864</td>
+	<td class=3D"filedate">30/06/2008 14:20:16 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2008052=
9.tar.gz'>libnatpmp-20080529.tar.gz</a></td>
+	<td class=3D"filesize">7397</td>
+	<td class=3D"filedate">29/05/2008 09:06:25 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0080514.zip'>upnpc-exe-win32-20080514.zip</a></td>
+	<td class=3D"filesize">14227</td>
+	<td class=3D"filedate">14/05/2008 20:23:19 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2008042=
8.tar.gz'>libnatpmp-20080428.tar.gz</a></td>
+	<td class=3D"filesize">7295</td>
+	<td class=3D"filedate">28/04/2008 03:09:14 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2008042=
7.tar.gz'>miniupnpd-20080427.tar.gz</a></td>
+	<td class=3D"filesize">78765</td>
+	<td class=3D"filedate">27/04/2008 18:16:36 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2008042=
7.tar.gz'>miniupnpc-20080427.tar.gz</a></td>
+	<td class=3D"filesize">37610</td>
+	<td class=3D"filedate">27/04/2008 18:16:35 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.1.tar=
.gz'>miniupnpd-1.1.tar.gz</a></td>
+	<td class=3D"filesize">78594</td>
+	<td class=3D"filedate">25/04/2008 17:38:05 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2008042=
3.tar.gz'>miniupnpc-20080423.tar.gz</a></td>
+	<td class=3D"filesize">36818</td>
+	<td class=3D"filedate">23/04/2008 11:57:36 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2008030=
8.tar.gz'>miniupnpd-20080308.tar.gz</a></td>
+	<td class=3D"filesize">75679</td>
+	<td class=3D"filedate">08/03/2008 11:13:29 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2008030=
3.tar.gz'>miniupnpd-20080303.tar.gz</a></td>
+	<td class=3D"filesize">74202</td>
+	<td class=3D"filedate">03/03/2008 01:43:16 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2008022=
4.tar.gz'>miniupnpd-20080224.tar.gz</a></td>
+	<td class=3D"filesize">72773</td>
+	<td class=3D"filedate">24/02/2008 11:23:17 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.0.tar=
.gz'>miniupnpc-1.0.tar.gz</a></td>
+	<td class=3D"filesize">36223</td>
+	<td class=3D"filedate">21/02/2008 13:26:46 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2008022=
1.tar.gz'>miniupnpd-20080221.tar.gz</a></td>
+	<td class=3D"filesize">70823</td>
+	<td class=3D"filedate">21/02/2008 10:23:46 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2008021=
7.tar.gz'>miniupnpc-20080217.tar.gz</a></td>
+	<td class=3D"filesize">35243</td>
+	<td class=3D"filedate">16/02/2008 23:47:59 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2008020=
7.tar.gz'>miniupnpd-20080207.tar.gz</a></td>
+	<td class=3D"filesize">70647</td>
+	<td class=3D"filedate">07/02/2008 21:21:00 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2008020=
3.tar.gz'>miniupnpc-20080203.tar.gz</a></td>
+	<td class=3D"filesize">34921</td>
+	<td class=3D"filedate">03/02/2008 22:28:11 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.0.tar=
.gz'>miniupnpd-1.0.tar.gz</a></td>
+	<td class=3D"filesize">69427</td>
+	<td class=3D"filedate">27/01/2008 22:41:25 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0080118.zip'>upnpc-exe-win32-20080118.zip</a></td>
+	<td class=3D"filesize">13582</td>
+	<td class=3D"filedate">18/01/2008 11:42:16 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.0-RC1=
3.tar.gz'>miniupnpd-1.0-RC13.tar.gz</a></td>
+	<td class=3D"filesize">67892</td>
+	<td class=3D"filedate">03/01/2008 16:50:21 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.0-RC1=
3.tar.gz'>miniupnpc-1.0-RC13.tar.gz</a></td>
+	<td class=3D"filesize">34820</td>
+	<td class=3D"filedate">03/01/2008 16:50:20 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2007122=
0.tar.gz'>miniupnpd-20071220.tar.gz</a></td>
+	<td class=3D"filesize">67211</td>
+	<td class=3D"filedate">20/12/2007 12:08:34 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2007121=
9.tar.gz'>miniupnpc-20071219.tar.gz</a></td>
+	<td class=3D"filesize">34290</td>
+	<td class=3D"filedate">19/12/2007 18:31:47 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.0-RC1=
2.tar.gz'>minissdpd-1.0-RC12.tar.gz</a></td>
+	<td class=3D"filesize">9956</td>
+	<td class=3D"filedate">19/12/2007 18:30:12 +0000</td>
+	<td class=3D"comment">MiniSSDPd release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.0-RC1=
2.tar.gz'>miniupnpd-1.0-RC12.tar.gz</a></td>
+	<td class=3D"filesize">66911</td>
+	<td class=3D"filedate">14/12/2007 17:39:20 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.0-RC1=
2.tar.gz'>miniupnpc-1.0-RC12.tar.gz</a></td>
+	<td class=3D"filesize">32543</td>
+	<td class=3D"filedate">14/12/2007 17:39:19 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2007121=
3.tar.gz'>miniupnpc-20071213.tar.gz</a></td>
+	<td class=3D"filesize">32541</td>
+	<td class=3D"filedate">13/12/2007 17:09:51 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2007121=
3.tar.gz'>miniupnpd-20071213.tar.gz</a></td>
+	<td class=3D"filesize">66826</td>
+	<td class=3D"filedate">13/12/2007 16:42:50 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2007121=
3.tar.gz'>libnatpmp-20071213.tar.gz</a></td>
+	<td class=3D"filesize">5997</td>
+	<td class=3D"filedate">13/12/2007 14:56:30 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dlibnatpmp-2007120=
2.tar.gz'>libnatpmp-20071202.tar.gz</a></td>
+	<td class=3D"filesize">5664</td>
+	<td class=3D"filedate">02/12/2007 00:15:28 +0000</td>
+	<td class=3D"comment">libnatpmp source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2007110=
3.tar.gz'>miniupnpd-20071103.tar.gz</a></td>
+	<td class=3D"filesize">65740</td>
+	<td class=3D"filedate">02/11/2007 23:58:38 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2007110=
2.tar.gz'>miniupnpd-20071102.tar.gz</a></td>
+	<td class=3D"filesize">65733</td>
+	<td class=3D"filedate">02/11/2007 23:05:44 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2007110=
3.tar.gz'>miniupnpc-20071103.tar.gz</a></td>
+	<td class=3D"filesize">32239</td>
+	<td class=3D"filedate">02/11/2007 23:05:34 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.0-RC1=
1.tar.gz'>miniupnpd-1.0-RC11.tar.gz</a></td>
+	<td class=3D"filesize">64828</td>
+	<td class=3D"filedate">25/10/2007 13:27:18 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.0-RC1=
1.tar.gz'>miniupnpc-1.0-RC11.tar.gz</a></td>
+	<td class=3D"filesize">32161</td>
+	<td class=3D"filedate">25/10/2007 13:27:17 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0071025.zip'>upnpc-exe-win32-20071025.zip</a></td>
+	<td class=3D"filesize">12809</td>
+	<td class=3D"filedate">24/10/2007 23:15:55 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.0-RC1=
0.tar.gz'>miniupnpd-1.0-RC10.tar.gz</a></td>
+	<td class=3D"filesize">62674</td>
+	<td class=3D"filedate">12/10/2007 08:38:33 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.0-RC1=
0.tar.gz'>miniupnpc-1.0-RC10.tar.gz</a></td>
+	<td class=3D"filesize">31962</td>
+	<td class=3D"filedate">12/10/2007 08:38:31 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.0-RC1=
0.tar.gz'>minissdpd-1.0-RC10.tar.gz</a></td>
+	<td class=3D"filesize">9517</td>
+	<td class=3D"filedate">12/10/2007 08:38:30 +0000</td>
+	<td class=3D"comment">MiniSSDPd release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2007100=
3.tar.gz'>miniupnpc-20071003.tar.gz</a></td>
+	<td class=3D"filesize">31199</td>
+	<td class=3D"filedate">03/10/2007 15:30:13 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0071001.zip'>upnpc-exe-win32-20071001.zip</a></td>
+	<td class=3D"filesize">12604</td>
+	<td class=3D"filedate">01/10/2007 17:09:22 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.0-RC9=
.tar.gz'>miniupnpd-1.0-RC9.tar.gz</a></td>
+	<td class=3D"filesize">54778</td>
+	<td class=3D"filedate">27/09/2007 19:38:36 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-1.0-RC9=
.tar.gz'>minissdpd-1.0-RC9.tar.gz</a></td>
+	<td class=3D"filesize">9163</td>
+	<td class=3D"filedate">27/09/2007 17:00:03 +0000</td>
+	<td class=3D"comment">MiniSSDPd release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.0-RC9=
.tar.gz'>miniupnpc-1.0-RC9.tar.gz</a></td>
+	<td class=3D"filesize">30538</td>
+	<td class=3D"filedate">27/09/2007 17:00:03 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2007092=
4.tar.gz'>miniupnpd-20070924.tar.gz</a></td>
+	<td class=3D"filesize">52338</td>
+	<td class=3D"filedate">24/09/2007 20:26:05 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2007092=
3.tar.gz'>miniupnpd-20070923.tar.gz</a></td>
+	<td class=3D"filesize">51060</td>
+	<td class=3D"filedate">23/09/2007 21:13:34 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2007092=
3.tar.gz'>miniupnpc-20070923.tar.gz</a></td>
+	<td class=3D"filesize">30246</td>
+	<td class=3D"filedate">23/09/2007 21:13:33 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-2007092=
3.tar.gz'>minissdpd-20070923.tar.gz</a></td>
+	<td class=3D"filesize">8978</td>
+	<td class=3D"filedate">23/09/2007 21:13:32 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2007090=
2.tar.gz'>miniupnpc-20070902.tar.gz</a></td>
+	<td class=3D"filesize">30205</td>
+	<td class=3D"filedate">01/09/2007 23:47:23 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminissdpd-2007090=
2.tar.gz'>minissdpd-20070902.tar.gz</a></td>
+	<td class=3D"filesize">6539</td>
+	<td class=3D"filedate">01/09/2007 23:47:20 +0000</td>
+	<td class=3D"comment">MiniSSDPd source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.0-RC8=
.tar.gz'>miniupnpd-1.0-RC8.tar.gz</a></td>
+	<td class=3D"filesize">50952</td>
+	<td class=3D"filedate">29/08/2007 10:56:09 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.0-RC8=
.tar.gz'>miniupnpc-1.0-RC8.tar.gz</a></td>
+	<td class=3D"filesize">29312</td>
+	<td class=3D"filedate">29/08/2007 10:56:08 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.0-RC7=
.tar.gz'>miniupnpd-1.0-RC7.tar.gz</a></td>
+	<td class=3D"filesize">50613</td>
+	<td class=3D"filedate">20/07/2007 00:15:45 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.0-RC6=
.tar.gz'>miniupnpd-1.0-RC6.tar.gz</a></td>
+	<td class=3D"filesize">49986</td>
+	<td class=3D"filedate">12/06/2007 17:12:07 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.0-RC6=
.tar.gz'>miniupnpc-1.0-RC6.tar.gz</a></td>
+	<td class=3D"filesize">29032</td>
+	<td class=3D"filedate">12/06/2007 17:12:06 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2007060=
7.tar.gz'>miniupnpd-20070607.tar.gz</a></td>
+	<td class=3D"filesize">49768</td>
+	<td class=3D"filedate">06/06/2007 23:12:00 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2007060=
5.tar.gz'>miniupnpd-20070605.tar.gz</a></td>
+	<td class=3D"filesize">49710</td>
+	<td class=3D"filedate">05/06/2007 21:01:53 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2007052=
1.tar.gz'>miniupnpd-20070521.tar.gz</a></td>
+	<td class=3D"filesize">48374</td>
+	<td class=3D"filedate">21/05/2007 13:07:43 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0070519.zip'>upnpc-exe-win32-20070519.zip</a></td>
+	<td class=3D"filesize">10836</td>
+	<td class=3D"filedate">19/05/2007 13:14:15 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2007051=
5.tar.gz'>miniupnpc-20070515.tar.gz</a></td>
+	<td class=3D"filesize">25802</td>
+	<td class=3D"filedate">15/05/2007 18:15:25 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.0-RC5=
.tar.gz'>miniupnpd-1.0-RC5.tar.gz</a></td>
+	<td class=3D"filesize">48064</td>
+	<td class=3D"filedate">10/05/2007 20:22:48 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.0-RC5=
.tar.gz'>miniupnpc-1.0-RC5.tar.gz</a></td>
+	<td class=3D"filesize">25242</td>
+	<td class=3D"filedate">10/05/2007 20:22:46 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2007041=
2.tar.gz'>miniupnpd-20070412.tar.gz</a></td>
+	<td class=3D"filesize">47807</td>
+	<td class=3D"filedate">12/04/2007 20:21:48 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.0-RC4=
.tar.gz'>miniupnpd-1.0-RC4.tar.gz</a></td>
+	<td class=3D"filesize">47687</td>
+	<td class=3D"filedate">17/03/2007 11:43:13 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.0-RC4=
.tar.gz'>miniupnpc-1.0-RC4.tar.gz</a></td>
+	<td class=3D"filesize">25085</td>
+	<td class=3D"filedate">17/03/2007 11:43:10 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2007031=
1.tar.gz'>miniupnpd-20070311.tar.gz</a></td>
+	<td class=3D"filesize">47599</td>
+	<td class=3D"filedate">11/03/2007 00:25:26 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2007020=
8.tar.gz'>miniupnpd-20070208.tar.gz</a></td>
+	<td class=3D"filesize">45084</td>
+	<td class=3D"filedate">07/02/2007 23:04:06 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.0-RC3=
.tar.gz'>miniupnpd-1.0-RC3.tar.gz</a></td>
+	<td class=3D"filesize">44683</td>
+	<td class=3D"filedate">30/01/2007 23:00:44 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.0-RC3=
.tar.gz'>miniupnpc-1.0-RC3.tar.gz</a></td>
+	<td class=3D"filesize">25055</td>
+	<td class=3D"filedate">30/01/2007 23:00:42 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2007013=
0.tar.gz'>miniupnpd-20070130.tar.gz</a></td>
+	<td class=3D"filesize">43735</td>
+	<td class=3D"filedate">29/01/2007 23:26:16 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2007013=
0.tar.gz'>miniupnpc-20070130.tar.gz</a></td>
+	<td class=3D"filesize">24466</td>
+	<td class=3D"filedate">29/01/2007 23:26:13 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2007012=
7.tar.gz'>miniupnpd-20070127.tar.gz</a></td>
+	<td class=3D"filesize">42643</td>
+	<td class=3D"filedate">27/01/2007 16:02:35 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2007012=
7.tar.gz'>miniupnpc-20070127.tar.gz</a></td>
+	<td class=3D"filesize">24241</td>
+	<td class=3D"filedate">27/01/2007 16:02:33 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.0-RC2=
.tar.gz'>miniupnpd-1.0-RC2.tar.gz</a></td>
+	<td class=3D"filesize">40424</td>
+	<td class=3D"filedate">17/01/2007 16:13:05 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2007011=
2.tar.gz'>miniupnpd-20070112.tar.gz</a></td>
+	<td class=3D"filesize">40708</td>
+	<td class=3D"filedate">12/01/2007 13:40:50 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2007011=
1.tar.gz'>miniupnpd-20070111.tar.gz</a></td>
+	<td class=3D"filesize">40651</td>
+	<td class=3D"filedate">11/01/2007 18:50:21 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2007010=
8.tar.gz'>miniupnpd-20070108.tar.gz</a></td>
+	<td class=3D"filesize">40025</td>
+	<td class=3D"filedate">08/01/2007 10:02:14 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2007010=
3.tar.gz'>miniupnpd-20070103.tar.gz</a></td>
+	<td class=3D"filesize">40065</td>
+	<td class=3D"filedate">03/01/2007 14:39:11 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-2006121=
4.tar.gz'>miniupnpc-20061214.tar.gz</a></td>
+	<td class=3D"filesize">24106</td>
+	<td class=3D"filedate">14/12/2006 15:43:54 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-2006121=
4.tar.gz'>miniupnpd-20061214.tar.gz</a></td>
+	<td class=3D"filesize">39750</td>
+	<td class=3D"filedate">14/12/2006 13:44:51 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd-1.0-RC1=
.tar.gz'>miniupnpd-1.0-RC1.tar.gz</a></td>
+	<td class=3D"filesize">39572</td>
+	<td class=3D"filedate">07/12/2006 10:55:31 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-1.0-RC1=
.tar.gz'>miniupnpc-1.0-RC1.tar.gz</a></td>
+	<td class=3D"filesize">23582</td>
+	<td class=3D"filedate">07/12/2006 10:55:30 +0000</td>
+	<td class=3D"comment">MiniUPnP client release source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0061201.zip'>upnpc-exe-win32-20061201.zip</a></td>
+	<td class=3D"filesize">10378</td>
+	<td class=3D"filedate">01/12/2006 00:33:08 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20061130=
.tar.gz'>miniupnpd20061130.tar.gz</a></td>
+	<td class=3D"filesize">37184</td>
+	<td class=3D"filedate">30/11/2006 12:25:25 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20061129=
.tar.gz'>miniupnpd20061129.tar.gz</a></td>
+	<td class=3D"filesize">36045</td>
+	<td class=3D"filedate">29/11/2006 00:10:49 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20061127=
.tar.gz'>miniupnpd20061127.tar.gz</a></td>
+	<td class=3D"filesize">34155</td>
+	<td class=3D"filedate">26/11/2006 23:15:28 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc20061123=
.tar.gz'>miniupnpc20061123.tar.gz</a></td>
+	<td class=3D"filesize">21004</td>
+	<td class=3D"filedate">23/11/2006 22:41:46 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename" colspan=3D"2"><a href=3D'download.php?file=3Dmin=
iupnpd-bin-openwrt20061123.tar.gz'>miniupnpd-bin-openwrt20061123.tar.gz</=
a></td>
+	<td class=3D"filedate">23/11/2006 22:41:44 +0000</td>
+	<td class=3D"comment">Precompiled binaries for openwrt</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20061123=
.tar.gz'>miniupnpd20061123.tar.gz</a></td>
+	<td class=3D"filesize">33809</td>
+	<td class=3D"filedate">23/11/2006 22:28:29 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc20061119=
.tar.gz'>miniupnpc20061119.tar.gz</a></td>
+	<td class=3D"filesize">20897</td>
+	<td class=3D"filedate">19/11/2006 22:50:37 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20061119=
.tar.gz'>miniupnpd20061119.tar.gz</a></td>
+	<td class=3D"filesize">32580</td>
+	<td class=3D"filedate">19/11/2006 22:50:36 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20061117=
.tar.gz'>miniupnpd20061117.tar.gz</a></td>
+	<td class=3D"filesize">32646</td>
+	<td class=3D"filedate">17/11/2006 13:29:33 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0061112.zip'>upnpc-exe-win32-20061112.zip</a></td>
+	<td class=3D"filesize">10262</td>
+	<td class=3D"filedate">12/11/2006 22:41:25 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20061112=
.tar.gz'>miniupnpd20061112.tar.gz</a></td>
+	<td class=3D"filesize">32023</td>
+	<td class=3D"filedate">12/11/2006 21:30:32 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc20061112=
.tar.gz'>miniupnpc20061112.tar.gz</a></td>
+	<td class=3D"filesize">21047</td>
+	<td class=3D"filedate">12/11/2006 21:30:31 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20061110=
.tar.gz'>miniupnpd20061110.tar.gz</a></td>
+	<td class=3D"filesize">27926</td>
+	<td class=3D"filedate">09/11/2006 23:35:02 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc20061110=
.tar.gz'>miniupnpc20061110.tar.gz</a></td>
+	<td class=3D"filesize">21009</td>
+	<td class=3D"filedate">09/11/2006 23:32:19 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0061101.zip'>upnpc-exe-win32-20061101.zip</a></td>
+	<td class=3D"filesize">10089</td>
+	<td class=3D"filedate">08/11/2006 20:35:09 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0061020.zip'>upnpc-exe-win32-20061020.zip</a></td>
+	<td class=3D"filesize">9183</td>
+	<td class=3D"filedate">08/11/2006 20:35:08 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0060909.zip'>upnpc-exe-win32-20060909.zip</a></td>
+	<td class=3D"filesize">9994</td>
+	<td class=3D"filedate">08/11/2006 20:35:07 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0060801.zip'>upnpc-exe-win32-20060801.zip</a></td>
+	<td class=3D"filesize">10002</td>
+	<td class=3D"filedate">08/11/2006 20:35:06 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0060711.zip'>upnpc-exe-win32-20060711.zip</a></td>
+	<td class=3D"filesize">13733</td>
+	<td class=3D"filedate">08/11/2006 20:35:05 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0060709.zip'>upnpc-exe-win32-20060709.zip</a></td>
+	<td class=3D"filesize">13713</td>
+	<td class=3D"filedate">08/11/2006 20:35:04 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dupnpc-exe-win32-2=
0060704.zip'>upnpc-exe-win32-20060704.zip</a></td>
+	<td class=3D"filesize">13297</td>
+	<td class=3D"filedate">08/11/2006 20:35:03 +0000</td>
+	<td class=3D"comment">Windows executable</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc20061107=
.tar.gz'>miniupnpc20061107.tar.gz</a></td>
+	<td class=3D"filesize">20708</td>
+	<td class=3D"filedate">06/11/2006 23:36:57 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20061107=
.tar.gz'>miniupnpd20061107.tar.gz</a></td>
+	<td class=3D"filesize">26992</td>
+	<td class=3D"filedate">06/11/2006 23:35:06 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc20061106=
.tar.gz'>miniupnpc20061106.tar.gz</a></td>
+	<td class=3D"filesize">20575</td>
+	<td class=3D"filedate">06/11/2006 17:02:15 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20061106=
.tar.gz'>miniupnpd20061106.tar.gz</a></td>
+	<td class=3D"filesize">26597</td>
+	<td class=3D"filedate">06/11/2006 15:39:10 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc20061101=
.tar.gz'>miniupnpc20061101.tar.gz</a></td>
+	<td class=3D"filesize">20395</td>
+	<td class=3D"filedate">04/11/2006 18:16:15 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc20061031=
.tar.gz'>miniupnpc20061031.tar.gz</a></td>
+	<td class=3D"filesize">20396</td>
+	<td class=3D"filedate">04/11/2006 18:16:13 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc20061023=
.tar.gz'>miniupnpc20061023.tar.gz</a></td>
+	<td class=3D"filesize">20109</td>
+	<td class=3D"filedate">04/11/2006 18:16:12 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc20061020=
.tar.gz'>miniupnpc20061020.tar.gz</a></td>
+	<td class=3D"filesize">19739</td>
+	<td class=3D"filedate">04/11/2006 18:16:10 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc20060909=
.tar.gz'>miniupnpc20060909.tar.gz</a></td>
+	<td class=3D"filesize">19285</td>
+	<td class=3D"filedate">04/11/2006 18:16:09 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc20060731=
.tar.gz'>miniupnpc20060731.tar.gz</a></td>
+	<td class=3D"filesize">19032</td>
+	<td class=3D"filedate">04/11/2006 18:16:07 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc20060711=
.tar.gz'>miniupnpc20060711.tar.gz</a></td>
+	<td class=3D"filesize">19151</td>
+	<td class=3D"filedate">04/11/2006 18:16:06 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc20060709=
.tar.gz'>miniupnpc20060709.tar.gz</a></td>
+	<td class=3D"filesize">19080</td>
+	<td class=3D"filedate">04/11/2006 18:16:04 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc20060703=
.tar.gz'>miniupnpc20060703.tar.gz</a></td>
+	<td class=3D"filesize">17906</td>
+	<td class=3D"filedate">04/11/2006 18:16:03 +0000</td>
+	<td class=3D"comment">MiniUPnP client source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpc-new2006=
0630.tar.gz'>miniupnpc-new20060630.tar.gz</a></td>
+	<td class=3D"filesize">14840</td>
+	<td class=3D"filedate">04/11/2006 18:16:01 +0000</td>
+	<td class=3D"comment">Jo&atilde;o Paulo Barraca version of the upnp cli=
ent</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20061029=
.tar.gz'>miniupnpd20061029.tar.gz</a></td>
+	<td class=3D"filesize">24197</td>
+	<td class=3D"filedate">03/11/2006 13:40:30 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20061027=
.tar.gz'>miniupnpd20061027.tar.gz</a></td>
+	<td class=3D"filesize">23904</td>
+	<td class=3D"filedate">03/11/2006 13:40:29 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20061028=
.tar.gz'>miniupnpd20061028.tar.gz</a></td>
+	<td class=3D"filesize">24383</td>
+	<td class=3D"filedate">03/11/2006 13:40:29 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20061018=
.tar.gz'>miniupnpd20061018.tar.gz</a></td>
+	<td class=3D"filesize">23051</td>
+	<td class=3D"filedate">03/11/2006 13:40:28 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20061023=
.tar.gz'>miniupnpd20061023.tar.gz</a></td>
+	<td class=3D"filesize">23478</td>
+	<td class=3D"filedate">03/11/2006 13:40:28 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20060930=
.tar.gz'>miniupnpd20060930.tar.gz</a></td>
+	<td class=3D"filesize">22832</td>
+	<td class=3D"filedate">03/11/2006 13:40:28 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20060924=
.tar.gz'>miniupnpd20060924.tar.gz</a></td>
+	<td class=3D"filesize">22038</td>
+	<td class=3D"filedate">03/11/2006 13:40:27 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20060919=
.tar.gz'>miniupnpd20060919.tar.gz</a></td>
+	<td class=3D"filesize">21566</td>
+	<td class=3D"filedate">03/11/2006 13:40:27 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20060729=
.tar.gz'>miniupnpd20060729.tar.gz</a></td>
+	<td class=3D"filesize">19202</td>
+	<td class=3D"filedate">03/11/2006 13:40:26 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+<tr>
+	<td class=3D"filename"><a href=3D'download.php?file=3Dminiupnpd20060909=
.tar.gz'>miniupnpd20060909.tar.gz</a></td>
+	<td class=3D"filesize">19952</td>
+	<td class=3D"filedate">03/11/2006 13:40:26 +0000</td>
+	<td class=3D"comment">MiniUPnP daemon source code</td>
+	<td></td>
+</tr>
+</table>
+
+<p><a href=3D"..">Home</a></p>
+<p>Contact: miniupnp _AT_ free _DOT_ fr</p>
+<p align=3D"center">
+<a href=3D"https://validator.w3.org/check?uri=3Dreferer"><img src=3D"htt=
ps://www.w3.org/Icons/valid-xhtml10" alt=3D"Valid XHTML 1.0 Transitional"=
 height=3D"31" width=3D"88" /></a>
+<a href=3D"https://jigsaw.w3.org/css-validator/check/referer"><img style=
=3D"border:0;width:88px;height:31px" src=3D"https://jigsaw.w3.org/css-val=
idator/images/vcss" alt=3D"Valid CSS!" /></a>
+<!--
+  <a href=3D"https://freshmeat.net/projects/miniupnp"><img src=3D"https:=
//s3.amazonaws.com/entp-tender-production/assets/bc5be96f147ec8db3c10fc01=
7f1f53889904ef5b/fm_logo_white_150_normal.png" border=3D"0" alt=3D"freshm=
eat.net" /></a>
+-->
+<!-- https://futuresimple.github.com/images/github_logo.png -->
+<!-- <a href=3D"https://github.com/miniupnp/miniupnp"><img src=3D"https:=
//assets-cdn.github.com/images/modules/logos_page/GitHub-Logo.png" alt=3D=
"github.com" height=3D"31" /></a> -->
+<a href=3D"https://github.com/miniupnp/miniupnp"><img style=3D"position:=
 absolute; top: 0; left: 0; border: 0;" src=3D"https://github.blog/wp-con=
tent/uploads/2008/12/forkme_left_green_007200.png" alt=3D"Fork me on GitH=
ub" /></a>
+</p>
+
+<script type=3D"text/javascript">
+var gaJsHost =3D (("https:" =3D=3D document.location.protocol) ? "https:=
//ssl." : "http://www.");
+document.write(unescape("%3Cscript src=3D'" + gaJsHost + "google-analyti=
cs.com/ga.js' type=3D'text/javascript'%3E%3C/script%3E"));
+</script>
+<script type=3D"text/javascript">
+try {
+  var ua =3D 'UA-10295521';
+  if(window.location.hostname =3D=3D 'miniupnp.free.fr')
+    ua +=3D '-1';
+  else if(window.location.hostname =3D=3D 'miniupnp.tuxfamily.org')
+    ua +=3D '-2';
+  else ua =3D '';
+  if(ua !=3D '') {
+    var pageTracker =3D _gat._getTracker(ua);
+    pageTracker._trackPageview();
+  }
+} catch(err) {}</script>
+</body>
+</html>
+
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.p=
y
index 7f4951fa83b..9a2d1792507 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -1524,6 +1524,12 @@ class FetchLatestVersionTest(FetcherTest):
         # http://ftp.debian.org/debian/pool/main/m/minicom/minicom_2.7.1=
.orig.tar.gz
         WgetTestData("minicom", "/debian/pool/main/m/minicom/minicom_2.7=
.1.orig.tar.gz")
             : "2.8",
+
+        #
+        # packages where the path doesn't actually contain the filename,=
 so downloadfilename should be respected
+        #
+        WgetTestData("miniupnpd", "/software/miniupnp/download.php?file=3D=
miniupnpd_2.1.20191006.tar.gz;downloadfilename=3Dminiupnpd_2.1.20191006.t=
ar.gz", pv=3D"2.1.20191006", check_uri=3D"/software/miniupnp/download.php=
", check_regex=3Dr"miniupnpd-(?P<pver>\d+(\.\d+)+)\.tar")
+            : "2.3.7",
     }
=20
     test_crate_uris =3D {
--=20
2.43.0


