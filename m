Return-Path: <raj.khem@gmail.com>
Received: from mail-pf0-f170.google.com (mail-pf0-f170.google.com
	[209.85.192.170])
	by mail.openembedded.org (Postfix) with ESMTP id 29785745E9
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 14 Apr 2018 00:36:58 +0000 (UTC)
Received: by mail-pf0-f170.google.com with SMTP id y66so7206532pfi.7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Apr 2018 17:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:organization:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=dXG1MKfAJdE1QBbEq8Le5OX6fvAgzVXCFFer+DCf+dY=;
	b=X1qbpkNKKO6J+P9asxVPiS9tIg3U+h/i8pje9OVNO5tBlLl1MLtzt4Boey633uSfWc
	SEoig0pDHsrr+aYecVWmy+JPQY/nO6jknb8HWweTxwgaaF21dGN7j2/BjP34d7kTGFnh
	2hqwbG/Ih/8EetSadwLCyL8u61HmLVOByTG97XXTjFWh8SJVONYyqo5p/ZYFnfqBKEd3
	zquw5IgR4shYIPgyPN7x37fcHRPEzec/CjjtJ90eI8kU5R/pyKd/ClMiWrkWrXXk+Cjy
	4Ma2QVV9nzitAC4j+xdSFzhaqilgoiNZFXSdZJImaZz1uVlqaWI+3B0eRnMhxuCTPARb
	eNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:organization
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=dXG1MKfAJdE1QBbEq8Le5OX6fvAgzVXCFFer+DCf+dY=;
	b=M7nQnRTrfWlfUjcv/NkU14mHbz6mbGPPAHvfaAxoyDy9r7NgvVlGx7nvQtuPshWLwr
	VIcZGReYemfpPjbAqovCoKu60gj148afCBwbdCzsr3ixpnLuPIg6vIHq5axga+QnOWtZ
	ATOOSIzTAcBvZF+CTLcaI6Ix2EZfJvM2Zu6gcoECaMBsfWkkgcX8pDzICoFObUEPA0Ph
	xyhjy3a5s0a4xsxUjj85ZBPphq5vDlUVui4GuAiXXNMUNzoXRvhCUZavbm69NPYfsTGo
	OOaoCxZJl1VcsIM2c7PuXL0/4umPEJRvhNLRi2yZySkodAODDCekXRVrjonO92glm7rx
	3wDA==
X-Gm-Message-State: ALQs6tBzYoOiNFFORmjZ1Ix6NbNedbh4S3n7XVM1TFXwGs+VNnyw0jTW
	5U4gDHMXAFjgyzRDIk0+VOV2A/pL
X-Google-Smtp-Source: AIpwx49oGS6pt8Vx+UdHoQBjr0iKDb4ZgJGQmZFRFZDg6oEvpn//kXSc11HDtUnhWp2hFrALmYh3Tg==
X-Received: by 10.98.102.65 with SMTP id a62mr13423271pfc.68.1523666219600;
	Fri, 13 Apr 2018 17:36:59 -0700 (PDT)
Received: from hermes.local ([2601:646:8880:466c:4caf:c486:61ac:d2f7])
	by smtp.gmail.com with ESMTPSA id
	x137sm13754292pfd.162.2018.04.13.17.36.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 13 Apr 2018 17:36:58 -0700 (PDT)
To: =?UTF-8?Q?Jakub_D=c4=99bski?= <jdebski@enigma.com.pl>,
	bitbake-devel@lists.openembedded.org
References: <1523526293-14340-1-git-send-email-jdebski@enigma.com.pl>
From: Khem Raj <raj.khem@gmail.com>
Organization: HIMVIS LLC
Message-ID: <b80568f3-fe78-f92a-7213-dfc64424ff41@gmail.com>
Date: Fri, 13 Apr 2018 17:36:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
	Gecko/20100101 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1523526293-14340-1-git-send-email-jdebski@enigma.com.pl>
Subject: Re: [PATCH] fetch2/git.py: Added handling of the user's password in url
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
X-List-Received-Date: Sat, 14 Apr 2018 00:36:59 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 4/12/18 2:44 AM, Jakub Dębski wrote:
> Fetching source code from private repository (using https or http) fails
> because password passed in url (git://user:pass@domain) is ignored.
> 

this is a security issue since SRC_URIs get into the package metadata
infact a patch to detect this case and warn/error about it will be 
better. You might want to use .netrc to specify the credentials.

> Signed-off-by: Jakub Dębski <jdebski@enigma.com.pl>
> ---
>   lib/bb/fetch2/git.py | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 3de83be..6600e19 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -527,10 +527,13 @@ class Git(FetchMethod):
>           Return the repository URL
>           """
>           if ud.user:
> -            username = ud.user + '@'
> +            if ud.pswd:
> +                userinfo = ud.user + ':' + ud.pswd '@'
> +            else:
> +                userinfo = ud.user + '@'
>           else:
> -            username = ""
> -        return "%s://%s%s%s" % (ud.proto, username, ud.host, ud.path)
> +            userinfo = ""
> +        return "%s://%s%s%s" % (ud.proto, userinfo, ud.host, ud.path)
>   
>       def _revision_key(self, ud, d, name):
>           """
> 

