Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5992D605FE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Feb 2016 23:55:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1ANtrPH003934; Wed, 10 Feb 2016 23:55:53 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id tmnXf-hBAHKU; Wed, 10 Feb 2016 23:55:53 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1ANtn0h003931
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 10 Feb 2016 23:55:50 GMT
Message-ID: <1455148549.16142.183.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andre McCurdy <armccurdy@gmail.com>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
Date: Wed, 10 Feb 2016 23:55:49 +0000
In-Reply-To: <CAJ86T=XzRYAohb5Zr-hqxgZX=diMZd3ixz5Pk9TCUVe1zuNztA@mail.gmail.com>
References: <CAJ86T=XzRYAohb5Zr-hqxgZX=diMZd3ixz5Pk9TCUVe1zuNztA@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: Unable to abort bitbake with ctrl-c
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
X-List-Received-Date: Wed, 10 Feb 2016 23:55:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2016-02-10 at 13:29 -0800, Andre McCurdy wrote:
> With today's master branch, attempting to abort bitbake while it's
> parsing recipes results in a hang and the following error message:
> 
>   ERROR: Timeout while attempting to communicate with bitbake server

Related to http://git.yoctoproject.org/cgit.cgi/poky/commit/bitbake?id=
916c73dfefe0c4f960299ead6b4b7b3dcb18fc89 ?

Cheers,

Richard

