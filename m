Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rep.dot.nop@gmail.com>) id 1R3Sbk-0005Ud-UD
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Sep 2011 15:01:00 +0200
Received: by fxi1 with SMTP id 1so509988fxi.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Sep 2011 05:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=e2hjneq8UuK1dCCVJx3RZnVWxj0HQUSD+QJFwPeJhtY=;
	b=XLRxvvMgEGj1Qptu6iQUGqVpHVfK2sLOiueyrG7kxu+KV7GuegzvcDXX4+FYAM/Z8d
	6Si+949xuq88f4zesBGgGeD8kXSiPO0Kb17LlhEI2kGbDMWQF3CmVSAieyaM1fygtDnm
	fexUK0s5EeN6ZUFl3hn5ojFd/qECprmwo9XaQ=
Received: by 10.223.58.209 with SMTP id i17mr1951929fah.22.1315918550023;
	Tue, 13 Sep 2011 05:55:50 -0700 (PDT)
Received: from s42.loc (85-127-90-88.dynamic.xdsl-line.inode.at.
	[85.127.90.88])
	by mx.google.com with ESMTPS id h22sm346706fag.15.2011.09.13.05.55.47
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 13 Sep 2011 05:55:48 -0700 (PDT)
Received: from cow by s42.loc with local (Exim 4.76)
	(envelope-from <rep.dot.nop@gmail.com>)
	id 1R3SWg-0008Ot-Q3; Tue, 13 Sep 2011 14:55:46 +0200
Date: Tue, 13 Sep 2011 14:55:46 +0200
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: Joshua Lock <josh@linux.intel.com>
Message-ID: <20110913125546.GB21210@mx.loc>
References: <cover.1315406971.git.josh@linux.intel.com>
	<1315860185.2184.14.camel@scimitar>
MIME-Version: 1.0
In-Reply-To: <1315860185.2184.14.camel@scimitar>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC PATCH 0/1] Don't use set() for datastore variables
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
X-List-Received-Date: Tue, 13 Sep 2011 13:01:01 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 12, 2011 at 01:42:51PM -0700, Joshua Lock wrote:
>On Wed, 2011-09-07 at 14:27 -0700, Joshua Lock wrote:
>> This is an RFC patch.
>> 
>> I recently implemented a check within the hob gui to ensure that it's running with the
>> required pre and post configuration files. However this check uses a variable from the data
>> store which is a Python set container.
>> 
>> The Python xmlrpclib is unable to marshal sets and therefore the patch I added breaks hob
>> when using the xmlrpc server backend.
>
>"Why can't xmlrpclib marshal a set?" - I pretend to hear you ask.
>xmlrpclib will only marshal objects with a type which can be serialized
>to XML. A set has no direct XML equivalent, so the marshalling fails.
>
>As alluded to in my original mail, we could approach this in alternative
>ways. The most obvious being to add an extra step to serialise the set,
>or any other passed objects, to some more appropriate form. We already
>use the pickle module in various places and this is an obvious contender
>here, however I'm not clear on how we would introduce this *just* for
>the xmlrpc server.
>
>Would profiling data make this change more palatable? If so what sort of
>profiling would people like to see?

Are you talking about f7c69462b8ba726861898817cc5b13174c78e35a ?

If you want to revert it then you may of course do so.
Without knowing that rpc thing, may i suggest you teach it to deal with
sets or, short of that, just handle them as list on the transport layer?

regards,


