Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TBqXE-0002u5-LR
	for bitbake-devel@lists.openembedded.org;
	Wed, 12 Sep 2012 19:15:32 +0200
Received: by lagv3 with SMTP id v3so1149283lag.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Sep 2012 10:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=RAB4cgcifffMTJ2yr1KgvdGQdvhPYmNhpzqJcYgwQ7I=;
	b=jIQ//bGzCVnXKuOUi67VLgrDPfJftH688PsMYxfip+pxaT32xQw7vetBNquKc0s8a2
	mAk6afZMMkVEhRSjNtkbO5O4FjFvHhcqldrP1Vh5SG3r9T42zRgYhvjDB1nQSvtte35Q
	N3UpjSSWkkytABPcnx5CPAzArWqhl0kqMq86ul7bB9ZgqN7wOYCKmf6vFlUpdDCvtM44
	GT8v5pMIlanco7PduGGaRbawiXIAQTAhIt1Nt5bvpqedLVumB8TJ4HWBpBLdrrazK22t
	wQhGK7Dh5TdVfKDd5kkvlaSbMRaDA98Vnwdn9sVlhsYdIF4Z0tmAHXl6B+610BtbgPsN
	+bBA==
Received: by 10.112.51.174 with SMTP id l14mr7787454lbo.24.1347469380311; Wed,
	12 Sep 2012 10:03:00 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.114.19.2 with HTTP; Wed, 12 Sep 2012 10:02:39 -0700 (PDT)
In-Reply-To: <1347356243-7920-1-git-send-email-paul.eggleton@linux.intel.com>
References: <1347356243-7920-1-git-send-email-paul.eggleton@linux.intel.com>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 12 Sep 2012 10:02:39 -0700
X-Google-Sender-Auth: D3ixgTv8D4U7CUPZ2Mdv5lvy6dg
Message-ID: <CABcZAN=ZgKVtUrKW4BuD-TkLTC1LMD8oBN_wc=ymM6fS1nvS6Q@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] lib/bb/event: improve handling of event queue on exit
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
X-List-Received-Date: Wed, 12 Sep 2012 17:15:32 -0000
Content-Type: text/plain; charset=UTF-8

On Tue, Sep 11, 2012 at 2:37 AM, Paul Eggleton
<paul.eggleton@linux.intel.com> wrote:
> If BitBake exits before a UI handler (server) has been registered, we
> print the event queue; if there are any errors or other non-debug
> messages just print these and suppress the rest of the message queue.
>
> This improves the output when sanity check failures occur with OE-Core
> by avoiding printing a long stream of uninformative debug messages.
>
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>

+1

This one is biting us, obscuring the useful sanity check messages.

Acked-by: Christopher Larson <chris_larson@mentor.com>
-- 
Christopher Larson


