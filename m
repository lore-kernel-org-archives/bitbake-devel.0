Return-Path: <Ivan.Slaev@harman.com>
X-Greylist: delayed 874 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 17 Aug 2018 12:10:30 UTC
Received: from mail1.bemta24.messagelabs.com (mail1.bemta24.messagelabs.com
	[67.219.250.211])
	by mail.openembedded.org (Postfix) with ESMTP id 44E4D792BD
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Aug 2018 12:10:30 +0000 (UTC)
Received: from [67.219.251.50] (using TLSv1.2 with cipher
	DHE-RSA-AES256-GCM-SHA384 (256 bits))
	by server-4.bemta.az-c.us-west-2.aws.symcld.net id 82/2F-19356-CC7B67B5;
	Fri, 17 Aug 2018 11:55:56 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRWlGSWpSXmKPExsVyqPAOq+6Z7WX
	RBh8WCllcPxrqwOhxbuMKxgDGKNbMvKT8igTWjA+/DzMVbJWoOPjqL3MD4zXRLkYuDiGBLYwS
	7z5MYIZzbm39ygrhHGSUOHTsFJDDycEmoC1x4/9eZhBbRCBI4tPHFpYuRg4OYQF5ifln1CHCK
	hJ7j71nhLD1JBa93MwOYrMIqErs6ZrABGLzCrhLnDp3E2wko4CsxJfG1WAjmQXEJW49mQ9WIy
	EgILFkz3lmCFtU4uXjf6wQtoHE1qX7WCBsOYldjX+ZIHpzJHbvuMoKMV9Q4uTMJ2A1QgJKEs+
	Of2eZwCg8C8mKWUhaZiFpgYjrSCzY/YkNwtaWWLbwNTOMfebAYyZk8QWM7KsYLZKKMtMzSnIT
	M3N0DQ0MdA0NjXQNjS10jQyN9BKrdJP1Sot1y1OLS3SB3PJiveLK3OScFL281JJNjMA4YwCCH
	Yx/D6UcYpTkYFIS5Z2xqSxaiC8pP6UyI7E4I76oNCe1+BCjDAeHkgRvyTagnGBRanpqRVpmDj
	DiYdISHDxKIrzXQNK8xQWJucWZ6RCpU4z2HLeaeyYxcxy5NwVIXgCTf95PncQsxJKXn5cqJc5
	rD9ImANKWUZoHNxSWoC4xykoJ8zICnSnEU5BalJtZgir/ilGcg1FJmHcnyBSezLwSuN2vgM5i
	AjprmkApyFkliQgpqQbGzHna0c0zYwMzY1nyzt3z2lJ/dVFhuetSH8U/i0JOc9qmxfKv++Qxh
	8dxikGa7MzwFhYf88MaFv1R7oV1v0yfnVLX3BTFfGHiB/ZypwcvUvYfUfutIJ2550Gp17nQ4v
	C58/w3sS++V/ZJusywe4a3bHhWyMqVjI1bPt9K79jt+yuNf9MDe1YlluKMREMt5qLiRABJwo9
	4SwMAAA==
X-Env-Sender: Ivan.Slaev@harman.com
X-Msg-Ref: server-4.tower-362.messagelabs.com!1534506954!2856078!1
X-Originating-IP: [194.113.220.5]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20578 invoked from network); 17 Aug 2018 11:55:56 -0000
Received: from unknown (HELO HIMDWSMB09.ad.harman.com) (194.113.220.5)
	by server-4.tower-362.messagelabs.com with DHE-RSA-AES256-GCM-SHA384
	encrypted SMTP; 17 Aug 2018 11:55:56 -0000
Received: from HIMDWSMB06.ad.harman.com (10.70.50.116) by
	HIMDWSMB09.ad.harman.com (10.70.50.214) with Microsoft SMTP Server
	(TLS) id 15.0.1365.1; Fri, 17 Aug 2018 13:55:54 +0200
Received: from HIMDWSMB03.ad.harman.com (10.70.50.113) by
	HIMDWSMB06.ad.harman.com (10.70.50.116) with Microsoft SMTP Server
	(TLS) id 15.0.1365.1; Fri, 17 Aug 2018 13:55:53 +0200
