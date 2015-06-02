Return-Path: <ashcharles@gmail.com>
Received: from mail-ig0-f169.google.com (mail-ig0-f169.google.com
	[209.85.213.169])
	by mail.openembedded.org (Postfix) with ESMTP id F292975685;
	Tue,  2 Jun 2015 00:09:14 +0000 (UTC)
Received: by igbpi8 with SMTP id pi8so74238546igb.0;
	Mon, 01 Jun 2015 17:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type:content-transfer-encoding;
	bh=EZzIwNiNdGp5vFt61qRbV4vepKki6JGUwSP07OO074k=;
	b=Yd/gUHbTd9jD/QVBtU9IIX84yulpK6PGF16JbtmSEyHrAGzxso8lpGyrkMiMFAawmJ
	qO3idSBzQwzM7lO26cF9nmCVssrEMPe2CSbm0+9ts8kdDCGi+wb9kpqMLhqQNHqhbO8z
	5d75C9uecf56nJqCaKvPedKqAknaXEQ6k9SjdU3oJw5+V4SD53NPIaY9mTW1XdAXxqK4
	uEOiYowmfZgjpS1aMB4Ubai2UJcWIU5Tpw1KA+6gGSO/ZWbU6TBo7xnMcIGYICsCnDPh
	ztKsmmvN42YFf0cqbIzSS3yqhNze8F63NYK5YO62FQTgdFrT/lJiDZCYKZw6EoXoP9+J
	nL1Q==
X-Received: by 10.42.214.79 with SMTP id gz15mr31094159icb.86.1433203755720;
	Mon, 01 Jun 2015 17:09:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.138.134 with HTTP; Mon, 1 Jun 2015 17:08:45 -0700 (PDT)
In-Reply-To: <CA+chaQe_T9zPjckAm+NZrZpdw5BO81eL-vxrAA-2kYymMRbd1w@mail.gmail.com>
References: <20150427105100.GB2379@jama>
	<1432309170-5575-1-git-send-email-ashcharles@gmail.com>
	<5567C5B1.7010901@windriver.com>
	<CAK8F28mc2C=r4n42xFmNaxNveectuB8esrkt4M2BkSknH-mFxw@mail.gmail.com>
	<CA+chaQe_T9zPjckAm+NZrZpdw5BO81eL-vxrAA-2kYymMRbd1w@mail.gmail.com>
From: Ash Charles <ashcharles@gmail.com>
Date: Mon, 1 Jun 2015 17:08:45 -0700
Message-ID: <CAK8F28=cu6z2m3hNGkO-qkzDhyfuZwPG-Q-n+2rY95NvmwuStg@mail.gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>,
	Robert Yang <liezhi.yang@windriver.com>, danismostlikely@gmail.com
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-devel <openembedded-devel@lists.openembedded.org>
Subject: Re: [oe] [PATCH] fetch/hg: Disable checksums for archived downloads
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
X-List-Received-Date: Tue, 02 Jun 2015 00:09:15 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I verified that the "fetch/hg: support submodules" [1] patch, in
combination with this [2] patch is causing do_unpack failures for me.
Based on the logs from the world build, I suspect this is also
breaking dvb-apps.  I don't have a fix so perhaps the best plan is
reverting [2] now that cleanall for hg packages actually works.

[1] http://lists.openembedded.org/pipermail/bitbake-devel/2015-May/005725.h=
tml
[2] http://lists.openembedded.org/pipermail/bitbake-devel/2015-May/005758.h=
tml

--Ash

