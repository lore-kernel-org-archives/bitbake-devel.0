Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TBZb7-0005cD-Lv
	for bitbake-devel@lists.openembedded.org;
	Wed, 12 Sep 2012 01:10:26 +0200
Received: by lban1 with SMTP id n1so677455lba.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Sep 2012 15:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=Bwu9cHOx/zPo6KIaGSbkSQAhe/UfUAnPyhyStts40lg=;
	b=nDzrdhFIGc2+hBcPjrSCmmCRGtaj9TBdsuYwuSOZ/GNf9UVJgX127XVpkiMjH2IDBr
	zpaauYcFbsVBcdsIqlb+KHSF172CgJhfwPxAsfC0myM8agWe7nEYtWrKD0EwiHgcs+74
	7+XCz4NHN8EzrcrgPdtCHdiI0+GstolhyOTrRtvcMavretS6V3/upUQP6k+J2MbYONAI
	ZhFh56sAIXz3QP/c8BLUFFMeY1SlGWLvvVMsTPSo4lcjS/+FGSrO20DYIRF/nsYExvhC
	5fWYludX5DCl5WutIbZoINZz7/4sU2RtKlWvMg36xh4pDuhLLMe7giRX187yEeYLXNgj
	PIkg==
Received: by 10.112.82.6 with SMTP id e6mr6792354lby.93.1347404264863; Tue, 11
	Sep 2012 15:57:44 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.114.19.2 with HTTP; Tue, 11 Sep 2012 15:57:24 -0700 (PDT)
In-Reply-To: <2b9acb9c7fca686d4df885152458cae2e22f2cc5.1347382193.git.paul.eggleton@linux.intel.com>
References: <cover.1347382193.git.paul.eggleton@linux.intel.com>
	<2b9acb9c7fca686d4df885152458cae2e22f2cc5.1347382193.git.paul.eggleton@linux.intel.com>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 11 Sep 2012 15:57:24 -0700
X-Google-Sender-Auth: VXapMcLRGsNToXy0C8_R5a-W_aU
Message-ID: <CABcZAN=_7d0ovDP6nHBTYCWbrs+QGF8bcinsNSrzQLSe3w14Aw@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/3] lib/bb/command.py: ensure setVariable only sets values as strings
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
X-List-Received-Date: Tue, 11 Sep 2012 23:10:30 -0000
Content-Type: text/plain; charset=UTF-8

On Tue, Sep 11, 2012 at 9:52 AM, Paul Eggleton
<paul.eggleton@linux.intel.com> wrote:
> This is the interface Hob uses to set variable values in many instances,
> and at the moment it is possible that some of the values it passes are
> not strings. If a non-string value gets into the datastore it can
> trigger exceptions during parsing when we attempt to expand the variable
> and substitute in the non-string value.
>
> This fixes using the meta-ti layer within Hob - it currently has a
> reference to BB_NUMBER_THREADS within a shell function and since this
> is a variable that Hob was setting from its configuration as an integer,
> due to the above this was triggering an ExpansionError.

This is probably a good change, but I think that failing expansion due
to a non-string value is a bad behavior in bitbake. I think it should
call str() on it as appropriate, as that's the most idiomatic
solution: Don't check if something is a string, don't require only
strings, but call str() to get your string
-- 
Christopher Larson


