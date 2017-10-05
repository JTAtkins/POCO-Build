//
// DateTime.cpp
//
// $Id: //poco/1.4/Foundation/samples/DateTime/src/DateTime.cpp#1 $
//
// This sample demonstrates the DateTime class.
//
// Copyright (c) 2004-2006, Applied Informatics Software Engineering GmbH.
// and Contributors.
//
// SPDX-License-Identifier:	BSL-1.0
//


#include "Poco/LocalDateTime.h"
#include "Poco/DateTime.h"
#include "Poco/DateTimeFormat.h"
#include "Poco/DateTimeFormatter.h"
#include "Poco/DateTimeParser.h"
#include "Poco/Timestamp.h"

#include <iostream>


using Poco::LocalDateTime;
using Poco::DateTime;
using Poco::DateTimeFormat;
using Poco::DateTimeFormatter;
using Poco::DateTimeParser;


int main(int argc, char** argv)
{
	//Assume we created the token at
	DateTime TokenCreatedTimeStamp;
	TokenCreatedTimeStamp.assign(2017, 4, 29, 12, 0, 0);
	INT64 expiresInSeconds = 100000;
	INT64 expiresInMicroSeconds = (expiresInSeconds * 1000000) - 45000000;

	Poco::Timestamp now; // the current date and time UTC
	Poco::Timestamp created = TokenCreatedTimeStamp.timestamp();

	Poco::Timestamp::TimeDiff expirationBuffer(expiresInMicroSeconds);
	Poco::Timestamp expires = created + expirationBuffer;

	if (expires > now)
	{
		int x = 0;
	}
	else
	{
		int y = 0;
	}
	
	std::string str = DateTimeFormatter::format(now, DateTimeFormat::ISO8601_FORMAT);
	DateTime dt;
	int tzd;
	DateTimeParser::parse(DateTimeFormat::ISO8601_FORMAT, str, dt, tzd);
	dt.makeUTC(tzd);
	LocalDateTime ldt(tzd, dt);
	return 0;
}
