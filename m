Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1SwOPT-0001GD-IF
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Aug 2012 04:11:39 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q711xvmk014901
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 31 Jul 2012 18:59:58 -0700 (PDT)
Received: from [128.224.162.164] (128.224.162.164) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.2.309.2;
	Tue, 31 Jul 2012 18:59:57 -0700
Message-ID: <50188DA3.4040606@windriver.com>
Date: Wed, 1 Aug 2012 10:00:03 +0800
From: Kang Kai <Kai.Kang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: Kang Kai <kai.kang@windriver.com>
References: <cover.1343378110.git.kai.kang@windriver.com>
In-Reply-To: <cover.1343378110.git.kai.kang@windriver.com>
X-Originating-IP: [128.224.162.164]
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.windriver.com id
	q711xvmk014901
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 0/2] V3: hob check disk size
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
X-List-Received-Date: Wed, 01 Aug 2012 02:11:40 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2012=E5=B9=B407=E6=9C=8827=E6=97=A5 16:38, Kang Kai wrote:
> Hi Richard,
>
> In V3 I fire the event DiskFull in diskMonitor.check() as your commente=
d.

Hi Richard,

Would you like to help me to review these patches?
Thanks,

Kai

> Thanks,
> Kai
>
> The following changes since commit 0ffb02eec2beaea27ff0ec9d3d31b0a09e67=
5a4c:
>
>    documentation: Updated the h6 style to use a larger font (2012-07-24=
 10:35:34 +0100)
>
> are available in the git repository at:
>    git://git.pokylinux.org/poky-contrib kangkai/hob-check-size
>    http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=3Dkangkai/hob-=
check-size
>
> Kang Kai (2):
>    monitordisk: fire event DISKFULL when terminate build
>    hob: deal event DiskFull
>
>   bitbake/lib/bb/event.py                  |    8 ++++++++
>   bitbake/lib/bb/monitordisk.py            |    5 +++++
>   bitbake/lib/bb/ui/crumbs/builder.py      |    4 ++++
>   bitbake/lib/bb/ui/crumbs/runningbuild.py |   11 ++++++++++-
>   4 files changed, 27 insertions(+), 1 deletions(-)
>