Received: from HIMDWSMB03.ad.harman.com ([fe80::c43f:193b:3eb8:8df7]) by
	HIMDWSMB03.ad.harman.com ([fe80::c43f:193b:3eb8:8df7%16]) with mapi id
	15.00.1365.000; Fri, 17 Aug 2018 13:55:52 +0200
From: "Slaev, Ivan" <Ivan.Slaev@harman.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: mistake in chapter 2.1
Thread-Index: AQHUNiE+/ifiJzvXMkatwkDiIWiKSQ==
Date: Fri, 17 Aug 2018 11:55:51 +0000
Message-ID: <be55ff135cbc4483ab4483660d5a0870@HIMDWSMB03.ad.harman.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.70.54.4]
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 20 Aug 2018 08:14:19 +0000
Subject: mistake in chapter 2.1
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
X-List-Received-Date: Fri, 17 Aug 2018 12:10:31 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_be55ff135cbc4483ab4483660d5a0870HIMDWSMB03adharmancom_"

--_000_be55ff135cbc4483ab4483660d5a0870HIMDWSMB03adharmancom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear bitbake-devel (community) :),

While I was reading the 2.1 chapter of bitbake manual, I thing I found a mi=
stake in:

The layer.conf files are used to construct key variables such as BBPATH<htt=
ps://www.yoctoproject.org/docs/2.4/bitbake-user-manual/bitbake-user-manual.=
html#var-BBPATH> and BBFILES<https://www.yoctoproject.org/docs/2.4/bitbake-=
user-manual/bitbake-user-manual.html#var-BBFILES>. BBPATH is used to search=
 for configuration and class files under the conf and classes directories, =
respectively. BBFILES is used to locate both recipe and recipe append files=
 (.bb and .bbappend). If there is no bblayers.conf file, it is assumed the =
user has set the BBPATH and BBFILES directly in the environment.

In my opinion the last sentence should be: If there is no layer.conf file, =
it is assumed the user has set the BBPATH and BBFILES directly in the envir=
onment.

Please check my statement as I could be wrong about it.

Kind regards!

Ivan Slaev

--_000_be55ff135cbc4483ab4483660d5a0870HIMDWSMB03adharmancom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body text=3D"#000000" bgcolor=3D"#FFFFFF">
<p>Dear bitbake-devel (community) :),</p>
<p>While I was reading the 2.1 chapter of bitbake manual, I thing I found a=
 mistake in:</p>
<p>The <code class=3D"filename">layer.conf</code> files are used to constru=
ct key variables such as
<a class=3D"link" href=3D"https://www.yoctoproject.org/docs/2.4/bitbake-use=
r-manual/bitbake-user-manual.html#var-BBPATH" title=3D"BBPATH">
<code class=3D"filename">BBPATH</code></a> and <a class=3D"link" href=3D"ht=
tps://www.yoctoproject.org/docs/2.4/bitbake-user-manual/bitbake-user-manual=
.html#var-BBFILES" title=3D"BBFILES">
<code class=3D"filename">BBFILES</code></a>. <code class=3D"filename">BBPAT=
H</code> is used to search for configuration and class files under the
<code class=3D"filename">conf</code> and <code class=3D"filename">classes</=
code> directories, respectively.
<code class=3D"filename">BBFILES</code> is used to locate both recipe and r=
ecipe append files (<code class=3D"filename">.bb</code> and
<code class=3D"filename">.bbappend</code>). If there is no <code class=3D"f=
ilename">bblayers.conf</code> file, it is assumed the user has set the
<code class=3D"filename">BBPATH</code> and <code class=3D"filename">BBFILES=
</code> directly in the environment.
<br>
</p>
<p>In my opinion the last sentence should be: If there is no <code class=3D=
"filename">
layer.conf</code> file, it is assumed the user has set the <code class=3D"f=
ilename">
BBPATH</code> and <code class=3D"filename">BBFILES</code> directly in the e=
nvironment.
<br>
</p>
<p>Please check my statement as I could be wrong about it.</p>
<p>Kind regards!</p>
<p>Ivan Slaev<br>
</p>
</body>
</html>

--_000_be55ff135cbc4483ab4483660d5a0870HIMDWSMB03adharmancom_--
