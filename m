Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
	[209.85.221.43])
	by mail.openembedded.org (Postfix) with ESMTP id 664A17DF72
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Jun 2019 09:03:51 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id r16so1740161wrl.11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Jun 2019 02:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=MwI4O38y7GD+9vi8ggZpqf48Jw5JPHudkgbDy5d/7PE=;
	b=cRx8E7mwhdrzuagGaAQlRR8IXkPllJlVb7osGM+z63sit67zJMzA3Lk4IZmZnF8tr2
	rwUXLwVE6lWLqvpcdeu/eYp0kYFiBcVyv7+Zy+ToiWh8fKLr3RJW4+eTA58zLVvMJAtX
	PD0IxiETpVMu3noRjP0dy+3LXMqsmDtCKQwH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=MwI4O38y7GD+9vi8ggZpqf48Jw5JPHudkgbDy5d/7PE=;
	b=naJmhJ8eBOPb5Z/OQ7wnrZQPJrlJW5cShFO1hmvBvhUn94jcwaarJAvUdjMjrwYcMb
	C9hf3DJX0wS7S7hqLSOBwaYhGZguy2gFsYAVO7ab4g240lxpS6l84ml9S7T1Oby9cAJb
	DOC/u2VbkuTSZlbXXUoDcOuWgplRaaWJOzpO0BGP9dWYI/ARq2hIc06rnfBxlwP3RE09
	UtCEDS9PQDXul1bmHcOl5O+OXyFZjQs+lifw2v2DBjqZXR/dkeaVA5MVEHmRkKk8i9N5
	RRfqXr3aoKfnVvO9GcVZdWkLBcFuVtydu1qkWb9aYbMarI72Wb0B+R8ggR5aQAAn+Zv0
	XdFw==
X-Gm-Message-State: APjAAAUZnF3OtiLMN37l+kATkIX+cjM3XiK/Hsih8WlYfiJb7b0Se2Ji
	8/xvMC7Pdxy3/GC7zrd0j0va/Q==
X-Google-Smtp-Source: APXvYqzHF/p/A89FU6wgV8wWZsAw9vN8VtNQ5CXpZ9+8VECUYPo+FHpuCn8uQJLR/7OT3kKd1MQCKA==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr2596326wrv.268.1561539832214; 
	Wed, 26 Jun 2019 02:03:52 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	g195sm1211052wmg.26.2019.06.26.02.03.51
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 26 Jun 2019 02:03:51 -0700 (PDT)
Message-ID: <9ed042dccd7b90d0d530b8e5d18e6a3be47312b0.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Robert Yang <liezhi.yang@windriver.com>
Date: Wed, 26 Jun 2019 10:03:50 +0100
In-Reply-To: <901a2f37-99f2-57c5-923e-35c0cf92a1f5@windriver.com>
References: <901a2f37-99f2-57c5-923e-35c0cf92a1f5@windriver.com>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: #!/usr/bin/env python in bitbake files
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
X-List-Received-Date: Wed, 26 Jun 2019 09:03:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2019-06-26 at 16:35 +0800, Robert Yang wrote:
> Hi RP,
> 
> I think that bitbake supports python3 years ago, but some files still
> use "#!/usr/bin/env python" as shebang:
> 
> lib/bb/monitordisk.py:#!/usr/bin/env python
> lib/bb/runqueue.py:#!/usr/bin/env python
> lib/bb/taskdata.py:#!/usr/bin/env python
> lib/bb/main.py:#!/usr/bin/env python
> lib/bb/cookerdata.py:#!/usr/bin/env python
> lib/bb/parse/parse_py/__init__.py:#!/usr/bin/env python
> lib/bb/parse/parse_py/ConfHandler.py:#!/usr/bin/env python
> lib/bb/parse/parse_py/BBHandler.py:#!/usr/bin/env python
> lib/bb/namedtuple_with_abc.py:#!/usr/bin/env python
> lib/bb/cooker.py:#!/usr/bin/env python
> lib/pyinotify.py:#!/usr/bin/env python
> 
> And also a lot of files in lib/toaster/tests/.
> 
> Should we update them, please? Or should these files support python2?

We should fix them, or in some cases remove the shebang as the files
aren't designed/capable of being run directly.

Cheers,

Richard


