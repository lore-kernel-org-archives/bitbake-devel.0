Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C1E9F612E5
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 14 Feb 2016 11:05:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1EB5PZl016052; Sun, 14 Feb 2016 11:05:25 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id JcxhPxDRNuCx; Sun, 14 Feb 2016 11:05:25 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1EB5Kw4016048
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 14 Feb 2016 11:05:21 GMT
Message-ID: <1455447920.16142.389.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Shuang Liu <shuangistan@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Sun, 14 Feb 2016 11:05:20 +0000
In-Reply-To: <CAAneanS4Ny=zQs=5jQYuS0GWf7mvFOR6tcS3rt9RUPUW3f2L-w@mail.gmail.com>
References: <CAAneanS4Ny=zQs=5jQYuS0GWf7mvFOR6tcS3rt9RUPUW3f2L-w@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: sliu@de.adit-jv.com
Subject: Re: Bitbake override style removal with variable expansion
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
X-List-Received-Date: Sun, 14 Feb 2016 11:05:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2016-02-10 at 14:33 +0100, Shuang Liu wrote:
> I face a problem that I tried to use the bitbake override style
> removal with variable expansion.
> 
> I have a foo.bb and set FOO_PACKAGES = "${PN}_dummy"
> And I use a foo.bbappend to remove it by FOO_PACKAGES_remove =
> "${PN}_dummy"
> This doesn't work.
> 
> However, FOO_PACKAGES_remove = "foo_dummy" works fine.
> 
> Furthermore I tried other variable names besides PN, e.g.
> FOO_PACKAGES = "foo_dummy"
> FOONAME = "foo"
> FOO_PACKAGES_remove = "${FOONAME}_dummy"
> This doesn't works either.
> 
> So maybe there is some issue with variable expansion in the override
> style removal?
> 
> I use bitbake 1.22 and am sorry I cannot test the master branch on my
> working environment.
> BitBake Build Tool Core version 1.22.0, bitbake version 1.22.0
> 
> Does somebody have some idea about thie behavior?
> 
> I am a bitbake rookie and please forgive me if the question is not
> reasonable.

This was answered on stackoverflow:

http://stackoverflow.com/questions/35336111/bitbake-override-style-removal-with-variable-expansion

Cheers,

Richard

