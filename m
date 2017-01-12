Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id DD64D65C5B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jan 2017 17:48:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0CHmaQM014027; Thu, 12 Jan 2017 17:48:36 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id CDvAHmhBlwWG; Thu, 12 Jan 2017 17:48:36 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0CHmW8k014012
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 Jan 2017 17:48:33 GMT
Message-ID: <1484243312.4367.220.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Viguera, Javier" <Javier.Viguera@digi.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Thu, 12 Jan 2017 17:48:32 +0000
In-Reply-To: <DA8287CC96892A4EB4FCF4FB3FBDA1AB01414A8E@dor-sms-xch01.digi.com>
References: <DA8287CC96892A4EB4FCF4FB3FBDA1AB01414A8E@dor-sms-xch01.digi.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Subject: Re: Backport git submodules fetcher fixes
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
X-List-Received-Date: Thu, 12 Jan 2017 17:48:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2017-01-12 at 17:04 +0000, Viguera, Javier wrote:
> Hi all,
>  
> I'm using bitbake 1.28 (under Yocto Jethro) and I have a problem with
> a git repository that has nested submodules. There are a couple of
> commits in version 1.30 that fix the problem. Those commits apply
> cleanly with git cherry-pick.
>  
> Could someone cherry-pick following commits into 1.28 branch?
>  
> In this order:
>  
> 1. 54a3864246f2be0b62761f639a1d5c9407aded4f
> 2. dbafbe229360ffe5908b106a9c10e274712b9b17
>  
> And eventually will these late fixes make it into Yocto  Jethro
> branch (poky.git repository)?

Done, thanks.

Richard

