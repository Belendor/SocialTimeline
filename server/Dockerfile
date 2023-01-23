FROM python
EXPOSE 5000
WORKDIR /app
COPY . . 
RUN pip install -r requirements.txt 
ADD . /app

CMD [ "python", "app.py"]