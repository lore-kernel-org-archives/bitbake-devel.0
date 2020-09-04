Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web10.734.1599234758468045595
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Sep 2020 08:52:39 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 084FqWZL010323
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Fri, 4 Sep 2020 17:52:33 +0200
Received: from [167.87.129.156] ([167.87.129.156])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 084FqTpR009541
	for <bitbake-devel@lists.openembedded.org>; Fri, 4 Sep 2020 17:52:31 +0200
To: bitbake-devel@lists.openembedded.org
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: "Resolving any missing task queue dependencies" - info or debug?
Message-ID: <f6dcb541-6540-6aa6-4fd4-3a651f950452@siemens.com>
Date: Fri, 4 Sep 2020 17:52:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi all,

it seems al ready every multiconfig entry triggers one line of

NOTE: Resolving any missing task queue dependencies

when starting bitbake. But there must be more source. I have setup here
that emits 42 of these lines.

Is that really so informative that it deserves logger.info? Or should it
rather be logger.debug? Which level then?

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
