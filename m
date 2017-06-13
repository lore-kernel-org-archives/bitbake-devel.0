Return-Path: <juro.bystricky@intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 28275782FC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Jun 2017 16:05:15 +0000 (UTC)
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by orsmga105.jf.intel.com with ESMTP; 13 Jun 2017 09:05:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,338,1493708400"; 
	d="scan'208,217";a="112663014"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
	by orsmga005.jf.intel.com with ESMTP; 13 Jun 2017 09:05:14 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
	ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server
	(TLS) id 14.3.319.2; Tue, 13 Jun 2017 09:03:10 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.182]) by
	ORSMSX116.amr.corp.intel.com ([10.22.240.14]) with mapi id
	14.03.0319.002; Tue, 13 Jun 2017 09:03:08 -0700
From: "Bystricky, Juro" <juro.bystricky@intel.com>
To: Christopher Larson <kergoth@gmail.com>
Thread-Topic: [bitbake-devel] [PATCH 1/1] bitbake:process: flush
	stderr/stdout to log
Thread-Index: AQHS458F8jtoF2AQbEuLsw0Wvdb4ZKIjZn0A//+OOGU=
Date: Tue, 13 Jun 2017 16:03:08 +0000
Message-ID: <6E51916E4A1F32428260031F4C7CD2B61198B526@ORSMSX112.amr.corp.intel.com>
References: <1497287524-5406-1-git-send-email-juro.bystricky@intel.com>
	<1497287524-5406-2-git-send-email-juro.bystricky@intel.com>,
	<CABcZANnXvtwQB499_GZGb1R7TEPiezuHhQLdb+Yfyn+od4eehA@mail.gmail.com>
In-Reply-To: <CABcZANnXvtwQB499_GZGb1R7TEPiezuHhQLdb+Yfyn+od4eehA@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.9.46]
MIME-Version: 1.0
Cc: "Purdie, Richard" <richard.purdie@intel.com>,
	Juro Bystricky <jurobystricky@hotmail.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	"paul.eggleton@linux.intel.com" <paul.eggleton@linux.intel.com>
Subject: Re: [PATCH 1/1] bitbake:process: flush stderr/stdout to log
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
X-List-Received-Date: Tue, 13 Jun 2017 16:05:16 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_6E51916E4A1F32428260031F4C7CD2B61198B526ORSMSX112amrcor_"

--_000_6E51916E4A1F32428260031F4C7CD2B61198B526ORSMSX112amrcor_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Thanks, good catch. There are various log flushes already there, so the "fi=
nal" flush
not being executed went undetected in testing, may not even be needed any m=
ore.
I am surprised I did not get any python warnings though.

________________________________
From: Christopher Larson [kergoth@gmail.com]
Sent: Tuesday, June 13, 2017 8:46 AM
To: Bystricky, Juro
Cc: bitbake-devel@lists.openembedded.org; Purdie, Richard; Juro Bystricky; =
paul.eggleton@linux.intel.com
Subject: Re: [bitbake-devel] [PATCH 1/1] bitbake:process: flush stderr/stdo=
ut to log


On Mon, Jun 12, 2017 at 10:12 AM, Juro Bystricky <juro.bystricky@intel.com<=
mailto:juro.bystricky@intel.com>> wrote:
-    finally:
-        log.flush()
-
-    readextras([fobj for fobj, _ in extrafiles])
+            read_all_pipes(log, rin, outdata, errdata)
+
+        # Pocess closed, drain all pipes...
+        read_all_pipes(log, rin, outdata, errdata)
+    finally:
+        log.flush

You forgot a (), so you aren=92t actually running flush here.
--
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--_000_6E51916E4A1F32428260031F4C7CD2B61198B526ORSMSX112amrcor_
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
10pt;">Thanks, good catch. There are various log flushes already there, so =
the &quot;final&quot; flush
<br>
not being executed went undetected in testing, may not even be needed any m=
ore. <br>
I am surprised I did not get any python warnings though.<br>
<br>
<div style=3D"font-family: Times New Roman; color: #000000; font-size: 16px=
">
<hr tabindex=3D"-1">
<div id=3D"divRpF706133" style=3D"direction: ltr;"><font size=3D"2" color=
=3D"#000000" face=3D"Tahoma"><b>From:</b> Christopher Larson [kergoth@gmail=
.com]<br>
<b>Sent:</b> Tuesday, June 13, 2017 8:46 AM<br>
<b>To:</b> Bystricky, Juro<br>
<b>Cc:</b> bitbake-devel@lists.openembedded.org; Purdie, Richard; Juro Byst=
ricky; paul.eggleton@linux.intel.com<br>
<b>Subject:</b> Re: [bitbake-devel] [PATCH 1/1] bitbake:process: flush stde=
rr/stdout to log<br>
</font><br>
</div>
<div></div>
<div>
<div dir=3D"ltr">
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">On Mon, Jun 12, 2017 at 10:12 AM, Juro Bystricky=
 <span dir=3D"ltr">
&lt;<a href=3D"mailto:juro.bystricky@intel.com" target=3D"_blank">juro.byst=
ricky@intel.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex; border-left:1=
px #ccc solid; padding-left:1ex">
<div id=3D":25s" class=3D"a3s aXjCH m15c9d4ad91752e18">-&nbsp; &nbsp; final=
ly:<br>
-&nbsp; &nbsp; &nbsp; &nbsp; log.flush()<br>
-<br>
-&nbsp; &nbsp; readextras([fobj for fobj, _ in extrafiles])<br>
&#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; read_all_pipes(log, rin, out=
data, errdata)<br>
&#43;<br>
&#43;&nbsp; &nbsp; &nbsp; &nbsp; # Pocess closed, drain all pipes...<br>
&#43;&nbsp; &nbsp; &nbsp; &nbsp; read_all_pipes(log, rin, outdata, errdata)=
<br>
&#43;&nbsp; &nbsp; finally:<br>
&#43;&nbsp; &nbsp; &nbsp; &nbsp; log.flush</div>
</blockquote>
</div>
<br>
You forgot a (), so you aren=92t actually running flush here.<br>
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

--_000_6E51916E4A1F32428260031F4C7CD2B61198B526ORSMSX112amrcor_--
