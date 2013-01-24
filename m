Received: from eumx.net ([91.82.101.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ml@communistcode.co.uk>) id 1TyLPi-0008Cn-Sz
	for bitbake-devel@lists.openembedded.org;
	Thu, 24 Jan 2013 12:56:15 +0100
Message-ID: <51011737.8020501@communistcode.co.uk>
Date: Thu, 24 Jan 2013 11:12:55 +0000
From: Jack Mitchell <ml@communistcode.co.uk>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130109 Thunderbird/17.0.2
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
Subject: Graphviz folder
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
Reply-To: ml@communistcode.co.uk
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 24 Jan 2013 11:56:15 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I was wondering if there would be support or interest for a patch which 
puts generated graphviz and dependancy files into their own folder.

Currently bitbake -g image creates a multitude of files in the root 
folder and I feel it just gets a bit messy. I think a better solution 
would either be to put the files in their own folder e.g. graphviz (name 
to be decided) or in tmp/graphviz.

On the topic of graphviz I can't seem to find a supported application 
for viewing the files as a nice graph, is this format still relevant 
these days?

Thoughts?

-- 

   Jack Mitchell (jack@embed.me.uk)
   Embedded Systems Engineer
   http://www.embed.me.uk

--



