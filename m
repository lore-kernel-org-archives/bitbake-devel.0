Return-Path: <anonumiko@gmail.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id BB373750A0
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  8 Apr 2018 08:28:23 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id b127so11229641wmf.5
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 08 Apr 2018 01:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:subject:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=TjHss5wzXUC+iMA3bnWgRKl7S8U/E6F6R/9P3M18jEo=;
	b=KrVJ+fRVKSQN91G38ez5xKwNs0EbePReOoKsTmqfww0c3BGdQe/u2WA8gtbG1zo+AE
	VKJ5C2DMQqxAhs5YxlOeTpWYackvYCBqhi6TTKm/ihbX9k6qMGU0VDlxDRPVUqQ53EdY
	EoOEtIPmJkeDWFfd4L0qLNQtCAid1FImUyPG563FIxjFA0xAO52vniSsLRooKn4eIyLF
	sp/Q5gRK9JRqn+jCAi4MkxxTyzmIHfTdG4KbB6dWG97UUp7nN8cthj+d+9RxeJCLk+Co
	MeGddrH2BbIcdPwMKn7jS4HLqeSs0igK5/zyc4faETLM8iGHhU+jNV/KL5GbFYAVzOOm
	CGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=TjHss5wzXUC+iMA3bnWgRKl7S8U/E6F6R/9P3M18jEo=;
	b=o+w5z/8rA/eLLvEEmxPNIK2OcqWr+RF/tILmWWiCgmQCumZiYoIJvsyiIn7hMsMzUs
	gY/5e+/QScpLwCQBcssFJZLmB92SbkLDuGFvFFE0E4hLPKCgXZdebLfy6zbM6PRZCSkf
	fht3bLkTZaqTDfIQnbeH1d3lac2kilbyn+l+ZtFgNl+7O/UCd8IFSe3PZnl35coTuhnK
	p9cmAwFHP7L46HCaKBznbgtW5AKgxA0azgtPZGyBU6O7HFIi5gGyQjRG3Y/EQC6Iw+3j
	j5/3tpiiVfveRH8kVaF3Lzl6phHfu2CT4K3XegVsmbemz56Eae3/GhKD8n7d1Da2G9sR
	KrfA==
X-Gm-Message-State: ALQs6tB5U/gZQ7rzT4wBqfxt45F9wOUMJ9fG+KEkfudej/6Q0v3o9Cpu
	KcP/ZTWcymGf/rYKPGmTepJVa6hb
X-Google-Smtp-Source: AIpwx4/tZ2/vlOsIs93mscqsaN0z77IBjJZq1RvHsIoM352cYiG7z0GLyDYWfh37f/Ps7s6xrGYW0Q==
X-Received: by 10.46.16.130 with SMTP id 2mr19932415ljq.119.1523176103785;
	Sun, 08 Apr 2018 01:28:23 -0700 (PDT)
Received: from [82.181.15.94] (82-181-15-94.bb.dnainternet.fi. [82.181.15.94])
	by smtp.gmail.com with ESMTPSA id
	p22sm2371907ljg.39.2018.04.08.01.28.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 08 Apr 2018 01:28:22 -0700 (PDT)
Sender: anonumiko <anonumiko@gmail.com>
From: Niko Mauno <niko.mauno@iki.fi>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20180323092821.106187-1-niko.mauno@iki.fi>
	<1522828576.11431.280.camel@linuxfoundation.org>
Message-ID: <c42b3365-9ca6-cfc3-a233-e89f45c64f5c@iki.fi>
Date: Sun, 8 Apr 2018 11:28:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1522828576.11431.280.camel@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: fetch2/svn: Add tarsnapshots parameter
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
X-List-Received-Date: Sun, 08 Apr 2018 08:28:24 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 04/04/2018 10:56 AM, Richard Purdie wrote:
> On Fri, 2018-03-23 at 11:28 +0200, Niko Mauno wrote:
>> By adding 'tarsnapshots=currentonly' option to svn-specific component
>> in
>> SRC_URI, associated subversion repository module's existing tarball
>> snapshots are removed from DL_DIR, before creating a new one.
>>
>> This provides a means to avoid downloads directory becoming congested
>> with a subversion repository module's tarball snapshots, which may
>> occur
>> for example during circumstances where source code residing in a
>> subversion repository is subject to long-term development work, and
>> recipe used in continuous integration builds has SRCREV set to
>> AUTOREV.
>>
>> Signed-off-by: Niko Mauno <niko.mauno@iki.fi>
> 
> This model does't really work as if multiple things share the downloads
> directory there is a race window between the old tarballs being removed
> and the new one being created. The downloads and sstate directories are
> commonly shared between builds so we need to be mindful of this.
> 
> Cheers,
> 
> Richard
> 

Thank You for pointing this out.

As an observation related to using a shared downloads directory, it currently seems to already be subject to races when subversion is used - for example in a situation where two (or more) builds perform a temporally overlapping do_fetch for same recipe but with differing SRCREVs, and tarballs for respective SRCREVs have not been created yet.

In such cases error seems to occur because several distinct actors are trying to 'svn update' or 'svn checkout' in same directory at same time, resulting in a bitbake error for all build instances (typically involving a "working copy locked" error message).

