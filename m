Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1T9oW3-000317-97
	for bitbake-devel@lists.openembedded.org;
	Fri, 07 Sep 2012 04:41:55 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q872TRLZ021711
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 6 Sep 2012 19:29:27 -0700 (PDT)
Received: from [128.224.162.164] (128.224.162.164) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.2.309.2;
	Thu, 6 Sep 2012 19:29:27 -0700
Message-ID: <50495C16.1070102@windriver.com>
Date: Fri, 7 Sep 2012 10:29:42 +0800
From: Kang Kai <Kai.Kang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: Kang Kai <kai.kang@windriver.com>
References: <cover.1346121294.git.kai.kang@windriver.com>
In-Reply-To: <cover.1346121294.git.kai.kang@windriver.com>
X-Originating-IP: [128.224.162.164]
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.windriver.com id
	q872TRLZ021711
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 0/3 V2] hob2: remove hard-coded image types map
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
X-List-Received-Date: Fri, 07 Sep 2012 02:41:55 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2012=E5=B9=B408=E6=9C=8828=E6=97=A5 10:47, Kang Kai wrote:
> Hi Richard,
>
> This is V2 for Yocto 2795.
>
> Just add variable IMAGE_EXTENSION_live as you suggest, other image type=
s are the same with the real image name extension names.
>
> Add update the hob code accordingly.
Hi Richard,

Would you like to review these patches please?

Thanks,
Kai

>
> Regards,
> Kai
>
> The following changes since commit b4c5725af4cd85d5644f0373e2674e903c4e=
ab2b:
>
>    yocto-bsp: add missing xserver-xf86-config .bbappend for qemu (2012-=
08-25 14:47:07 +0100)
>
> are available in the git repository at:
>    git://git.pokylinux.org/poky-contrib kangkai/hob2
>    http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=3Dkangkai/hob2
>
> Kang Kai (3):
>    hob2: remove the hard-coded images map
>    hob2: remove class hcc
>    image_types.bbclass: add variable for Hob
>
>   bitbake/lib/bb/ui/crumbs/builder.py         |   24 ++++++++++++++++++=
---
>   bitbake/lib/bb/ui/crumbs/hig.py             |   11 +++++++--
>   bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    1 -
>   bitbake/lib/bb/ui/crumbs/hobwidget.py       |   29 ------------------=
---------
>   meta/classes/image_types.bbclass            |    3 ++
>   5 files changed, 31 insertions(+), 37 deletions(-)
>



