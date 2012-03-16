Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jpuhlman@mvista.com>) id 1S8ex1-0007iG-Qq
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Mar 2012 22:44:44 +0100
Received: by dado14 with SMTP id o14so7073502dad.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Mar 2012 14:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:x-enigmail-version:content-type
	:content-transfer-encoding:x-gm-message-state;
	bh=tMU/92ojFbnghvNNJ/cOTgA3qskcOawkMA4Y/R/28o4=;
	b=cHG0gKCuqoEdH5TaAnzw7GKNdQzj3fotNKY8Rt8mAn8hPs2qI6CkSYDPwjSK2D/gek
	O9p8e3HEQubRkiRIKBZn+zyte+XOLboLNg5FC3dbWv+FW85fKjws3cBJrhqqwkBvDKQV
	jJG9xIFGxDVvbeHzqIew/a7TzUIg6aDzFezYF6B2DjjJQnytzxGF58nmfAowY3h5LE5w
	XqVgVCgZeE6Sf9oJLFf4w+hw+xzCIIL1QkH4tznIuKMyQYbU7bo4JPr2mI8X4nkYAQmv
	EV1d6+ACpBn6bD6mUs/2k6YDlCSLkGKOvePde2oVR7Quc/l5unYgbH6vxM0TXbBZ9I6w
	A/ew==
Received: by 10.68.201.135 with SMTP id ka7mr18027671pbc.145.1331933754688;
	Fri, 16 Mar 2012 14:35:54 -0700 (PDT)
Received: from [192.168.1.4] (c-76-20-107-156.hsd1.ca.comcast.net.
	[76.20.107.156])
	by mx.google.com with ESMTPS id o2sm5091589pbb.45.2012.03.16.14.35.52
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 16 Mar 2012 14:35:53 -0700 (PDT)
Message-ID: <4F63B22A.3000005@mvista.com>
Date: Fri, 16 Mar 2012 14:35:38 -0700
From: Jeremy Puhlman <jpuhlman@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: Denys Dmytriyenko <denis@denix.org>
References: <4F6373BE.3040209@mvista.com> <20120316190831.GA21763@denix.org>
In-Reply-To: <20120316190831.GA21763@denix.org>
X-Enigmail-Version: 1.4
X-Gm-Message-State: ALoCoQnRVetj8F/Ie3qEs8On8TXzWtkN8PfoVoXmiYfIKYpyCJPRRnlmNGKV4G/XTPkb2x2Ib7fa
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Conflict between BBCLASSEXTEND and named recipes.
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
X-List-Received-Date: Fri, 16 Mar 2012 21:44:44 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


> 
> I don't have a solution, but I can confirm that this was a known issue all the 
> way back when BBCLASSEXTEND got introduced in Classic OE. The workaround was 
> to remove or mask the actual *-native.bb recipes.
> 

Thanks. I though I searched the archives, but apparently not well
enough. My first suggestion was BBMASK and that seemed to work as well.

-- 
Jeremy Puhlman
Montavista Software, LLC.


