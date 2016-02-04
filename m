Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 08C326FF9B
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Feb 2016 06:33:42 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga104.fm.intel.com with ESMTP; 03 Feb 2016 22:33:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,393,1449561600"; 
	d="scan'208,217";a="876684079"
Received: from tbniels-mobl.ger.corp.intel.com (HELO [10.252.9.212])
	([10.252.9.212])
	by orsmga001.jf.intel.com with ESMTP; 03 Feb 2016 22:33:41 -0800
User-Agent: Microsoft-MacOutlook/0.0.0.151105
Date: Thu, 04 Feb 2016 08:33:40 +0200
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: Christopher Larson <clarson@kergoth.com>
Message-ID: <E8BDB082-1212-49E1-AA03-58D9E4A18182@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH 1/2] data_smart: simple bracket matching
	inside python expressions
References: <1454495619-15453-1-git-send-email-markus.lehtonen@linux.intel.com>
	<1454495619-15453-2-git-send-email-markus.lehtonen@linux.intel.com>
	<CABcZANkJ4Ta=_YuU5yOk55XGH0mBpSD6VCcNiSX9aZY2ixLcpA@mail.gmail.com>
In-Reply-To: <CABcZANkJ4Ta=_YuU5yOk55XGH0mBpSD6VCcNiSX9aZY2ixLcpA@mail.gmail.com>
Mime-version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/2] data_smart: simple bracket matching inside python expressions
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
X-List-Received-Date: Thu, 04 Feb 2016 06:33:46 -0000
Content-type: multipart/alternative;
	boundary="B_3537419622_617436366"

--B_3537419622_617436366
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable

Hi Christopher,

On 03/02/16 17:56, "Christopher Larson" <kergoth@gmail.com on behalf of cla=
rson@kergoth.com> wrote:


On Wed, Feb 3, 2016 at 3:33 AM, Markus Lehtonen <markus.lehtonen@linux.inte=
l.com> wrote:
This expands the python expansion regex by matching curly brackets
inside python expressions. In its simplicity it is limited: e.g. it does
not correctly handle nested curly brackets or open curly brackets (i.e.
'{' without a matching '}') inside python expressions. Making python
parsing inside data_smart fully error-free would require significantly
more work, basically using/implementing python parser to correctly
handle python strings etc.

[YOCTO #8849]

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>

Will this cause problems with regular variable expansion nested inside of i=
nline python, which is allowed? I.e. ${@ ... '${FOO}'}

No, it wont affect that. First of all because the variable expansion is don=
e before python expansion =E2=80=93 ${FOO} would be expanded before the Python reg=
exp is evaluated. Second, the limitation about nested brackets is only about=
 nested brackets inside the python expression (i.e. something like '${FOO${B=
AR}}').

Thanks,
  Markus



--B_3537419622_617436366
Content-type: text/html;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable

<html><head></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; -webkit-line-break: after-white-space; color: rgb(0, 0, 0); font-size:=
 14px; font-family: Calibri, sans-serif;"><div><div>Hi Christopher,</div><di=
v><br></div><div>On 03/02/16 17:56, "Christopher Larson" &lt;<a href=3D"mailto=
:kergoth@gmail.com">kergoth@gmail.com</a> on behalf of <a href=3D"mailto:clars=
on@kergoth.com">clarson@kergoth.com</a>&gt; wrote:</div></div><span id=3D"OLK_=
SRC_BODY_SECTION"><div><br></div><blockquote id=3D"MAC_OUTLOOK_ATTRIBUTION_BLO=
CKQUOTE" style=3D"BORDER-LEFT: #b5c4df 5 solid; PADDING:0 0 0 5; MARGIN:0 0 0 =
5;"><div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On =
Wed, Feb 3, 2016 at 3:33 AM, Markus Lehtonen <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:markus.lehtonen@linux.intel.com" target=3D"_blank">markus.lehtonen@linux.=
intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":175" =
class=3D"a3s" style=3D"overflow:hidden">This expands the python expansion regex =
by matching curly brackets<br>
inside python expressions. In its simplicity it is limited: e.g. it does<br=
>
not correctly handle nested curly brackets or open curly brackets (i.e.<br>=

'{' without a matching '}') inside python expressions. Making python<br>
parsing inside data_smart fully error-free would require significantly<br>
more work, basically using/implementing python parser to correctly<br>
handle python strings etc.<br><br>
[YOCTO #8849]<br><br>
Signed-off-by: Markus Lehtonen &lt;<a href=3D"mailto:markus.lehtonen@linux.in=
tel.com">markus.lehtonen@linux.intel.com</a>&gt;</div></blockquote></div><br=
></div><div class=3D"gmail_extra">Will this cause problems with regular variab=
le expansion nested inside of inline python, which is allowed? I.e. ${@ ... =
'${FOO}'}<br></div></div></blockquote></span><div><br></div><div>No, it wont=
 affect that. First of all because the variable expansion is done before pyt=
hon expansion &#8211; ${FOO} would be expanded before the Python regexp is e=
valuated. Second, the limitation about nested brackets is only about nested =
brackets inside the python expression (i.e. something like '${FOO${BAR}}').<=
/div><div><br></div><div>Thanks,</div><div>&nbsp; Markus</div><div><br></div=
></body></html>

--B_3537419622_617436366--
