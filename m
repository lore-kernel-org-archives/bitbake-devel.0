Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R3DQP-00087Y-Dl
	for bitbake-devel@lists.openembedded.org;
	Mon, 12 Sep 2011 22:48:17 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 12 Sep 2011 13:43:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,370,1312182000"; d="scan'208";a="47963356"
Received: from unknown (HELO [10.255.14.51]) ([10.255.14.51])
	by azsmga001.ch.intel.com with ESMTP; 12 Sep 2011 13:43:02 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Sep 2011 13:42:51 -0700
In-Reply-To: <cover.1315406971.git.josh@linux.intel.com>
References: <cover.1315406971.git.josh@linux.intel.com>
X-Mailer: Evolution 3.0.3 (3.0.3-1.fc15) 
Message-ID: <1315860185.2184.14.camel@scimitar>
Mime-Version: 1.0
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
X-List-Received-Date: Mon, 12 Sep 2011 20:48:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-09-07 at 14:27 -0700, Joshua Lock wrote:
> This is an RFC patch.
> 
> I recently implemented a check within the hob gui to ensure that it's running with the
> required pre and post configuration files. However this check uses a variable from the data
> store which is a Python set container.
> 
> The Python xmlrpclib is unable to marshal sets and therefore the patch I added breaks hob
> when using the xmlrpc server backend.

"Why can't xmlrpclib marshal a set?" - I pretend to hear you ask.
xmlrpclib will only marshal objects with a type which can be serialized
to XML. A set has no direct XML equivalent, so the marshalling fails.

As alluded to in my original mail, we could approach this in alternative
ways. The most obvious being to add an extra step to serialise the set,
or any other passed objects, to some more appropriate form. We already
use the pickle module in various places and this is an obvious contender
here, however I'm not clear on how we would introduce this *just* for
the xmlrpc server.

Would profiling data make this change more palatable? If so what sort of
profiling would people like to see?

Comments appreciated,
Joshua
-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre



