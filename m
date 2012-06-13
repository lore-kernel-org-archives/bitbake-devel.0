Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1SecUV-0006aQ-Vn
	for bitbake-devel@lists.openembedded.org;
	Wed, 13 Jun 2012 03:35:24 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q5D1OgNv026257
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 12 Jun 2012 18:24:44 -0700 (PDT)
Received: from [128.224.162.164] (128.224.162.164) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Tue, 12 Jun 2012 18:24:41 -0700
Message-ID: <4FD7EBF6.8090201@windriver.com>
Date: Wed, 13 Jun 2012 09:25:10 +0800
From: Kang Kai <Kai.Kang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: Darren Hart <dvhart@linux.intel.com>
References: <cover.1338976258.git.kai.kang@windriver.com>
	<1339154065.30460.6.camel@ted> <4FD214C8.8050705@linux.intel.com>
In-Reply-To: <4FD214C8.8050705@linux.intel.com>
X-Originating-IP: [128.224.162.164]
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.windriver.com id
	q5D1OgNv026257
Cc: bitbake-devel@lists.openembedded.org, zhenfeng.zhao@windriver.com
Subject: Re: [PATCH 0/6] V2 hob2: some tweak and add a standalone deploy image tool
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
X-List-Received-Date: Wed, 13 Jun 2012 01:35:24 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2012=E5=B9=B406=E6=9C=8808=E6=97=A5 23:05, Darren Hart wrote:
>
> On 06/08/2012 04:14 AM, Richard Purdie wrote:
>> On Wed, 2012-06-06 at 17:52 +0800, Kang Kai wrote:
>>> Hi Darren,
>>>
>>> Thanks for your detailed reivew.
>>>
>>> V2 update:
>>> 1. break up the commit about hig.py
>>> 2. some text tweak
>>> 3. remove the gtk version check
>>> 4. rename the standalone tool
>>>
>>> V1:
>>> These 2 patches try to add a standalone deploy image tool using curre=
nt codes.
>>> It should be launched by run the absolute path to bitbake/bin/bitbake=
-deployimage,
>>> I'll add a shell script to wrap it under script directory.
>>>
>>> Regards,
>>> Kai
>>> The following changes since commit de4cdfd6bc1280ac7ac0559b87734d2629=
4ef773:
>>>
>>>    documentation/kernel-manual/kernel-how-to.xml: Updated to kernel 3=
.4 (2012-05-31 21:16:55 +0100)
>>>
>>> are available in the git repository at:
>>>    git://git.pokylinux.org/poky-contrib kangkai/distro
>>>    http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=3Dkangkai/di=
stro
>>>
>>> Kang Kai (6):
>>>    ui/crumbs/utils.py: import module bb
>>>    ui/crumbs/hig.py: fix run time error
>>>    ui/crumbs/hig.py: remove extra spaces
>>>    ui/crumbs/hig.py: check deploy process return value
>>>    hob2: update DeployImageDialog for seperated tool
>>>    hob2: create a standalone deploy image tool
>> Merged to master, thanks.

Hi Darren,

> This happened a bit more quickly than I could get to reviewing V2 for
> the inclusion of my feedback.
>
> I've gone ahead and reviewed the patchset again. The breakout looks spo=
t
> on, thanks Kang. There are various other minor issues, mostly with the
> strings. Please have a look and consider submitting a follow-on patch
> series.

Sorry for late response because I had sick leave for last 2 days.
I will send patch to amend the problems according to your comments.

Thanks,
Kai


> Thanks,
>



