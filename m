Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id D91B1605F2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 21:57:16 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GMBOAP030394; Mon, 16 Sep 2013 23:11:25 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id XQ5NPz4PuJxc; Mon, 16 Sep 2013 23:11:24 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GMBM8O030389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 16 Sep 2013 23:11:24 +0100
Message-ID: <1379368625.32201.89.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Sep 2013 22:57:05 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH 00/16] Various performance improvements to parsing
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
X-List-Received-Date: Mon, 16 Sep 2013 21:57:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This patch series fixes up profiling of the parsing processes and then
uses that to find some performance improvements in parsing speed. What
follows is a quick overview of what each patch is worth using "time".
The data was confirmed in the actual profiles through a reduction in
function calls, this is really just an interesting side by side
comparison of the significance of each change:

real	0m31.700s
user	1m49.140s
sys	0m2.272s

#### Baseline ####

real	0m31.498s
user	1m48.448s
sys	0m2.380s

#### data: Be explicit in data_db check

real	0m31.079s
user	1m47.420s
sys	0m2.400s

#### siggen: Use lookup cache exclusively

real	0m30.890s
user	1m46.684s
sys	0m2.492s

#### data_smart: Improve variable expansion regexp

real	0m30.547s
user	1m44.124s
sys	0m2.292s

#### data_smart: use the expand_cache in VariableParse

real	0m29.750s
user	1m41.240s
sys	0m2.536s

#### data: Use direct iteration, not keys()

real	0m28.610s
user	1m38.096s
sys	0m2.304s

#### data: Cache an list of export variables

real	0m28.718s
user	1m38.080s
sys	0m2.344s

### data_smart: Add explict None checks

real	0m28.726s
user	1m37.924s
sys	0m2.568s

### data_smart: Allow expansion of flags in getVarFlags

real	0m28.947s
user	1m38.564s
sys	0m2.644s

### data_smart: Allow flags to use the expand cache

real	0m29.135s
user	1m38.816s
sys	0m2.280s

### data_smart: Cache the fact a variable accesses another even if its
unset

real	0m28.250s
user	1m36.132s
sys	0m2.340s

### data: Optimise flag exclusion list handling

real	0m28.584s
user	1m36.116s
sys	0m2.376s

### data: Optimise flag lookup in build_dependencies

real	0m26.662s
user	1m28.952s
sys	0m2.296s

### data: Optimise build_dependencies a little

Cheers,

Richard




