Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5D885761B2;
	Thu, 23 Jul 2015 21:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6NLoTl9015886; Thu, 23 Jul 2015 22:50:56 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ESoFOskIf3Ki; Thu, 23 Jul 2015 22:50:56 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6NLoh3c015942
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 23 Jul 2015 22:50:54 +0100
Message-ID: <1437688243.821.139.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jate Sujjavanich <jatedev@gmail.com>
Date: Thu, 23 Jul 2015 22:50:43 +0100
In-Reply-To: <CAPphmgbXq_xx3_ZgFvSfoLDCD-J7r2gga+kcFsRw-ewpQp6W4w@mail.gmail.com>
References: <CAPphmgbXq_xx3_ZgFvSfoLDCD-J7r2gga+kcFsRw-ewpQp6W4w@mail.gmail.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: [PATCH v3][0/2] Yocto Bug #6149
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
X-List-Received-Date: Thu, 23 Jul 2015 21:51:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2015-07-23 at 17:32 -0400, Jate Sujjavanich wrote:
> These patches add code to handle a PREFERRED_PROVIDER for a runtime
> item.
>
> The providers.py code chooses a recipe based on a runtime package to
> resolve the multiple providers warning.
>
> Then during package generation, the new image.bbclass code substitutes
> the package into PACKAGE_INSTALL that RPROVIDES the runtime item if
> the PREFERRED_PROVIDER is defined.
> 
What this doesn't do is fix the problem where one of these names is used
in a packagegroup or some other place than PACKAGE_INSTALL. I believe I
mentioned this the last time you sent patches as well.

Due to that, it would lead to gross inconsistencies in the way the
system would behave and it can't be merged as is, sorry.

Cheers,

Richard
> 



