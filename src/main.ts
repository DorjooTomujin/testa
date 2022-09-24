import { ValidationPipe } from "@nestjs/common";
import { NestFactory } from "@nestjs/core";
import { DocumentBuilder, SwaggerCustomOptions, SwaggerDocumentOptions, SwaggerModule } from "@nestjs/swagger";
import { AppModule } from "./app.module";

async function bootstrap() {
  // RestAPI
  const port = process.env.PORT || 3001
  const app = await NestFactory.create(AppModule, {cors:true});
  app.useGlobalPipes(new ValidationPipe());
  app.setGlobalPrefix("v1");

  app.enableCors({
    origin        : '*',
    methods       : 'GET, PUT, POST, DELETE',
    allowedHeaders: 'Content-Type, Authorization',
  });

  const config = new DocumentBuilder()
    .setTitle("Swagger API")
    .setDescription("Nothing special")
    .setVersion("1.0")
    .addBearerAuth({
      type: "http",
      scheme: "bearer",
      bearerFormat: "JWT",
      name: "Authorization",
      in: "header",
    }, 'access-token')
    .build();

    const options: SwaggerDocumentOptions =  {
      operationIdFactory: (
        _controllerKey: string,
        methodKey: string
      ) => methodKey,
    };
    const customOptions: SwaggerCustomOptions = {
      swaggerOptions: {
        tagsSorter: 'alpha'
      },
      customSiteTitle: 'Swagger API',
    }


  const document = SwaggerModule.createDocument(app, config, options);
  SwaggerModule.setup("v1/docs", app, document, customOptions);

  await app.listen(port);

  console.log("Listening "+port)
}
bootstrap();
