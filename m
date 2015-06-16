Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3C9DA601DF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Jun 2015 16:26:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t5GGPHb8020207; Tue, 16 Jun 2015 17:26:54 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id QVaF_fHOJL0T; Tue, 16 Jun 2015 17:26:54 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t5GGQeDn020265
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 Jun 2015 17:26:52 +0100
Message-ID: <1434472000.19270.22.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Urbanec <openembedded-devel@urbanec.net>
Date: Tue, 16 Jun 2015 17:26:40 +0100
In-Reply-To: <557ECADA.8080509@urbanec.net>
References: <557ECADA.8080509@urbanec.net>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: prserv nohist mode is broken - suggested fix included
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
X-List-Received-Date: Tue, 16 Jun 2015 16:27:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2015-06-15 at 22:53 +1000, Peter Urbanec wrote:
> Hi,
> 
> I've run into a strange problem where in some cases package version
> numbers would roll back. Eventually I tracked the issue to prserv
> apparently not doing the right thing when running in the default
> nohist mode.
> 
> As a simple example, I have this in PRMAIN_nohist:
> 
>  version                 pkgarch    checksum
> value
> ------------------------------------------------------------------------------
> "beyonwiz-base-1.3-r0"    "all"    "d87bfea4ce066ec8b6041a8d3188956b"
> "43"
> "beyonwiz-base-1.3-r0"    "all"    "bba78fccad5b1b5ec9841a4002bd0252"
> "42"
>
> I think the problem is the primary key used for the nohist table. It
> should not include the checksum column.

I don't understand how the above shows a problem? Can you give an
example workload where the version number goes backwards or explain the
problem a bit more?

Even though the primary key is (version,pkgarch,checksum), it should do
an insert or replace and therefore although that key has to be unique,
it should replace an entry with a higher value?

Also, was sstate involved in the state rolling back? I have seen cases
where sstate was restored and versions did roll back...

Cheers,

Richard


