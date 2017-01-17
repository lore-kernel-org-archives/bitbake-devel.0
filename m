Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f46.google.com (mail-it0-f46.google.com
	[209.85.214.46])
	by mail.openembedded.org (Postfix) with ESMTP id 122D265C5B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Jan 2017 15:18:27 +0000 (UTC)
Received: by mail-it0-f46.google.com with SMTP id r185so105668509ita.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Jan 2017 07:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=message-id:subject:from:to:date:in-reply-to:references:organization
	:mime-version:content-transfer-encoding;
	bh=AirE9PjIpNbhG1fCN5hZfMDK9hTyAjdTVa5agnljEHQ=;
	b=VW86F2oLN27HeL1mm+8Sb/nCsvL00F0sShsrc2X6odUBySZkvcTwwD+x5KiKTbPhvw
	cQXKOlWgmlxJjcAoEGDbuYM1Wm/ddBuZn32En8ocoecuEf3CXGHdj1uznoiPc03Xpe3X
	EcD91qJDnGkG0utUFn6zqD2p/tRUdn1LfZuHriapSTNWLD43VMu9Y+mTSEtMTPRiIXVN
	44F8oV1E6qDgwq/4NwG8r1PluL1G16O4Ol2RvyU2hPKhPz18QIpVImypMcS+YbSa2qPV
	kcJc7s8FKKiuyra8BrkC4sP2RdjpSAdE7ufYVfRgpAB0xLAfMJ9beJ33zXjhZIGtJP7m
	b13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:organization:mime-version:content-transfer-encoding;
	bh=AirE9PjIpNbhG1fCN5hZfMDK9hTyAjdTVa5agnljEHQ=;
	b=EUgKiiuElb0W0DmRmnzUcVJZE/3TeLlDl+iQQzQ4ruQFZ0e48c2X9d7pGqukWS6Nnn
	7YRY0HeV2l36aCSUOztDsQZSoa3HyoGRveToAwBpr4E1b69etGWg742qDJbCWz2Cy8i9
	P3tvFmTIH3J1Pyq7TJLA2T7k24ywiDzrWKdWee3FG4L05nDsh2qVqZkUfB6cB9T5iM8t
	AMYeSoCzBTn2496gQTHPnF7e0ygZIGLWtzbcjVJdYRkdouEFwxRCtjN0K2a5vkbBsl+e
	+XbGusPzx7Xw7McC3OFj6eAXCSjkJ1DPlsd4/SHCnw0+80pH9COT3fHB6URls/1zMj9U
	DIiQ==
X-Gm-Message-State: AIkVDXLxieMJ8ekfW0mM+Jn+SDl/dkXvtww8A3QL7zfkWpwVjo0UwaGZLDyRgdQ5AvSOWlKE
X-Received: by 10.36.249.6 with SMTP id l6mr19714802ith.32.1484666307765;
	Tue, 17 Jan 2017 07:18:27 -0800 (PST)
Received: from pohly-mobl1 (p57A56390.dip0.t-ipconnect.de. [87.165.99.144])
	by smtp.gmail.com with ESMTPSA id
	n30sm13089732ioe.32.2017.01.17.07.18.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 17 Jan 2017 07:18:26 -0800 (PST)
Message-ID: <1484666304.19478.63.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org, Ross Burton <ross.burton@intel.com>
Date: Tue, 17 Jan 2017 16:18:24 +0100
In-Reply-To: <8f61859759b1fe66f1e649ff341582bc51c93161.1484318890.git-series.patrick.ohly@intel.com>
References: <cover.5e5ac9bdeea438c2ba58f3b9b20503181c9f5340.1484318890.git-series.patrick.ohly@intel.com>
	<8f61859759b1fe66f1e649ff341582bc51c93161.1484318890.git-series.patrick.ohly@intel.com>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Subject: Re: [PATCH v2 3/3] runqueue.py: revised completion scheduler
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
X-List-Received-Date: Tue, 17 Jan 2017 15:18:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2017-01-13 at 15:51 +0100, Patrick Ohly wrote:
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 48c6a79..0c4f286 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -183,6 +183,18 @@ class RunQueueScheduler(object):
[...]
> +        super(RunQueueSchedulerRmwork, self).__init__(runqueue, rqdata)

The new line must be instead:
           super(RunQueueSchedulerCompletion, self).__init__(runqueue, rqdata)

Obviously I haven't tested enough after renaming the scheduler :-/

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.




