Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>)
	id 1QwcNH-0005ZG-BS; Thu, 25 Aug 2011 18:01:47 +0200
Received: by pzk2 with SMTP id 2so3892783pzk.34
	for <multiple recipients>; Thu, 25 Aug 2011 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=uAYwl2fo+h9fXqXzAZwWei3lq07jWegIJtL5X2/RrAM=;
	b=XdPNYXiCXpGLKDU2X7mLzg/HBwTljluqwOExgsUvcN2ZxfELJUoU/NeSbDW5e9u+SB
	VbGtpsPeRZPHDQiyAeSDqvhuMeN+8lN7uhtGSiv0eo+yn/EUj7mu9Ib+NN8GPJrgHFZW
	eMWmRA3v9iIxwZZFVQ5TxyzKr91sJZiec1ngE=
Received: by 10.142.239.2 with SMTP id m2mr3318309wfh.169.1314287818675; Thu,
	25 Aug 2011 08:56:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.40.168 with HTTP; Thu, 25 Aug 2011 08:56:28 -0700 (PDT)
In-Reply-To: <201108251150.01236.paul.eggleton@linux.intel.com>
References: <201108021226.34560.paul.eggleton@linux.intel.com>
	<CABcZAN=rG0acoqcV6s-gNvvziM0ON97BzNwtZkESu+wz7vQO-g@mail.gmail.com>
	<A3E3935F-5D98-4208-A45F-DC409F1C97CF@gmail.com>
	<201108251150.01236.paul.eggleton@linux.intel.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 25 Aug 2011 08:56:28 -0700
Message-ID: <CAMKF1spSE=nuQ1LGOmub3XaH-z+6oJT+n5hC7LdKvdKeScLWNw@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] Layer priorities influencing default version selection
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 25 Aug 2011 16:01:47 -0000
Content-Type: text/plain; charset=UTF-8

On Thu, Aug 25, 2011 at 3:50 AM, Paul Eggleton
<paul.eggleton@linux.intel.com> wrote:
>>
>> In my opinion the layer priority for all kind of meta data should be
>> consistent and selected using bblayers.conf
>
> So I've thought about this more, and I don't think it is a good idea, for two
> reasons:
>
> 1) It increases the complexity by a huge amount. New users will have to
> understand how to set the priorities, and if someone reports a problem, we now
> not only need to know what layers they are using, we also need to know what
> mangling of the priorities they might have done. We'd just be introducing more
> potentially untested configurations (as if we don't have enough already.)

with layers we dont control policies of all the layers that may be used on top
so fixing meta-oe does not solve problem completely and we can not ask
for exclusive
recipes. People would want to override the recipes from other layers.

bitbake could report the layer the recipe comes from which can make it evident
or may be special command to inform the layer priorities. This will guide the
users to diagnose the problems quickly and help developers to identify
the issues
faster. There could be a complete bill of recipes printed for a given
target as well
so if someone wants to check all the recipes that were built.

>
> 2) It just papers over real problems in meta-oe or any other layer you might
> choose to use on top. As I said, if meta-oe has stuff in it that is not
> working, it should be fixed or removed. Let's fix problems instead of finding
> ways of ignoring them.
>

In any case I agree that problems should be fixed. However this does
not scale to all
layers and we can not police all the layers and we should not. We
should try to make it possible
for people to glue layers together without  issues.


