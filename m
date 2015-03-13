Return-Path: <rep.dot.nop@gmail.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id D897E6013D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Mar 2015 21:37:11 +0000 (UTC)
Received: by wibbs8 with SMTP id bs8so95137wib.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Mar 2015 14:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=user-agent:in-reply-to:references:mime-version
	:content-transfer-encoding:content-type:subject:from:date:to:cc
	:message-id; bh=V0Yqr1ak4xFNDBnMv8U7l2G6AkGGfdLBNKdF0Zw7/c8=;
	b=MTKD2q5+RBWO59MxiEEmLpn5n99vMjYtNHN6TiP4uQi6aRWt6H3oCANEJ5YIlxV8nF
	8GO3UlpEU/29q99cY3twZE5McXJk+JMheGy0c9O4Ux607a3ktMj9GwMAJ+bP33L9VLdT
	gxqnp2XDlxyIol+oZrY9eF0ZxoNxuA3BGfT8ZyIyfzFPsTDuAdSr112HbI64eNN4Avy4
	drb6JNm3NrSwJeTyY+e9EgRq2mgYAW3AB9WWftns94i9WoesZkqvt01JwU2vO51bgnfr
	U7irX85sj+B/1TgVmnaPCaeSi/IW7rjSAxfq2tO1gDOARdUB5IY+353Sy4tBnnzgIQqn
	E0LA==
X-Received: by 10.194.200.166 with SMTP id jt6mr56347633wjc.66.1426282631574; 
	Fri, 13 Mar 2015 14:37:11 -0700 (PDT)
Received: from [10.34.93.45] (089144233045.atnat0042.highway.a1.net.
	[89.144.233.45])
	by mx.google.com with ESMTPSA id e18sm4443258wjz.27.2015.03.13.14.37.10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 13 Mar 2015 14:37:10 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <68659A0D-CBFA-461A-AF15-D6E21B54A7E5@gmail.com>
References: <1425047544-4820-1-git-send-email-rob.woolley@windriver.com>
	<5501AFD7.40906@windriver.com>
	<1426177814.9114.119.camel@linuxfoundation.org>
	<55033D71.5070200@windriver.com>
	<68659A0D-CBFA-461A-AF15-D6E21B54A7E5@gmail.com>
MIME-Version: 1.0
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Date: Fri, 13 Mar 2015 22:37:05 +0100
To: "Woolley, Rob" <rob.woolley@windriver.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <471B1967-EB47-4869-98B6-9A0750147888@gmail.com>
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
X-List-Received-Date: Fri, 13 Mar 2015 21:37:12 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8

On March 13, 2015 10:12:00 PM GMT+01:00, Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> wrote:
>On March 13, 2015 8:41:37 PM GMT+01:00, "Woolley, Rob"
><rob.woolley@windriver.com> wrote:
>>
>>On 03/12/2015 12:30 PM, Richard Purdie wrote:
>>> On Thu, 2015-03-12 at 11:25 -0400, Rob Woolley wrote:
>>>> Hi,
>>>>
>>>> Just wanted to send out a ping to see if this enhancement is
>>desired.
>>>>
>>>> It scratches an itch for me, but not sure how others feel about it.
>>>>
>>>> If there are any changes I can make or extra tests I can run,
>please
>>let
>>>> me know.
>>> Patches 1/2 look good, I've run into the EPIPE issue myself and I
>>have
>>> noticed the crazy logfile so those can likely be merged.
>>>
>>> I'm less sure about 3, letting the user pipe the output to less when
>>> needed would seem to be the better way to have this rather than
>>adding
>>> in specific pagination support?
>>>
>>> Cheers,
>>>
>>> Richard
>>Sounds cool.  The exception was bugging me, so I'm glad to hear those 
>>ones look good.
>>
>>As far as the 3rd patch is concerned: I remember when I first used 
>>bitbake, I was surprised by the flood of data coming from those 
>>options.  I would suggest that doing the automatic paging provides a 
>>better first impression and saves unnecessary typing.
>>
>>I noticed that lib/image/help.py and lib/bsp/help.py have auto-paging 
>>for the help command.  I've CC'd Tom Zanussi for his opinion.
>
>Using PAGER is a good thing IMO.
>Not so setting LESS or LV nor outsmarting users PAGER=cat nor
>defaulting to less.
>I would also not attempt to check access() et al, just let the user fix
>her eventually broken export.

PS:
http://comments.gmane.org/gmane.comp.version-control.patchwork/1144
;)


