Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.28857.1589744177346936346
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 17 May 2020 12:36:18 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: jean-marie.lemetayer@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 002869C0569;
	Sun, 17 May 2020 15:36:15 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id rYqDWE0oWRR7; Sun, 17 May 2020 15:36:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 224DC9C056A;
	Sun, 17 May 2020 15:36:15 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XwrzQ1sxq8J6; Sun, 17 May 2020 15:36:15 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 03B5A9C0569;
	Sun, 17 May 2020 15:36:15 -0400 (EDT)
Date: Sun, 17 May 2020 15:36:13 -0400 (EDT)
From: "Jean-Marie Lemetayer" <jean-marie.lemetayer@savoirfairelinux.com>
To: scott r ware <scott.r.ware@intel.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <1362346417.205735.1589744173909.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <160B37B21B884CF3.26218@lists.openembedded.org>
References: <SQOP.1588252294505167875.CgtT@lists.openembedded.org> <160B37B21B884CF3.26218@lists.openembedded.org>
Subject: Re: [bitbake-devel] NPMSW fetcher fails if recipes concurrently fetch the same dependencies
MIME-Version: 1.0
X-Mailer: Zimbra 8.8.11_GA_3737 (ZimbraWebClient - GC81 (Linux)/8.8.11_GA_3737)
Thread-Topic: NPMSW fetcher fails if recipes concurrently fetch the same dependencies
Thread-Index: BJOZcDuBH/T/Pu7mYmhlhPnCOHOdlGNXgR/0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Scott,

I have created a BZ to track the issue. Could you add some logs (if possible) ? Thanks
https://bugzilla.yoctoproject.org/show_bug.cgi?id=13903

Best regards,
Jean-Marie

On May 2, 2020, at 3:02 PM, Jean-Marie Lemetayer jean-marie.lemetayer@savoirfairelinux.com wrote:
> Hi Scott,
> 
> Since the npmsw fetcher only resolves urls that need to be fetched by other
> fetchers (wget or git), it seems to be a more global concurrent problem.
> 
> This is normally not supposed to happen because for regular recipes, a resource
> is linked to a recipe. If it is to be shared between several recipes, the
> keyword DEPENDS is used. For npm this is different because it would mean that
> thousands of recipes would have to be created to build npm applications.
> 
> The problem should be reproducible by creating several recipes with the same
> resource to fetch. And I think it has something to do with the lock file.
> 
> It's a difficult time right now and it's going to be hard for me to fix this
> problem but I'll try to look into it.
> 
> Best regards,
> Jean-Marie Lemetayer
> 
> On Apr 30, 2020, at 3:11 PM, scott r ware scott.r.ware@intel.com wrote:
>> I have updated several recipes to utilise the new npmsw fetcher: e.g. [
>> https://github.com/intel-iot-devkit/meta-iot-cloud/blob/master/recipes-node-red/node-red/node-red_1.0.2.bb
>> |
>> https://github.com/intel-iot-devkit/meta-iot-cloud/blob/master/recipes-node-red/node-red/node-red_1.0.2.bb
>> ]
>> 
>> The recipes build fine in isolation but if you are building an image and
>> multiple npm based recipes which have similar dependencies fetch in parallel
>> fetching fails.
>> 
>> My assumption is that if multiple npmsw fetch processes try and fetch the same
>> dependency concurrently the processes start fighting over the downloaded file
>> in 'downloads/npm2' which then leads to checksum errors and failures.
>> 
>> I think for npm dependency fetching with npmsw the downloads either need to be
>> tied to the package name or only allow a single npmsw fetching process to occur
>> at one time so the downloads can be re-used by other recipes.
>> 
>> 
> 
> 
