Received: from mail-bk0-f47.google.com ([209.85.214.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <aleh.arol@gmail.com>)
	id 1RshEC-0005i6-Nz; Wed, 01 Feb 2012 21:56:28 +0100
Received: by bke17 with SMTP id 17so1533301bke.6
	for <multiple recipients>; Wed, 01 Feb 2012 12:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=message-id:date:from:reply-to:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=r4chNv2Pppbi83oyw8kcpmddNna21yvCgdCMX0x8m90=;
	b=YWu8Yqp1MTlk9NwA5o/UOPu9zC+bqqyaTD0tNQi0hxxI6+ZZX2t34NkoDwrJRiDPlC
	JncPdvPH+aC+QsvhflgQfvMvKv8BqE8+2EuCmJ+4bw4pQuOvA3yE6FsjXiovv5Jfj3bJ
	xf1EEZHNtKBgNtNNpD1s0H27A17jxw6iKckFY=
Received: by 10.204.145.210 with SMTP id e18mr55615bkv.61.1328129311489;
	Wed, 01 Feb 2012 12:48:31 -0800 (PST)
Received: from [192.168.0.102] ([87.252.227.5])
	by mx.google.com with ESMTPS id cz3sm365068bkb.3.2012.02.01.12.48.29
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 01 Feb 2012 12:48:30 -0800 (PST)
Message-ID: <4F29A51B.40407@gmail.com>
Date: Wed, 01 Feb 2012 23:48:27 +0300
From: Aleh Arol <aleh.arol@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:9.0) Gecko/20111229 Thunderbird/9.0
MIME-Version: 1.0
To: openembedded-devel@lists.openembedded.org, 
	bitbake-devel@lists.openembedded.org
References: <4F26B9D3.9010709@gmail.com> <2370505.PRl1Ey1z8e@helios>
In-Reply-To: <2370505.PRl1Ey1z8e@helios>
X-Mailman-Approved-At: Sat, 04 Feb 2012 12:12:01 +0100
Subject: Re: source folder package dependency
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
Reply-To: aleh.arol@gmail.com
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 01 Feb 2012 20:56:28 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ср. 01 февр. 2012 18:37:08, Paul Eggleton писал:
> On Monday 30 January 2012 18:40:03 Aleh Arol wrote:
>> I have a question I don't know how to solve:
>> I have a library, for example, boost, and a part of that
>> library(packaged together I mean), like bjam is required to build it.
>>
>> So I have boost-X.Y.Z.bb recipe and src/boost-X.Y.Z folder(I have
>> sources locally) and I need to create bjam recipe. I can make
>> bjam-X.Y.Z.bb where I will refer to folder src/boost-${PV} as ${SRC_URI}
>> and ${S} to find jam sources under. Then if I'll need to have 5
>> different versions of boost I'll need to create 5 different versions of
>> bjam recipe.... although I can use bjam.inc it will still be 5 bjam recipes.
>>
>> How can I avoid that? Any way to have a version agnostic bjam recipe? Or the
>> right way of doing this.

Thanks you for the answer first of all.
>
> (I presume this is in the context of OpenEmbedded.) 
No, but that doesn't matter.
What you describe is the
> accepted way of doing things - you have a recipe for each version of the piece 
> of software you're building and share the common things with a .inc file, using 
> ${PV} to abstract away the version. Each individual recipe ends up quite small 
> with the bulk of the definitions in the inc file.
>
> You could have a recipe which did not specify a version in the recipe filename, 
> and set PV manually instead (possibly with a default); then you could set 
> PV_pn-bjam = "1.1" in your distro or local configuration to pick the version. 
> However I would describe that as unorthodox, and it will not work if you have 
> to handle other differences between versions (e.g. renamed/moved files, 
> additional configuration options, etc.) I will say however that this is more or 
> less how we handle recipes built from a version control system (e.g. git); 
> except in that case we set PV to something including SRCREV e.g. 
> "1.0+gitr${SRCPV}" and then set SRCREV externally.
Ok, that's more or less what I ended up with. Actually I'm ok with a
"recipe per version" way - I just gave an example of boost/bjam -
actually I have a python-ogre (if it says something to you - if not
there are several packages under one folder) and I try to
make a recipe per each incorporated package. So, I will end up twice as
much recipes if I will add another python-ogre version.
>
> The question is will you really need 5 different versions? Or just 2-3?
You are right, my question was theoretical. Just interested if there is
a better way.
>
> Cheers,
> Paul
>

Thanks again.
-- 
Best regards,
Aleh Arol


