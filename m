Received: from mail-vc0-f176.google.com ([209.85.220.176])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <wmat@alphatroop.com>) id 1UUNR5-0008PV-Uh
	for bitbake-devel@lists.openembedded.org;
	Mon, 22 Apr 2013 22:34:09 +0200
Received: by mail-vc0-f176.google.com with SMTP id hf12so6489454vcb.7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Apr 2013 13:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=x-received:mime-version:x-originating-ip:in-reply-to:references
	:from:date:message-id:subject:to:content-type:x-gm-message-state;
	bh=N8IaMstEE4bmYi/DgKmUsQ9u+qP1RlXN6fHMghrzDSM=;
	b=DL1ZLQQbZajNvAo98IygYefBmda/RIwd/RvT4+2okvPez3BPI0FrfRYzVmeT9eJrJB
	LAOnNGrS2esspI/Uhu2o8cTWQSw74BOawCnbJ7L30kzqYNJHFyk18UoVxXl1brYTFuaI
	tB9qBjZ3UYbu3rTHTfF/1HA8V9sibUfuQJvjeCgaBEfifvAC6M2tb/HAP6u5Po9ZQPVr
	4+gnTVw06RkD+DQ9S5qDoKhd64atFmE6ACmk01UhFB8gEzcLuGcqz7zStWaaJEWMkUwP
	2wbaMtpa75C7iW72NZQs1ohVFQO5AsoPJS85B9T6RwdnHkys8j/+upOq/1G2Tra3s7TU
	YVGA==
X-Received: by 10.220.46.197 with SMTP id k5mr20447204vcf.40.1366661784193;
	Mon, 22 Apr 2013 13:16:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.58.4 with HTTP; Mon, 22 Apr 2013 13:16:04 -0700 (PDT)
X-Originating-IP: [24.246.30.132]
In-Reply-To: <CAGfZjq6Ldap337bm21g286gkjgtBS45ti68JwrAtWb1t+fKZEw@mail.gmail.com>
References: <CAGfZjq6Ldap337bm21g286gkjgtBS45ti68JwrAtWb1t+fKZEw@mail.gmail.com>
From: "William M.A. Traynor" <wmat@alphatroop.com>
Date: Mon, 22 Apr 2013 16:16:04 -0400
Message-ID: <CAGfZjq5JzJDwDuFQoKv8tCNq6hAFARAhVH+eQdaT=nVa7Zs03w@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Gm-Message-State: ALoCoQnBAZh/eskjL9y+AfWchHRW8+/f9fDehngczaLb9K+SizTmQ/an+2FOQOYT2S4bwFPVZ7bC
Subject: Re: Accessing Variables and the Data Store from Python
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
X-List-Received-Date: Mon, 22 Apr 2013 20:34:11 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Apr 22, 2013 at 3:15 PM, William M.A. Traynor
<wmat@alphatroop.com> wrote:
> Hey there,
>
> I'm expanding the documentation in the BitBake manual regarding
> accessing variables and the data store from Python.  Is there a
> particular source tree where I can see good examples of this
> occurring?
>
> I grepped the OE repo for methods such as "d.apendVarFlag" and
> "d.prependVarFlag" but did not find any instances.  I'm grepping the
> Poky repo now.

A bunch turned up in the Poky tree.

>
> Thanks
> Bill


