Return-Path: <kondrashkin.ilya@gmail.com>
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
	[209.85.167.51])
	by mail.openembedded.org (Postfix) with ESMTP id 51DAC6C134
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Nov 2018 14:53:19 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id n18so14323697lfh.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Nov 2018 06:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=message-id:mime-version:to:from:subject:date:importance;
	bh=T3MWkOG6TI8XMystcNLmV+wE3/FCDV35AGOfqIkkS2g=;
	b=AH3f2wUaxei1sbMCkikvdaNNS0u405XIKkg4Le65mginO8sLxdVFY6dUPB0nv6TaxK
	LH73XFLNn+yj3Wk08jkTuaWu0MqOK6rpBY4c9ZkjXyYFrKRMKI8uj/HuhBxVRzCIW1C4
	HxrkFlGzwioiwI2AxPTQ69GSgoscwOZJuevmBMdbb1x1rBshb3DWM8VWvD3qRpmypjUv
	gLTUqOnLN+czV3Mu4K8fC+HgPHNNrq+BGTd5qpH0hZCoQphYCZ0Af7NxSe+laB4e0/bz
	FL07bZsQDX4hBsAJJmlKRvGq3SIaIEMHvNRCKm3eD1HAWu9qRSauofO87gBMeY0DzEbs
	Ad+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:mime-version:to:from:subject:date
	:importance;
	bh=T3MWkOG6TI8XMystcNLmV+wE3/FCDV35AGOfqIkkS2g=;
	b=ckjjOYCglsUg4AjL5SEbUEbjxhEPCx9ngN7qoihs9ewwHsz/OxFb0eSWxV2KfVft+/
	jIIKAqahoHuLNgdY2x8ufm8Rhd3+e4KcZXhmOlqW/yhfes7SAmEyKhFkNxzgJR8Y40z9
	BCMT7KThPhVlkkJrJUDgLNQLql8kWdIetiOA0E6E6WekWaJ39FiWtpAT2Ev96JVBZMPr
	4W/WhG8rEzP8cCnofQKyge5ReML0Iq5wJ6/ISHbO1Zt49KgyNZWlgVQK/c/5BpUkVenL
	a7ap+bIghbsCZfODvSpHmoqjABMgLto8B5RN+w3O0JyBnk0rBVsZUWaHaMZR3cthwwK3
	tBFg==
X-Gm-Message-State: AGRZ1gLuqfOXwNzVnvOZBlbSpV0vMPy6pQ2SbfbbCIbw5rA/IcCBzHG1
	5N3EHYFb431Kfw40Cd4DMzKIMrNc
X-Google-Smtp-Source: AJdET5cYz9h6ALAZclgsQ5XXEDGD6H1RObyZ5/+l1iaGo4cl6dNVl4d6G0hhPnbB9eAcb5/zAj7l1Q==
X-Received: by 2002:a19:d5:: with SMTP id 204mr3370485lfa.116.1542293599427;
	Thu, 15 Nov 2018 06:53:19 -0800 (PST)
Received: from ?IPv6:::ffff:192.168.10.224? ([89.189.10.182])
	by smtp.gmail.com with ESMTPSA id
	4-v6sm4107674ljw.84.2018.11.15.06.53.17
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 15 Nov 2018 06:53:18 -0800 (PST)
Message-ID: <5bed885e.1c69fb81.2f7c6.980e@mx.google.com>
MIME-Version: 1.0
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
From: Ilya Kondrashkin <kondrashkin.ilya@gmail.com>
Date: Thu, 15 Nov 2018 17:53:18 +0300
Importance: normal
X-Priority: 3
Subject: LAYERSERIES_CORENAMES empty
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
X-List-Received-Date: Thu, 15 Nov 2018 14:53:19 -0000
Content-Type: multipart/alternative;
	boundary="_57697E6A-445E-4814-95C2-853F323DFDB3_"

--_57697E6A-445E-4814-95C2-853F323DFDB3_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi folks,

Currently I=E2=80=99m experiencing issue with LAYERSERIES_COMPAT variable.
I have =E2=80=9Csumo=E2=80=9D revision of poky and layer with LAYERSERIES_C=
OMPAT set to =E2=80=9Crocko sumo=E2=80=9D. Every bitbake call gets failed d=
ue to layer incompatibility.

After adding some debug lines to bitbake/lib/bb/cookerdata.py I found out t=
hat LAYERSERIES_CORENAMES is empty. Checked layer.conf of poky/meta - LAYER=
SERIES_CORENAMES is set to =E2=80=9Ccore=E2=80=9D.

Did you see such issue before? Is there any known solution to escape from t=
his? I cannot find any references over the internet.

Thanks.
Regards,
Ilya.


--_57697E6A-445E-4814-95C2-853F323DFDB3_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta ht=
tp-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8"><meta name=
=3DGenerator content=3D"Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3DRU><div class=3DWordSection1><p class=3DMsoN=
ormal><span lang=3DEN-US>Hi folks,<br><br><o:p></o:p></span></p><p class=3D=
MsoNormal><span lang=3DEN-US>Currently I=E2=80=99m experiencing issue with =
LAYERSERIES_COMPAT variable.<o:p></o:p></span></p><p class=3DMsoNormal><spa=
n lang=3DEN-US>I have =E2=80=9Csumo=E2=80=9D revision of poky and layer wit=
h LAYERSERIES_COMPAT set to =E2=80=9Crocko sumo=E2=80=9D. Every bitbake cal=
l gets failed due to layer incompatibility.</span></p><p class=3DMsoNormal>=
<o:p>&nbsp;</o:p></p><p class=3DMsoNormal><span lang=3DEN-US>After adding s=
ome debug lines to bitbake/lib/bb/cookerdata.py I found out that LAYERSERIE=
S_CORENAMES is empty. Checked layer.conf of poky/meta - LAYERSERIES_CORENAM=
ES is set to =E2=80=9Ccore=E2=80=9D.<o:p></o:p></span></p><p class=3DMsoNor=
mal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><span lang=3DEN-US>Did you se=
e such issue before? Is there any known solution to escape from this? I can=
not find any references over the internet.</span></p><p class=3DMsoNormal><=
o:p>&nbsp;</o:p></p><p class=3DMsoNormal><span lang=3DEN-US>Thanks.</span><=
/p><p class=3DMsoNormal>Regards,<br>Ilya.</p><p class=3DMsoNormal><o:p>&nbs=
p;</o:p></p></div></body></html>=

--_57697E6A-445E-4814-95C2-853F323DFDB3_--
