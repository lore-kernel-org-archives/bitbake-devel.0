Return-Path: <ross.burton@intel.com>
Received: from mail-ot0-f169.google.com (mail-ot0-f169.google.com
	[74.125.82.169])
	by mail.openembedded.org (Postfix) with ESMTP id EFB706006A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jun 2018 16:16:16 +0000 (UTC)
Received: by mail-ot0-f169.google.com with SMTP id v24-v6so2797142otk.13
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jun 2018 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=Uuaxq+J4y/RHR/SWMepYEoVJDkrs7VYAZR461xT94YA=;
	b=zLnvmKOln1Y+60p+QIF98DkJTsFfliBdiGJGbs32LeSjKdu2NWw23881FSJgf73PtJ
	tyhQbkIJH3fGE954uBLSWJGeNGTL7D+vKU16t7riga1FifZwt99jB4jb20sfeOKJJ9DC
	Df2sVjdwAgXaaYQC9WutYOMoK2HplGKL5ZOdIAQaG2dHwvHAGUYtMwQXA9jqeZ5lqE8Z
	duvNYY9fOsWCHg4idlhnisFJgY7sRKX3RDqIUrHjvrzXIhvDp57zSlJpiXyO3iQxc2VO
	f4pR+8/d8YHoWOtuvXrM8MJs06GreJ4hFvOzdM+KNi2Mtwd2s5qWWltW4Th5PCURWVTR
	LnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=Uuaxq+J4y/RHR/SWMepYEoVJDkrs7VYAZR461xT94YA=;
	b=IpjP2J512gyBceM6Shx0C2eN59wLr5KpuZfAVtUUBsj6B8KNhEG2RPbjSuoDkTmwZm
	7rR6ggi64HNDaHTB9J5O/LfcP2w152Y09PzZMqvWBPv2o/YfcmchnDWAoqlOLz3Xc2Hh
	7FK1GCWINeheh+um53xzbQ+3Y3TptiQ52YY58XM8RgzdlfURC3NR6fhdwK/HE5Zw22V+
	MdAekoWeJZ+sXAfTeVYUnpILc9JIKFP/dSo42Gku1CgTSEMCLtkN1tsdWrIg8AY9ThIL
	el0R7w+h8lNTI7/ikapDIzu8pgWK+linVn3gZ4j3Hx6gStQDOwcFKZyoeLvn1sd1M9qe
	kfag==
X-Gm-Message-State: APt69E3oVGeFQ+PLgXLMNYQSb+vkUb7rDE3hPWKVQrlDXKMQ0LMr+Kih
	ddkjkz/saKTU8/3JDBQiJ2stjeKdEvL5Q73YxWgeHA==
X-Google-Smtp-Source: AAOMgpe85BRPsEuUsh/ahp3iewSSJz5cUBkQaC2hdR/zDIJcmIiOD35iE5pP4Xe8LJBJc70bwl1i1mdsyfMUXni9llA=
X-Received: by 2002:a9d:609b:: with SMTP id
	m27-v6mr3625896otj.89.1530116178058; 
	Wed, 27 Jun 2018 09:16:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:434d:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 09:15:57
	-0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1806251722200.12801@localhost.localdomain>
References: <alpine.LFD.2.21.1806241413250.29780@localhost.localdomain>
	<d4a5354857cd444eacd0acfff9e5e556@XBOX02.axis.com>
	<alpine.LFD.2.21.1806251722200.12801@localhost.localdomain>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Wed, 27 Jun 2018 17:15:57 +0100
Message-ID: <CAJTo0LYgO0wjP-6vYdG9LhZqAochqrzYYQTBEcyTs=GeG7aOOQ@mail.gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
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
X-List-Received-Date: Wed, 27 Jun 2018 16:16:17 -0000
Content-Type: text/plain; charset="UTF-8"

On 25 June 2018 at 22:23, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>   ah, i will test this later, but there was a significant difference
> between the earlier tasks "fetch" and "fetchall", this suggests that
> --runall=fetch is equivalent to the earlier fetchall, is that correct?

Yes.  The old fetchall is just --runall=fetch now.  Ditto other *all
tasks which have been deleted, and you can use runall on any other
task too.

Ross

