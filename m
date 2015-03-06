Return-Path: <clemens.lang@bmw-carit.de>
Received: from mail.bmw-carit.de (mail.bmw-carit.de [62.245.222.98])
	by mail.openembedded.org (Postfix) with ESMTP id 44BB66017E
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Mar 2015 13:03:29 +0000 (UTC)
Received: from exchange2010.bmw-carit.intra ([192.168.100.28]:36229
	helo=mail.bmw-carit.de)
	by mail.bmw-carit.de with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.82_1-5b7a7c0-XX) (envelope-from <Clemens.Lang@bmw-carit.de>)
	id 1YTruT-0000Jo-0Y; Fri, 06 Mar 2015 14:03:21 +0100
Received: from localhost (172.20.20.163) by Exchange2010.bmw-carit.intra
	(192.168.100.28) with Microsoft SMTP Server (TLS) id 14.1.218.12;
	Fri, 6 Mar 2015 14:03:20 +0100
Date: Fri, 6 Mar 2015 14:03:20 +0100
From: Clemens Lang <clemens.lang@bmw-carit.de>
To: Martin Jansa <martin.jansa@gmail.com>
Message-ID: <20150306130320.GO5023@ulm-bmuc496424.bmw-carit.de>
References: <20150227120026.GA13973@ulm-bmuc496424.bmw-carit.de>
	<20150306114328.GN5023@ulm-bmuc496424.bmw-carit.de>
	<20150306122238.GF2337@jama>
MIME-Version: 1.0
In-Reply-To: <20150306122238.GF2337@jama>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [172.20.20.163]
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: fetch2: Revalidate checksums, YOCTO #5571
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
X-List-Received-Date: Fri, 06 Mar 2015 13:03:31 -0000
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Martin,

On Fri, Mar 06, 2015 at 01:22:38PM +0100, Martin Jansa wrote:
> Using pickle is much better than counting the checksums on every
> do_fetch.. we have GBs of sources and we don't want to spend extra
> minutes on the build to re-check them if they are identical.

That's what I thought as well. The pickle method should scale a lot
better than re-running the hash calculation, especially in terms of I/O
ops.

> Maybe add the file time stamp as well, if the file was modified then
> .done could be invalidated and checksums re-verified.

I could modify the code to avoid reading the precomputed checksums if
the .done file is older than the downloaded file, which should cover
this case. Of course, the modification date will not be of much use if
the download is not a file, but a directory.

Does this sound good to you?


Clemens
-- 
BMW Car IT GmbH
Clemens Lang
Spezialist Entwicklung
Lise-Meitner-Straße 14
89081 Ulm

Tel: +49-731-37804182
Mail: clemens.lang@bmw-carit.de
Web: http://www.bmw-carit.de
--------------------------------------------------------------------
BMW Car IT GmbH
Geschäftsführer: Michael Würtenberger und Reinhard Stolle
Sitz und Registergericht: München HRB 134810
--------------------------------------------------------------------

