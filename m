Received: from anchovy2.45ru.net.au (anchovy2.45ru.net.au [203.30.46.146])
 by mx.groups.io with SMTP id smtpd.web12.605.1592887052870147584
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Jun 2020 21:37:33 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: electromag.com.au, ip: 203.30.46.146, mailfrom: preid-l@electromag.com.au)
Received: (qmail 21770 invoked by uid 5089); 23 Jun 2020 04:37:26 -0000
Received: by simscan 1.2.0 ppid: 21725, pid: 21726, t: 0.0667s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Return-Path: <preid-l@electromag.com.au>
Received: from unknown (HELO ?192.168.0.22?) (preid@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 23 Jun 2020 04:37:26 -0000
To: bitbake-devel@lists.openembedded.org
From: preid-l@electromag.com.au
Subject: SSTATE_MIRRORS uri format
Message-ID: <85456da9-ddd5-7054-32c7-93b9b7467020@electromag.com.au>
Date: Tue, 23 Jun 2020 12:37:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit

When setting up a SSTATE_MIRRORS with a https basic auth I had to use:
SSTATE_MIRRORS ?= "file://.* https://<ip>/sstate-${DISTRO_VERSION}/PATH;user=<USER>;pswd=<PSWD>"

Instead of what seemed to be the documented format:
SSTATE_MIRRORS ?= "file://.* https://<USER>:<PSWD>@<ip>/sstate-${DISTRO_VERSION}/PATH"

I run bitbake with -DDD and it locked to parsing the user / pswd fields with the second option.
But it never actually connected to the server.

ie this debug message was showing the user/pswd being decoded.
     logger.debug(2, "For url %s comparing %s to %s" % (uri_decoded, uri_find_decoded, uri_replace_decoded))

This is using tag 2019-10.3-zeus, so may already be fixed, or I'm reading the wrong docs.

