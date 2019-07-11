Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 782307F079
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 11:33:13 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id r1so5897318wrl.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 04:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=+97rnehGKbnux4KdtzWc6NwuDWHhlEMyMQyomLC6Z/w=;
	b=JKkXcPM2gvU5Rsn2PAwFu9au1oxWeJRT3jjRR/8KA5OVhEGdE0wzLJQ23LbDMSG+5A
	9nQjql5UIoAEqCrVuWPoWBObVEu1aclrLt/kd3CMfx/lLXSl2coXaaDe3b7UlEHOBd1s
	wCytvmbpInYo2HFt6mUvdpGO7cb9poKOjBcOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=+97rnehGKbnux4KdtzWc6NwuDWHhlEMyMQyomLC6Z/w=;
	b=HATEpzceqmSWcd2d8rdPU9t7SodxvxpADt6EM1GhTPPL53mx7tk+FnEAj29CkZMWWs
	Slv+ZxsgMgeDcjn7de/PekSb/ZynUJBEC5UuNiZgtshX4H9H8pVs5ctHVlzX7vLl3xxJ
	pxVjKeTguFeRWmQwZNs9oUDAd6aBSpFSuGIjW2NbVwvPsgCVwToRlPuZ7qvTaqJ2/bku
	Rqx77qKzWDhqyB8MhfQVHqBxWoExnK8/5fp6n57VjdrFFBffJ7gA+2fn58HAoBE3B72G
	JmY7Q2iKIgUYApdNarY9BH6rdw2OoqwP9LtahM1cd1GqbTg1oR2N6Cw6kwp+lM4g4fTi
	IJtA==
X-Gm-Message-State: APjAAAXZxOnmwfEG//Wjnjr/eQcV5VHOuKrK9dwhwfz2IO/CYODlBAh4
	GZ3tW9gaXulTfVmOwwfCpafM+3EoWO4=
X-Google-Smtp-Source: APXvYqzkCipvxKoiqyDa3NuHzoCiiEW859NnA7NgU2w9P7jPMM9OURAWXEevwe2U/0qaJwxsBUTyJQ==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr4846732wru.312.1562844794143; 
	Thu, 11 Jul 2019 04:33:14 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	t24sm5321454wmj.14.2019.07.11.04.33.13
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 11 Jul 2019 04:33:13 -0700 (PDT)
Message-ID: <0469809c35209843bd5ac8bfad98928b775c6c35.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Jacob Kroon <jacob.kroon@mikrodidakt.se>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Thu, 11 Jul 2019 12:33:12 +0100
In-Reply-To: <63270c2a-f78a-65e1-16c0-8ce271d4dd8e@mikrodidakt.se>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
	<8ace64fd460c657fee23dd39887825e418314c5e.camel@linuxfoundation.org>
	<63270c2a-f78a-65e1-16c0-8ce271d4dd8e@mikrodidakt.se>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Subject: Re: [PATCH 00/26] runqueue changes
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
X-List-Received-Date: Thu, 11 Jul 2019 11:33:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-07-11 at 10:57 +0000, Jacob Kroon wrote:
> Exciting to see steps towards the sstate hash equivalence thing!
> 
> I tested master-next, 6ff6485fa9195055ab6057527c6388f6c013cb8d, and
> got:
> 
> Sstate summary: Wanted 1152 Found 579 Missed 573 Current 0 (50%
> match,
> 0% complete)
> NOTE: Executing Tasks
> Traceback (most recent call last):
>    File "<snip>/bitbake/lib/bb/ui/knotty.py", line 480, in main
>      termfilter.updateFooter()
>    File "<snip>/bitbake/lib/bb/ui/knotty.py", line 291, in
> updateFooter
>      content = self.main_progress.update(progress)
>    File "<snip>/bitbake/lib/progressbar/progressbar.py", line 256, in
> update
>      raise ValueError('Value out of range')
> ValueError: Value out of range
> 
> Restarted the build, and now its running...

Thanks, I think this is the UI not understanding both sets of tasks run
in parallel. There is a patch added to -next and on the list which
hopefully should stop the above happening (I couldn't reproduce it
though).

Cheers,

Richard


