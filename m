Return-Path: <rep.dot.nop@gmail.com>
Received: from mail-we0-f178.google.com (mail-we0-f178.google.com
	[74.125.82.178])
	by mail.openembedded.org (Postfix) with ESMTP id 1D9996013D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Mar 2015 21:12:11 +0000 (UTC)
Received: by wesw62 with SMTP id w62so25888107wes.8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Mar 2015 14:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=user-agent:in-reply-to:references:mime-version
	:content-transfer-encoding:content-type:subject:from:date:to:cc
	:message-id; bh=fqipNeruS8bDcKY1fA/uFZoa1WsNF9iiiBr1Y6ZPaO8=;
	b=gTs0X4bMawGgfnZQ/ZC+500LtEdrEkrhN+u4z4Xwn99xOeRqDEFyjXI60yFXouEtPx
	Br5Nnw6YRCtOt0/8spoR32LDgM/X7fgfJA3u2K1/divN+zBGcXASw1ka2yYblnXmNwfi
	lHF8QXofUMMcKh3+1T4wcCCGOxKWg9SduRlQAzkfmmiBAqude0d6xkeR8WXBkMrykzXw
	4EPV31TnyIIkdVw4rvkiXCGNFalQ9keJOrMFXr2kng1y0SaArzyLMkd7ztZodd5ORAWc
	WZAyCTme9Lm0LhEBxl+oHUvkovQkzUbao9t6/Ffsg+QIK2ezK+djayCL4cE1ciNTW9iU
	jl4A==
X-Received: by 10.194.159.105 with SMTP id xb9mr48813727wjb.156.1426281132369; 
	Fri, 13 Mar 2015 14:12:12 -0700 (PDT)
Received: from [192.168.100.51] (91-119-229-249.dynamic.xdsl-line.inode.at.
	[91.119.229.249])
	by mx.google.com with ESMTPSA id uo6sm4347760wjc.49.2015.03.13.14.12.10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 13 Mar 2015 14:12:11 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <55033D71.5070200@windriver.com>
References: <1425047544-4820-1-git-send-email-rob.woolley@windriver.com>
	<5501AFD7.40906@windriver.com>
	<1426177814.9114.119.camel@linuxfoundation.org>
	<55033D71.5070200@windriver.com>
MIME-Version: 1.0
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Date: Fri, 13 Mar 2015 22:12:00 +0100
To: "Woolley, Rob" <rob.woolley@windriver.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <68659A0D-CBFA-461A-AF15-D6E21B54A7E5@gmail.com>
Cc: tom.zanussi@linux.intel.com, bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] knotty: Add automatic pager support
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
X-List-Received-Date: Fri, 13 Mar 2015 21:12:12 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8

On March 13, 2015 8:41:37 PM GMT+01:00, "Woolley, Rob" <rob.woolley@windriver.com> wrote:
>
>On 03/12/2015 12:30 PM, Richard Purdie wrote:
>> On Thu, 2015-03-12 at 11:25 -0400, Rob Woolley wrote:
>>> Hi,
>>>
>>> Just wanted to send out a ping to see if this enhancement is
>desired.
>>>
>>> It scratches an itch for me, but not sure how others feel about it.
>>>
>>> If there are any changes I can make or extra tests I can run, please
>let
>>> me know.
>> Patches 1/2 look good, I've run into the EPIPE issue myself and I
>have
>> noticed the crazy logfile so those can likely be merged.
>>
>> I'm less sure about 3, letting the user pipe the output to less when
>> needed would seem to be the better way to have this rather than
>adding
>> in specific pagination support?
>>
>> Cheers,
>>
>> Richard
>Sounds cool.  The exception was bugging me, so I'm glad to hear those 
>ones look good.
>
>As far as the 3rd patch is concerned: I remember when I first used 
>bitbake, I was surprised by the flood of data coming from those 
>options.  I would suggest that doing the automatic paging provides a 
>better first impression and saves unnecessary typing.
>
>I noticed that lib/image/help.py and lib/bsp/help.py have auto-paging 
>for the help command.  I've CC'd Tom Zanussi for his opinion.

Using PAGER is a good thing IMO.
Not so setting LESS or LV nor outsmarting users PAGER=cat nor defaulting to less.
I would also not attempt to check access() et al, just let the user fix her eventually broken export.

YMMV.
HTH && cheers,