On Fri, May 29, 2015 at 2:18 AM, Martin Jansa <martin.jansa@gmail.com> wrot=
e:
> FWIW: I see vim unpack failing now in world builds:
>
> NOTE: recipe vim-7.4.481-r0: task do_unpack: Started
> ERROR: Function failed: Fetcher failure: Fetch command failed with exit c=
ode
> 255, output:
> abort: repository
> /home/jenkins/oe/world/shr-core/downloads/hg/vim.googlecode.com/hg/vim no=
t
> found!
>
> ERROR: Logfile of failure stored in:
> /home/jenkins/oe/world/shr-core/tmp-glibc/work/armv5te-oe-linux-gnueabi/v=
im/7.4.481-r0/temp/log.do_unpack.28505
> Log data follows:
> | DEBUG: Executing python function do_unpack
> | DEBUG: Executing python function base_do_unpack
> | DEBUG: Unpack: creating new hg repository in
> '/home/jenkins/oe/world/shr-core/tmp-glibc/work/armv5te-oe-linux-gnueabi/=
vim/7.4.481-r0/vim'
> | DEBUG: Running export
> PATH=3D"/home/jenkins/oe/world/shr-core/openembedded-core/scripts:/home/j=
enkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/usr/bin/arm-oe-lin=
ux-gnueabi:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/qemuarm/usr/b=
in/crossscripts:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-l=
inux/usr/sbin:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-lin=
ux/usr/bin:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/=
sbin:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/bin:/h=
ome/jenkins/oe/world/shr-core/openembedded-core/scripts:/home/jenkins/oe/wo=
rld/shr-core/bitbake/bin:/home/jenkins/bin:/usr/local/sbin:/usr/local/bin:/=
usr/sbin:/usr/bin:/sbin:/bin:/usr/games";
> export HOME=3D"/home/jenkins"; /usr/bin/env hg init
> /home/jenkins/oe/world/shr-core/tmp-glibc/work/armv5te-oe-linux-gnueabi/v=
im/7.4.481-r0/vim
> | DEBUG: Unpack: updating source in
> '/home/jenkins/oe/world/shr-core/tmp-glibc/work/armv5te-oe-linux-gnueabi/=
vim/7.4.481-r0/vim'
> | DEBUG: Running export
> PATH=3D"/home/jenkins/oe/world/shr-core/openembedded-core/scripts:/home/j=
enkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/usr/bin/arm-oe-lin=
ux-gnueabi:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/qemuarm/usr/b=
in/crossscripts:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-l=
inux/usr/sbin:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-lin=
ux/usr/bin:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/=
sbin:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/bin:/h=
ome/jenkins/oe/world/shr-core/openembedded-core/scripts:/home/jenkins/oe/wo=
rld/shr-core/bitbake/bin:/home/jenkins/bin:/usr/local/sbin:/usr/local/bin:/=
usr/sbin:/usr/bin:/sbin:/bin:/usr/games";
> export HOME=3D"/home/jenkins"; /usr/bin/env hg pull
> /home/jenkins/oe/world/shr-core/downloads/hg/vim.googlecode.com/hg/vim
> | DEBUG: Python function base_do_unpack finished
> | DEBUG: Python function do_unpack finished
> | ERROR: Function failed: Fetcher failure: Fetch command failed with exit
> code 255, output:
> | abort: repository
> /home/jenkins/oe/world/shr-core/downloads/hg/vim.googlecode.com/hg/vim no=
t
> found!
> |
> NOTE: recipe vim-7.4.481-r0: task do_unpack: Failed
> ERROR: Task 5789
> (/home/jenkins/oe/world/shr-core/meta-openembedded/meta-oe/recipes-suppor=
t/vim/vim_7.4.481.bb,
> do_unpack) failed with exit code '1'
>
>
>
> On Fri, May 29, 2015 at 7:46 AM, Ash Charles <ashcharles@gmail.com> wrote=
:
>>
>> > I wonder how did you test the patch, please ? Did you revert the patch=
:
>> >  fetch/hg: support submodules ?
>> Hi Robert,
>> I tested the patch in a Yocto environment which had a prepopulated
>> downloads directory. In particular, I had seen the failure described [1]=
 for
>> vim.
>> My version of bitbake was slightly older so the submodule patch that was
>> breaking the mirroring hadn't yet been applied.
>>
>> [1]
>> https://www.mail-archive.com/openembedded-devel@lists.openembedded.org/m=
sg41328.html
>>
>> --Ash
>>
>>
>> --
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>>
>

