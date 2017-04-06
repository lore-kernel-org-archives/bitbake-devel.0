Return-Path: <juro.bystricky@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 39CF677CD8
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Apr 2017 15:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1491491724; x=1523027724;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:mime-version;
	bh=jjtLNX0Y/io5FHK8QHQHn0tmRNV/dEI4yxEfsRjzC9w=;
	b=gsbjBJJDFgHv1S5ejkHYW7s7sYICs4xKwjABdTfxZm3OS884hwtEM8bu
	KM1XPKrMXJ59COMZYFLknfjOwrB4Mg==;
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 Apr 2017 08:15:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,160,1488873600"; 
	d="scan'208,217";a="1152146832"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
	by fmsmga002.fm.intel.com with ESMTP; 06 Apr 2017 08:15:22 -0700
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
	ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server
	(TLS) id 14.3.319.2; Thu, 6 Apr 2017 08:15:22 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.213]) by
	ORSMSX115.amr.corp.intel.com ([169.254.4.44]) with mapi id
	14.03.0319.002; Thu, 6 Apr 2017 08:15:22 -0700
From: "Bystricky, Juro" <juro.bystricky@intel.com>
To: Christopher Larson <kergoth@gmail.com>
Thread-Topic: [bitbake-devel] [PATCH] tinfoil.py: validate argument in
	parse_recipe_file
Thread-Index: AQHSrlQ8sQWE4iDZwkqKx4PaUctq8KG4A/OAgABjAcY=
Date: Thu, 6 Apr 2017 15:15:21 +0000
Message-ID: <6E51916E4A1F32428260031F4C7CD2B61193F7F1@ORSMSX112.amr.corp.intel.com>
References: <1491427991-8595-1-git-send-email-juro.bystricky@intel.com>,
	<CABcZAN=6rGsbmXsQaDdpRspNwJBv5p5zD_DqJkJxBMs42j0K+Q@mail.gmail.com>
In-Reply-To: <CABcZAN=6rGsbmXsQaDdpRspNwJBv5p5zD_DqJkJxBMs42j0K+Q@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.9.41]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] tinfoil.py: validate argument in parse_recipe_file
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
X-List-Received-Date: Thu, 06 Apr 2017 15:15:22 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_6E51916E4A1F32428260031F4C7CD2B61193F7F1ORSMSX112amrcor_"

--_000_6E51916E4A1F32428260031F4C7CD2B61193F7F1ORSMSX112amrcor_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

parse_recipe can be called from parse_recipe_file as well. If parse_recipe_=
file is called with a non-existing recipe, you end up with the exception as=
 well. IMHO for a  non-existent recipe parse_recipe should return None (ins=
tead of an exception)


________________________________
From: Christopher Larson [kergoth@gmail.com]
Sent: Wednesday, April 05, 2017 6:32 PM
To: Bystricky, Juro
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] tinfoil.py: validate argument in parse=
_recipe_file


On Wed, Apr 5, 2017 at 2:33 PM, Juro Bystricky <juro.bystricky@intel.com<ma=
ilto:juro.bystricky@intel.com>> wrote:
Check for an empty file name to avoid an exception.

[YOCTO#11210]

Signed-off-by: Juro Bystricky <juro.bystricky@intel.com<mailto:juro.bystric=
ky@intel.com>>

IMO this is pointless. If you=92re calling parse_recipe_file with an empty =
string, it=92s programmer error, which means raising an exception is a comp=
letely reasonable thing to do.
--
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--_000_6E51916E4A1F32428260031F4C7CD2B61193F7F1ORSMSX112amrcor_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" id=3D"owaParaStyle">P {margin-top:0;margin-bottom:=
0;}</style>
</head>
<body fpstyle=3D"1" ocsi=3D"0">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">parse_recipe can be called from parse_recipe_file as well. If parse_=
recipe_file is called with a non-existing recipe, you end up with the excep=
tion as well. IMHO for a&nbsp; non-existent
 recipe parse_recipe should return None (instead of an exception)<br>
<br>
<br>
<div style=3D"font-family: Times New Roman; color: #000000; font-size: 16px=
">
<hr tabindex=3D"-1">
<div id=3D"divRpF863652" style=3D"direction: ltr;"><font size=3D"2" face=3D=
"Tahoma" color=3D"#000000"><b>From:</b> Christopher Larson [kergoth@gmail.c=
om]<br>
<b>Sent:</b> Wednesday, April 05, 2017 6:32 PM<br>
<b>To:</b> Bystricky, Juro<br>
<b>Cc:</b> bitbake-devel@lists.openembedded.org<br>
<b>Subject:</b> Re: [bitbake-devel] [PATCH] tinfoil.py: validate argument i=
n parse_recipe_file<br>
</font><br>
</div>
<div></div>
<div>
<div dir=3D"ltr">
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">On Wed, Apr 5, 2017 at 2:33 PM, Juro Bystricky <=
span dir=3D"ltr">
&lt;<a href=3D"mailto:juro.bystricky@intel.com" target=3D"_blank">juro.byst=
ricky@intel.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex; border-left:1=
px #ccc solid; padding-left:1ex">
<div id=3D":o4" class=3D"a3s aXjCH m15b400977f39b78d">Check for an empty fi=
le name to avoid an exception.<br>
<br>
[YOCTO#11210]<br>
<br>
Signed-off-by: Juro Bystricky &lt;<a href=3D"mailto:juro.bystricky@intel.co=
m" target=3D"_blank">juro.bystricky@intel.com</a>&gt;</div>
</blockquote>
</div>
<div class=3D"gmail_extra"><br>
</div>
IMO this is pointless. If you=92re calling parse_recipe_file with an empty =
string, it=92s programmer error, which means raising an exception is a comp=
letely reasonable thing to do.<br>
-- <br>
<div class=3D"gmail_signature">
<div dir=3D"ltr">
<div>
<div dir=3D"ltr">Christopher Larson<br>
kergoth at gmail dot com<br>
Founder - BitBake, OpenEmbedded, OpenZaurus<br>
Senior Software Engineer, Mentor Graphics</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_6E51916E4A1F32428260031F4C7CD2B61193F7F1ORSMSX112amrcor_--
