Return-Path: <andr2000@gmail.com>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
	[209.85.215.68])
	by mail.openembedded.org (Postfix) with ESMTP id AE13578416
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Nov 2017 19:31:34 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id b190so361197lfg.9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 07 Nov 2017 11:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=zBGPKf0hdPr/NVDqpv8E4SGP6ZES5oHHRXEsgaQChu8=;
	b=X+efGz7v1O2N19ZqvvglzvJHB4uKdf1XYpqBW4ys5i+iPoRb7k1i9a/yZoJV6oym4Q
	rvnG98PQYP3tYEkYF5qLcXyWIEgI003UMyiaWu4Dw70DWErSBdVqIdsuCquC16Ian/QM
	4Yhot6GfBzugJR7y3CPZ0bqVE+XqXU9JY+jdk2JO1+Sjyxg3YsDaRO/AnEG8l1XhoenY
	bwZAZAOYP/fKXO0IYymejgBVEuwjoB/DR7sCYFU4B6klOWjDIxC3+9eAJmhagQoWu3u8
	pZJ0vxkk9LeZBsl+BEaPn1shxoayJ+kpK89iO0OKtpiwUXfErNDzaoyREC7Jga1kbyWV
	ZLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=zBGPKf0hdPr/NVDqpv8E4SGP6ZES5oHHRXEsgaQChu8=;
	b=bAOCHkTz1uveREKPPPa1dFTF0M6dpdHHst7vRZoa2STe2KT6S/P5gEj1RUBq33ghxk
	ONgt7UuGIutSynT14GgHF6LpnzJfW21j7+sP+vDwQ6lJVQra5+GkyrF5s0eky6cwb096
	CuLC6mAOWnzeGV7Eqaqj3AVqC0ip7+t1yC7M7rt0ds8WYw/USQdW4voEfBQ2RuOk/owY
	fgeinevMvYZcIrvcHPxPVtW5GgBSbDyR9Y2TB5XbfLFtSJf9ZDy6nRaAj69NKyzftqQY
	JNRS4hsvNr2006ZXm/ufQ762G1FmRU2U/stGIQyfo02/v6xXe9FJAiOOGRgF40xNPS9d
	Y3Ww==
X-Gm-Message-State: AJaThX4Yl4YUNV9PM3K2kmgfWkEXDQ+4+S6SSQpEJO2/ZMrAx7bbmn8a
	AZ5FhpIt/2H+YQA4nDm+N1w=
X-Google-Smtp-Source: ABhQp+QTj59Em4FNCpFoyb8hfYmT6G+o/IJnbArPaFWNGnDSC64QCUQl4XywmFe56hYTvk5KkGW1gw==
X-Received: by 10.46.88.9 with SMTP id m9mr3536478ljb.15.1510083095174;
	Tue, 07 Nov 2017 11:31:35 -0800 (PST)
Received: from [192.168.0.20] (176-21-94-178.pool.ukrtel.net. [178.94.21.176])
	by smtp.googlemail.com with ESMTPSA id
	13sm391829ljv.10.2017.11.07.11.31.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 Nov 2017 11:31:33 -0800 (PST)
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
References: <1508844944-5761-1-git-send-email-andr2000@gmail.com>
	<1508844944-5761-4-git-send-email-andr2000@gmail.com>
	<1510062330.3952.8.camel@linuxfoundation.org>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <03c9c452-1fab-60e3-2247-e6235482e718@gmail.com>
Date: Tue, 7 Nov 2017 21:31:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1510062330.3952.8.camel@linuxfoundation.org>
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH 3/4] fetch2/repo: Make fetcher always sync on unpack
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
X-List-Received-Date: Tue, 07 Nov 2017 19:31:35 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US


On 11/07/2017 03:45 PM, Richard Purdie wrote:
> On Tue, 2017-10-24 at 14:35 +0300, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Currently if repo has fetched the repository and
>> cached it to a tar file it never runs repo sync again,
>> thus making the build use potentially outdated repo.
>> Fix this by implementing unpack functionality which runs
>> repo sync.
> This sounds incorrect to me. The unpack task is not meant to touch the
> network at all, all network access should be done in the fetch
> function.
agree, so, instead this should be done via supporting source

revisions, so fetcher can deal with it? Is this understanding correct?

> Cheers,
>
> Richard
Thank you,
Oleksandr

