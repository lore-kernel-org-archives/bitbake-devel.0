Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
 by mx.groups.io with SMTP id smtpd.web10.6010.1592295297144257595
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2020 01:14:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=UciyYSkM;
 spf=pass (domain: gmail.com, ip: 209.85.167.66, mailfrom: jacob.kroon@gmail.com)
Received: by mail-lf1-f66.google.com with SMTP id z206so11218096lfc.6
        for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2020 01:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=s3aIGBUhbX7uiYJyM8oQYRkJ3maaXhzaNUgmw5k5uWc=;
        b=UciyYSkM5sGu681drjWxNKu0n9Ci4gds96vqbof1Eea+rwIlvzGo+BKNqNdTfNKg+t
         h2J0imsK4nhMx+gO85Kd1KkFgaV2qsWEW94HKwcPdKtSfSyeA78/Hqn5UPb6M+1Wea2r
         +cBRGU5NhPJt+ejfr/1Kqby6ZiMjeKM8Xv4V1YvZkhR3GObHRQG0A70FrFnMYTU0xmaL
         sakpg4X1gnY2e4tt4CWuh3MKc/5z2reSoTGIj4nCWsIfee5lhp2tMjdVS4TbU9+yOvsE
         FyFAtDgKU3TTAkOEci3xUe10p+fNnGTSaRa6wqEg2QBVYzaNWEMinz1JWqtyfno2p+Bd
         pykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s3aIGBUhbX7uiYJyM8oQYRkJ3maaXhzaNUgmw5k5uWc=;
        b=aC0kidO6xnLZV/n/wpz68LkY/YrdF6QZtEufjLBSU18fo9V0lZB3aGxgcm+BlfIuLf
         Z/hIv6/xs/HWP3QlXxsIEh7NaOChU8PixY9t0fEG87oCp9EV6DlA+2+VWZzsbzdk2/X5
         Bn0ZygXwpYd1LaaO6o5IksWViQJdEXwuDbib7vc2zDTn6SRrI9q2GkT2Icizs+vW+4mx
         rnJYz5mzC/hWvXUVc37Up/ZsppOaFbKs8McJSi+DqQRr0oh/EhH5lP9pxHFxtNCZhIkX
         9PNEhVdra+jJC+djjle38dVDPblZ1UOTPg9AofwuNWzAyAD7nQi/619zI4BE/sdbIYfe
         ZqfA==
X-Gm-Message-State: AOAM530SC8LnGilAEqB5er1StmD1dgxlTVXkOIJ8TVZKAYtieGqIC431
	QBNmhAk7RhZ/PTRTJoQfCR1DqXNd
X-Google-Smtp-Source: ABdhPJzi/C5fmHDDZbouZJuNr0DTq9DdPlETURCRNAKwuKu1dyPlnr/yI1jjelJrmExifGcwUgPg0A==
X-Received: by 2002:a19:381a:: with SMTP id f26mr1107410lfa.110.1592295294936;
        Tue, 16 Jun 2020 01:14:54 -0700 (PDT)
Return-Path: <jacob.kroon@gmail.com>
Received: from localhost.localdomain ([213.185.29.22])
        by smtp.gmail.com with ESMTPSA id k22sm5085395lfg.69.2020.06.16.01.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 01:14:54 -0700 (PDT)
Subject: Re: [bitbake-devel] [PATCH] lib/bb/utils.py: Do not preserve TERM in the environment
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20200615122231.1325750-1-jacob.kroon@gmail.com>
 <2677ce4ecd89cb99e7bd491a68be93908023c87b.camel@linuxfoundation.org>
From: "Jacob Kroon" <jacob.kroon@gmail.com>
Message-ID: <b748351a-7330-50d0-86b3-890b3ec28570@gmail.com>
Date: Tue, 16 Jun 2020 10:14:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2677ce4ecd89cb99e7bd491a68be93908023c87b.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 6/15/20 2:29 PM, Richard Purdie wrote:
> On Mon, 2020-06-15 at 14:22 +0200, Jacob Kroon wrote:
>> The value of TERM is leaking into OE-Core postinst-useradd-${PN}
>> scripts,
>> which in turn can optionally be monitored by buildhistory. Prune the
>> value in
>> order to make the OE-Core buildhistory output more deterministic.
>>
>> Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
>> ---
>>   lib/bb/utils.py | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
>> index 5f5767c1..50032e50 100644
>> --- a/lib/bb/utils.py
>> +++ b/lib/bb/utils.py
>> @@ -580,7 +580,6 @@ def preserved_envvars_exported():
>>           'PATH',
>>           'PWD',
>>           'SHELL',
>> -        'TERM',
>>           'USER',
>>           'LC_ALL',
>>           'BBSERVER',
> 
> When you send a patch like this, please be clear that its for testing.
> I know from a discussion on IRC that this patch needs close vetting to
> see if its "safe" and its likely going to break things around the
> menuconfig tasks for example. The patch needs to state that so people's
> expectations are right.
> 

Right, I should have been more upfront with that in the patch. Should 
that go in the commit message itself, after the '---', or just a prefix 
in the email header ?

I understand TERM must be used for *something*, I've just never 
understood in what ways exactly. Is it for allowing 
screen/tmux/xterm/your-favourite-terminal to do extra fancy things ?

At a first glance I can't see anything breaking the kernels menuconfig, 
and in a devshell TERM is back, regardless if I use tmux or plain 
gnome-shell.

Jacob
