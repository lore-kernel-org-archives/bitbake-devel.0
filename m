Received: from mail-ve0-f181.google.com ([209.85.128.181])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <schnitzeltony@googlemail.com>) id 1U89Rd-0002rD-KL
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Feb 2013 14:10:47 +0100
Received: by mail-ve0-f181.google.com with SMTP id d10so6692530vea.26
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Feb 2013 04:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=googlemail.com; s=20120113;
	h=mime-version:x-received:date:message-id:subject:from:to
	:content-type; bh=ZSvViNKIiARfEjs+ikHVaMFTI7e7AvzfhIrfqEv6ikM=;
	b=t6zirp0nEzBBojvPouQgBwf03/WG2XdQb2MUjenGHNkoQdo87X41Iw7yORsI4OdETT
	Ff9BoszAfn6MziMPJBs00eV65qkAiGKUn8Bb6yY172tS/k3ewApxXHngZJRNq4iB7mR5
	mO/z1MO8nl9ZofH9hf0+bPSn2BV7v5vZZ2V/3cPYEcxRBT7OX26MuylJXk6vU4tnOAse
	1ZeHimvdaFW6J/+tJWhGvErU4eXVpT9AAcxRKzw0+5q5a9HtEkCJsaEYcxc+IPmzJBuh
	TldRfsnJ4ep9mUin5nIxycHF+dvGk5cGsqlr+BB7V14rrVeIuM0ITeD1IarL+VAFEVEH
	m9nA==
MIME-Version: 1.0
X-Received: by 10.52.88.237 with SMTP id bj13mr22390007vdb.75.1361364874352;
	Wed, 20 Feb 2013 04:54:34 -0800 (PST)
Received: by 10.52.185.168 with HTTP; Wed, 20 Feb 2013 04:54:34 -0800 (PST)
Date: Wed, 20 Feb 2013 13:54:34 +0100
Message-ID: <CALbNGRRDr+6vLtJRDgRi1NbO+s0sUB5TLT7uTck5L5La6xfDQw@mail.gmail.com>
From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@googlemail.com>
To: bitbake-devel@lists.openembedded.org
Subject: trouble during parsing
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
X-List-Received-Date: Wed, 20 Feb 2013 13:10:47 -0000
Content-Type: text/plain; charset=UTF-8

Hi,

with current bitbake master I get

ERROR: Command execution failed: Traceback (most recent call
last):#########################################################
                              | ETA:  00:00:17
  File "/home/andreas/oe-core/sources/bitbake/lib/bb/command.py", line
92, in runAsyncCommand
    self.cooker.updateCache()
  File "/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py", line
1330, in updateCache
    if not self.parser.parse_next():
  File "/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py", line
1703, in parse_next
    self.virtuals += len(result)
TypeError: object of type 'ExpansionError' has no len()

Any ideas?

Andreas


