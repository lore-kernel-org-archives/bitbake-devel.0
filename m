Return-Path: <rpjday@crashcourse.ca>
Received: from cpanel4.indieserve.net (cpanel4.indieserve.net [199.212.143.9])
	by mail.openembedded.org (Postfix) with ESMTP id 6958871A8D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Jun 2018 21:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
	Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hu7dENnHnOxd4uhOZb9k4xoBS3f7EHTRrg8S+n0q3+g=;
	b=JyQJx1TWCdPHIrPbdk8e+OyBH
	AeleXIT0mLqgFRW4gvzmtpH46qjIRrt0lqZ5UK2UIBojSH1x90kkPpBeEL0fOu1EKmREka0HsHCcM
	LWB0xpPPY9TC8nGTL7Zu5SnKuUMmPa58Io0Lr7TC0/F06K8JTkBqvklp6hrBVT3YDtZ4BoXAM2ZJk
	pRkIrp7Eyc9HuVqeFjtK6Hmj7zE14T69SyTmaWAjtc0t0tWR4uE/c0UypDkoHaXJRTXVtA7bEuMjs
	R6Yb4gzovYfOVBL3vUTh4GVbqkvNtfghdrj1LTh0NyeXSoBYwZyGQkU2FOB45GDwRiAVfQbrXKXCj
	2jZ15K83Q==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com
	([174.114.57.56]:58972 helo=localhost.localdomain)
	by cpanel4.indieserve.net with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.91)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1fXYxS-00DFsm-Nk; Mon, 25 Jun 2018 17:23:35 -0400
Date: Mon, 25 Jun 2018 17:23:33 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
In-Reply-To: <d4a5354857cd444eacd0acfff9e5e556@XBOX02.axis.com>
Message-ID: <alpine.LFD.2.21.1806251722200.12801@localhost.localdomain>
References: <alpine.LFD.2.21.1806241413250.29780@localhost.localdomain>
	<d4a5354857cd444eacd0acfff9e5e556@XBOX02.axis.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id:
	rpjday+crashcourse.ca/only user confirmed/virtual account not
	confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: is there a replacement for "bitbake -c fetchall"?
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
X-List-Received-Date: Mon, 25 Jun 2018 21:23:37 -0000
Content-Type: text/plain; charset=US-ASCII

On Mon, 25 Jun 2018, Peter Kjellerstedt wrote:

> > -----Original Message-----
> > From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> > devel-bounces@lists.openembedded.org] On Behalf Of Robert P. J. Day
> > Sent: den 24 juni 2018 20:16
> > To: BitBake developer list <bitbake-devel@lists.openembedded.org>
> > Subject: [bitbake-devel] is there a replacement for "bitbake -c
> > fetchall"?
> >
> >   haven't messed with OE/YP for a few months, just now noticed that
> > the "fetchall" task has been removed, is there something equivalent
> > since i found that useful for grabbing everything i would need later,
> > and updating my local source mirror in the process.
> >
> > rday
>
> It has been replaced with a generic --runall option to bitbake, see:
>
> https://www.yoctoproject.org/docs/latest/ref-manual/ref-manual.html#migration-2.5-bitbake-changes

  ah, i will test this later, but there was a significant difference
between the earlier tasks "fetch" and "fetchall", this suggests that
--runall=fetch is equivalent to the earlier fetchall, is that correct?

rday

