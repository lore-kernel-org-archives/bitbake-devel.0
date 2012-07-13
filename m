Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SpaK8-0005bf-Q9
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jul 2012 09:30:01 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q6D7IiCc007600
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 13 Jul 2012 00:18:44 -0700 (PDT)
Received: from [128.224.163.142] (128.224.163.142) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 13 Jul 2012 00:18:44 -0700
Message-ID: <4FFFCBD3.7080809@windriver.com>
Date: Fri, 13 Jul 2012 15:18:43 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:13.0) Gecko/20120615 Thunderbird/13.0.1
MIME-Version: 1.0
To: Girija B <Girija.B@lnties.com>
References: <098684E1B7B2F54491C5DA349D2EF443098FD828@POCITMSEXMB03.LntUniverse.com>
In-Reply-To: <098684E1B7B2F54491C5DA349D2EF443098FD828@POCITMSEXMB03.LntUniverse.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: bitbake error
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
X-List-Received-Date: Fri, 13 Jul 2012 07:30:01 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit



On 07/12/2012 06:53 PM, Girija B wrote:
> Hello,
>
> I have installed bitbake and open embedded environment , when i run the command : bitbake meta-toolchain-qte , am getting the following error :
> Pseudo is not present but is required, building this first before the main build
> ERROR: Failure expanding variable SRCPV, expression was ${@bb.fetch2.get_srcrev(d)} which triggered exception FetchError: Fetcher failure: Fetch command export HOME="/home/girija"; export SSH_AUTH_SOCK="/tmp/keyring-vMpejY/ssh"; export GIT_CONFIG="/home/girija/mft/platform/build/tmp-eglibc/sysroots/i686-linux/etc/gitconfig"; export PATH="/home/girija/mft/platform/build/tmp-eglibc/sysroots/i686-linux/usr/bin/armv5te-oe-linux-gnueabi:/home/girija/mft/platform/build/tmp-eglibc/sysroots/tonga2/usr/bin/crossscripts:/home/girija/mft/platform/build/tmp-eglibc/sysroots/i686-linux/usr/sbin:/home/girija/mft/platform/build/tmp-eglibc/sysroots/i686-linux/usr/bin:/home/girija/mft/platform/build/tmp-eglibc/sysroots/i686-linux/sbin:/home/girija/mft/platform/build/tmp-eglibc/sysroots/i686-linux//bin:/home/girija/mft/platform/3rd-party/bitbake/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/girija/mft/platform/3rd-party/openembedded-core/scripts"; git ls-r!
 em!
>   ote ssh://git@savage-git:10221/var/lib/git/joule/joule-test-app master could not be run:

There is a "git ls-rem!", maybe this is a typo?

// Robert

> None
> ERROR: Command execution failed: Exited with 1
>
> Summary: There were 2 ERROR messages shown, returning a non-zero exit code.
>
>
>
> please help me in solving this
>
> Thanks,
> Girija.B
> Larsen & Toubro Limited
>
> www.larsentoubro.com
>
> This Email may contain confidential or privileged information for the intended recipient (s). If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>
>



