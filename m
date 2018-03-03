Return-Path: <raj.khem@gmail.com>
Received: from mail-pf0-f169.google.com (mail-pf0-f169.google.com
	[209.85.192.169])
	by mail.openembedded.org (Postfix) with ESMTP id 096BE789A0
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  3 Mar 2018 02:30:51 +0000 (UTC)
Received: by mail-pf0-f169.google.com with SMTP id 17so4761030pfw.11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Mar 2018 18:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-language:content-transfer-encoding;
	bh=AqT5BJh0FDd6lmfoTi8x90nsh4ZbGSriffYMaEcFDi4=;
	b=vM/hQjA/+UvcAbiLa88u8uxcFWElV2fzUTeJpg6nOYuezimvW7U81eM9EBwEAKkBXI
	uhr5mXLAlEgyT1x2yt6nF7ggpebalo7ddJL3rnqwziYDXF/HT5HJq1Sb4dboRY0xV8zD
	FKJC5KcXw8qa1tN3lxplsLGE5+y0cBbTEIVCq4cthkdN7w5KhtL/G8IvGYmQQ/P0Jwud
	tk/Lt/iZ+ojGIUyFKIqZpoNeIGTv2psLlM8jw1Zg5Koz80bz4m8gCnmpMAstjAqQYBGp
	57qZwWpa0KdadKXIa77Hit0dcV//03mlXRv3OF4Tc8t1ZtIsSrYJwhIPL49fWLRs+sln
	r10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=AqT5BJh0FDd6lmfoTi8x90nsh4ZbGSriffYMaEcFDi4=;
	b=knCRj794WE5uWTFnBdpsoyPE0V1Ng4QVBjLPC293z5y/FiUDLIfU0L4bK9gQKBNjKw
	f2je61+JAnJeLAVioMwTZngftRlDb0MK8ShCOFxfq4h32A0nqxy3JeCU1fwcdnPkciuo
	y4q9/hrjskznAbRWP8082p/Q4DSWC5bfXDgmOwN3tASRtPbZuFlc70wUVCin7iFk9xQc
	5Qnjv3beEp2HbHfU4akf0+wLr4o6VZJSeGhnUXWSSGFHWjBurtAaVRxwNpOoXAJGJT4N
	+YnUOcwDbVfYzT0mcHtdeIn3idEo7TenBpFETiCffO1dmPeuQv4E/ponKGawBZngxEpM
	iNWg==
X-Gm-Message-State: APf1xPD8R2EicQxrybEa3G6xO4x/smYMfTbOrYA28lXIKDW7JuqRk4Qg
	dc0MAyYroyOoLSHwJSjP+ZE=
X-Google-Smtp-Source: AG47ELuUN3eYppNkx4QaT6fpB36rQqWLs8brI0n3hqPzsJ5TlYyEQ6DoJSge99PirDnc09Akr2Edxg==
X-Received: by 10.99.126.12 with SMTP id z12mr6160830pgc.142.1520044252943;
	Fri, 02 Mar 2018 18:30:52 -0800 (PST)
Received: from ?IPv6:2601:646:8880:466c:a564:75fb:6e2a:d708?
	([2601:646:8880:466c:a564:75fb:6e2a:d708])
	by smtp.gmail.com with ESMTPSA id
	u18sm13839586pfm.48.2018.03.02.18.30.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 02 Mar 2018 18:30:52 -0800 (PST)
To: Parthiban Nallathambi <pn@denx.de>, bitbake-devel@lists.openembedded.org, 
	yocto@yoctoproject.org
References: <69aee4a6-ed3b-bbb3-7896-818a8904a98e@denx.de>
From: Khem Raj <raj.khem@gmail.com>
Message-ID: <0821fd17-6673-787f-ee85-34aac1b0919c@gmail.com>
Date: Fri, 2 Mar 2018 18:30:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:58.0)
	Gecko/20100101 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <69aee4a6-ed3b-bbb3-7896-818a8904a98e@denx.de>
Subject: Re: [yocto] Add custom user to custom group in bitbake recipe
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
X-List-Received-Date: Sat, 03 Mar 2018 02:30:52 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 3/2/18 3:36 AM, Parthiban Nallathambi wrote:
> Hello All,
> 
> I have created a custom group e.g "grp1" in my application recipe say
> "app.bb".
> 
> GROUPADD_PARAM_${PN} = "grp1"
> 
> I am trying to add my custom user e.g: "user1" to this group "grp1" in
> "space.bb".
> 
> USERADD_PARAM_${PN} = "-d ${localstatedir}/lib/space/ -s /bin/false -G
> grp1 -U user1"
> 
> The useradd command failed: "useradd: group 'grp1' does not exist". I
> have also tried adding DEPENDS_${PN} = "app" in space.bb, but it doesn't
> help.

ensure that the package adding group is also part of final image. For
that you might use something like

RDEPENDS_${PN} += "app"

in the recipe which is adding the user

> 
> How can I add my custom user to my custom group in bitbake recipe?
> 
> Question in Stackoverflow:
> https://stackoverflow.com/questions/49068076/yocto-add-custom-user-to-custom-group
> 
> 


